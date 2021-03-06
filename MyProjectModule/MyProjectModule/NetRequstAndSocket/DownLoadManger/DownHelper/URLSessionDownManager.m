//
//  URLSessionDownManager.m
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2019/5/16.
//  Copyright © 2019 xinxin. All rights reserved.
//

/**
 Documents 文件夹
 作用: 保存应用运行时生成的需要持久化的数据,iTunes同步设备时会备份该目录.所以一般这里面的文件一般不要太大

 tmp文件夹
 作用: 保存应用运行时所需的临时数据,使用完毕后再将相应的文件从该目录删除.应用没有运行时,系统也可能会清除该目录下的文件,所以需要持久化的数据一般不放到这个文件夹下.iTunes同步设备时不会备份该目录

 Library/Caches文件夹
 作用: 保存应用运行时生成的需要持久化的数据,iTunes同步设备时不会备份该目录.一般存储体积大,不需要备份的非重要数据

 Library/Preference文件夹
 作用: 保存应用的所有偏好设置,NSUserDefaults用户设置生成的plist文件也会保存到这个目录下,iTunes同步设备时会备份该目录
 
-  NSURLSessionTask
 
  - NSURLSessionDownloadTask 下载任务不需要内存拼接data,NSURLSession创建本地临时文件,写到临时文件,优化内存
     使用NSURLSessionDownloadTask下载文件,系统默认存放在tmp中,所以必须要自己剪切到其他位置
  - NSURLSessionDataTask
     需要自己去写数据
 
 一个NSURLSession
 多个Task下载

 对于创建的task，如果其响应处理的方式为通过上述delegate代理借口的方式处理：

 若delegateQueue = nil，则不管session执行的线程为主线程还是子线程，block中的代码执行线程均为任意选择的子线程；

      若delegateQueue = [NSOperationQueue mainQueue],则不管session执行的线程为主线程还是子线程，则block中的代码执行线程为主线程中执行；

      若delegateQueue = [[NSOperationQueue alloc] init]，则不管session执行的线程为主线程还是子线程，block中的代码执行线程均为任意选择的子线程
      
 多启动几个Task，看如下打印结果。
 发现NSURLSession的并发由系统控制了，至于并发数是多少呢？或者说线程池怎样控制呢？，我们不知道，只知道系统会控制好的。不用自己操心当然是好事啦，但是并不是每次都是好事，有时候我们需要调优，怎么办呢？例如在做图片下载的时候，我们是需要控制并发的，不然内存占用会比较高，甚至崩溃了。

 下面看看AFN的是怎样做的。部分代码如下： 可以开启多线程 最大并发1
 self.operationQueue = [[NSOperationQueue alloc] init];
 self.operationQueue.maxConcurrentOperationCount = 1;
 self.session = [NSURLSession sessionWithConfiguration:self.sessionConfiguration delegate:self delegateQueue:self.operationQueue];

 AFN统一为代理配置了一个单线程队列，然后通过GCD并发处理响应完成的数据。当然你也可以设置主线程队列为代理队列，这样就可以在代理里面操作UI了。但是AFN为什么要统一配置一个单线程代理队列呢？我猜是方便任务管理。

 
 */

// 缓存主目录
#define XXDownloadTool_Document_Path                   [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]

// 下载文件夹路径
#define XXDownloadTool_DownloadDataDocument_Path       [XXDownloadTool_Document_Path stringByAppendingPathComponent:@"XXDownloadTool_DownloadDataDocument_Path"]
// 保存下载文件状态的文件路径
#define XXDownloadTool_DownloadSources_Path            [XXDownloadTool_Document_Path stringByAppendingPathComponent:@"XXDownloadTool_downloadSources.data"]


#define XXDownloadTool_OffLineStyle_Key                @"XXDownloadTool_OffLineStyle_Key"

#define XXDownloadTool_OffLine_Key                     @"XXDownloadTool_OffLine_Key"

#define XXDownloadTool_Limit                           1024.0


#import "URLSessionDownManager.h"
#import "AppDelegate+DownManagerHelper.h"


#pragma mark - XXDownItem

@interface XXDownItem ()

@property (strong, nonatomic) NSFileHandle *fileHandle;

@end

@implementation XXDownItem

// 持久化
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.netPath = [aDecoder decodeObjectForKey:@"netPath"];
        self.filedownState = [aDecoder decodeIntegerForKey:@"filedownState"];
        self.task = nil;
        self.fileName = [aDecoder decodeObjectForKey:@"fileName"];
        self.location = [XXDownloadTool_DownloadDataDocument_Path stringByAppendingPathComponent:self.fileName];
        self.totalBytesWritten = [aDecoder decodeInt64ForKey:@"totalBytesWritten"];
        self.totalBytesExpectedToWrite = [aDecoder decodeInt64ForKey:@"totalBytesExpectedToWrite"];
        self.offLine = [aDecoder decodeBoolForKey:@"offLine"];
    }
    
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.netPath forKey:@"netPath"];
    [aCoder encodeObject:self.location forKey:@"location"];
    [aCoder encodeInteger:self.filedownState forKey:@"filedownState"];
    [aCoder encodeObject:nil forKey:@"task"];
    [aCoder encodeObject:self.fileName forKey:@"fileName"];
    [aCoder encodeInt64:self.totalBytesWritten forKey:@"totalBytesWritten"];
    [aCoder encodeInt64:self.totalBytesExpectedToWrite forKey:@"totalBytesExpectedToWrite"];
    [aCoder encodeBool:self.offLine forKey:@"offLine"];
}

// GET-SET
- (NSFileHandle *)fileHandle
{
    if (_fileHandle == nil) {
        NSURL *url = [NSURL fileURLWithPath:self.location];
//        NSLog(@"-----------%@", self.location);
        _fileHandle = url ? [NSFileHandle fileHandleForWritingToURL:url error:nil] : nil;
    }
    
    return _fileHandle;
}

// set修改下载状态
-(void)setFiledownState:(XXDownloadState)filedownState{
    
    if ([self.delegate respondsToSelector:@selector(downloadSource:changedState:)]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.delegate downloadSource:self changedState:filedownState];
            
        });
    }
    
    _filedownState = filedownState;
    
}
- (void)setNetPath:(NSString *)netPath
{
    _netPath = netPath;
}
- (void)setLocation:(NSString *)location
{
    _location = location;
}
- (void)setTask:(NSURLSessionDataTask *)task
{
    _task = task;
}
- (void)setFileName:(NSString *)fileName
{
    _fileName = fileName;
}
- (void)setTotalBytesWritten:(int64_t)totalBytesWritten
{
    _totalBytesWritten = totalBytesWritten;
}
- (void)setTotalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    _totalBytesExpectedToWrite = totalBytesExpectedToWrite;
}


@end


#pragma mark - URLSessionDownManager
@interface URLSessionDownManager ()<NSURLSessionDataDelegate>

@property (strong, nonatomic) NSMutableArray *downloadSources;

@property (strong, nonatomic) NSMutableArray *delegateArr;

/// 数据任务将在其中运行的会话
@property (strong, nonatomic) NSURLSession *downLoadsession;

/// 下载最大并发
@property (strong, nonatomic, nonnull) NSOperationQueue *downloadQueue;

@end

@implementation URLSessionDownManager

static URLSessionDownManager *_shareInstance;


#pragma mark - LifeCycle

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    // 销毁session 和 downloadQueue
    [self.downLoadsession invalidateAndCancel];
    self.downLoadsession = nil;
    [self.downloadQueue cancelAllOperations];
}

#pragma mark - 初始化 downLoadsession 和 downloadQueue
- (NSURLSession *)downLoadsession
{
    if (_downLoadsession== nil) {
        // 创建下载并发队列
        _downloadQueue = [[NSOperationQueue alloc] init];
        _downloadQueue.maxConcurrentOperationCount = 6;
        _downloadQueue.name = @"com.hackemist.DownHelper";
    
        /**
         *  Create the session for this task
         *  We send nil as delegate queue so that the session creates a serial operation queue for performing all delegate
         *  method calls and completion handler calls.
         */
        //可以上传下载HTTP和HTTPS的后台任务(程序在后台运行)。 在后台时，将网络传输交给系统的单独的一个进程,即使app挂起、推出甚至崩溃照样在后台执行。
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:@"XXDownload"];
        // 超时时间
        configuration.timeoutIntervalForRequest = 15;
        /**
         由于支持后台下载的URLSession的特性，系统会限制并发任务的数量，以减少资源的开销。同时对于不同的 host，就算httpMaximumConnectionsPerHost设置为 1，也会有多个任务并发下载，所以不能使用httpMaximumConnectionsPerHost来控制下载任务的并发数
         */
        configuration.HTTPMaximumConnectionsPerHost = 3;
        
        
        
        // 创建NSURLSession代码，有三个参数，1、指定配置，2、设置代理 3、队列代理<回掉的>
        _downLoadsession= [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    }
    
    return _downLoadsession;
}


+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareInstance = [[self alloc] init];
    });
    
    return _shareInstance;
}


+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareInstance = [super allocWithZone:zone];
        [[NSNotificationCenter defaultCenter] addObserver:_shareInstance selector:@selector(terminateAction:) name:UIApplicationWillTerminateNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:_shareInstance selector:@selector(saveDownloadSource) name:UIApplicationDidEnterBackgroundNotification object:nil];
    });
    
    return _shareInstance;
}

+ (void)initialize {
    if (![[NSFileManager defaultManager] fileExistsAtPath:XXDownloadTool_DownloadDataDocument_Path]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:XXDownloadTool_DownloadDataDocument_Path withIntermediateDirectories:YES attributes:nil error:nil];
    }
}


#pragma mark - GETSET

- (NSMutableArray *)downloadSources
{
    if (_downloadSources == nil) {
        
        _downloadSources = [NSMutableArray arrayWithCapacity:1];
        NSArray *arr = [NSArray arrayWithContentsOfFile:XXDownloadTool_DownloadSources_Path];

        for (NSData *data in arr) {
            
            XXDownItem *source = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[source.netPath stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]]];
            [source setTask:[self.downLoadsession dataTaskWithRequest:request]];
            [_downloadSources addObject:source];
            
            //恢复下载
            if (source.isOffLine) {
                if (self.fileState == XXDownloadToolOffLineStyleDefaut) {
                    if (source.filedownState == XXDownloadStateDown || source.filedownState == XXDownloadStateSuspend) {
                        
                        source.filedownState = XXDownloadStateDown;
                        [self suspendDownload:source];
                    }
                }
                else if (self.fileState == XXDownloadToolOffLineStyleAuto)
                {
                    if (source.filedownState == XXDownloadStateDown || source.filedownState == XXDownloadStateSuspend || source.filedownState == XXDownloadStateFail) {
                        
                        source.filedownState = XXDownloadStateSuspend;
                        
                        [self continueDownload:source];
                        
                    }
                }
                else if (self.fileState == XXDownloadToolOffLineStyleFromSource)
                {
                    if (source.filedownState == XXDownloadStateDown) {
                        
                        source.filedownState = XXDownloadStateSuspend;
                        [self continueDownload:source];
                        
                    }
                }
            }
        }
    }
    
    return _downloadSources;
}


- (XXDownloadToolOffLineStyle)fileState{
    return [[NSUserDefaults standardUserDefaults] integerForKey:XXDownloadTool_OffLineStyle_Key];
}

- (void)setFileState:(XXDownloadToolOffLineStyle)fileState{
    [[NSUserDefaults standardUserDefaults] setInteger:self.fileState forKey:XXDownloadTool_OffLineStyle_Key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}




- (NSMutableArray *)delegateArr
{
    if (_delegateArr == nil) {
        _delegateArr = [NSMutableArray arrayWithCapacity:1];
    }
    
    return _delegateArr;
}




#pragma mark - Method

- (void)terminateAction:(NSNotification *)sender
{
    [self saveDownloadSource];
}


/**
 保存下载状态
 */
- (void)saveDownloadSource
{
    NSMutableArray *mArr = [[NSMutableArray alloc] initWithCapacity:1];
    for (XXDownItem *souce in self.downloadSources) {
        if (souce.isOffLine) {
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:souce];
            [mArr addObject:data];
        }
    }
    
    [mArr writeToFile:XXDownloadTool_DownloadSources_Path atomically:YES];
}




/**
 添加下载任务
 @param netPath 下载地址
 @return 下载任务数据模型
 */
#pragma mark - 下载操作
- (XXDownItem *)addDownloadTast:(NSString *)netPath andOffLine:(BOOL)offLine;
{
    XXDownItem *source = [[XXDownItem alloc] init];
    [source setNetPath:netPath];
    [source setTask:[self.downLoadsession dataTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[netPath stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]]]]];
    
    [source setFileName:[self getFileName:[[netPath componentsSeparatedByString:@"/"] lastObject]]];
    [source setLocation:[XXDownloadTool_DownloadDataDocument_Path stringByAppendingPathComponent:source.fileName]];
    source.filedownState = XXDownloadStateDown;
    source.offLine = offLine;
    //开始下载任务
    [source.task resume];
    [(NSMutableArray *)self.downloadSources addObject:source];
    [self saveDownloadSource];
    return source;
}
- (NSString *)getFileName:(NSString *)sourceName
{
    NSArray *arr = [sourceName componentsSeparatedByString:@"."];
    NSString *type = arr.count > 1 ? [arr lastObject] : nil;
    NSString *name = type ? [sourceName substringToIndex:sourceName.length - type.length - 1] : sourceName;
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *result = sourceName;
    int count = 0;
    do {
        if ([manager fileExistsAtPath:[XXDownloadTool_DownloadDataDocument_Path stringByAppendingPathComponent:result]]) {
            count++;
            result = type ? [NSString stringWithFormat:@"%@ (%i).%@", name, count, type] : [NSString stringWithFormat:@"%@ (%i)", name, count];
        }
        else
        {
            [manager createFileAtPath:[XXDownloadTool_DownloadDataDocument_Path stringByAppendingPathComponent:result] contents:nil attributes:nil];
            return result;
        }
    } while (1);
}



/**
 暂停下载任务
 
 @param source 下载任务数据模型
 */
- (void)suspendDownload:(XXDownItem *)source
{
    if (source.filedownState == XXDownloadStateDown || source.filedownState == XXDownloadStateFail) {
        
        [source.task cancel];
        
        source.filedownState = XXDownloadStateSuspend;
        
        
    }
    else
    {
        NSLog(@"不能暂停未开始的下载任务！");
    }
}

- (void)suspendAllTask
{
    for (XXDownItem *source in self.downloadSources) {
        [self suspendDownload:source];
    }
}


/**
 继续下载任务
 
 @param source 下载任务数据模型
 */
- (void)continueDownload:(XXDownItem *)source
{
    if (source.filedownState == XXDownloadStateSuspend || source.filedownState == XXDownloadStateFail) {
        
        source.filedownState = XXDownloadStateDown;
        // 断点位置
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[source.netPath stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]]];
        [request setValue:[NSString stringWithFormat:@"bytes=%lld-", source.totalBytesWritten] forHTTPHeaderField:@"Range"];
        source.task = [self.downLoadsession dataTaskWithRequest:request];
        [source.task resume];
    }
    else
    {
        NSLog(@"不能继续未暂停的下载任务！");
    }
}

- (void)startAllTask
{
    for (XXDownItem *source in self.downloadSources) {
        [self continueDownload:source];
    }
}

/**
 停止下载任务
 
 @param source 下载任务数据模型
 */
- (void)stopDownload:(XXDownItem *)source
{
    if (source.filedownState == XXDownloadStateDown) {
        [source.task cancel];
    }
    
    source.filedownState = XXDownloadStateStop;
    [source.fileHandle closeFile];
    source.fileHandle = nil;
    NSError *error = nil;
    [[NSFileManager defaultManager] removeItemAtURL:[NSURL fileURLWithPath:source.location] error:&error];
    if (error) {
        NSLog(@"----------删除文件失败！\n%@\n%@", error, source.location);
    }
    [(NSMutableArray *)self.downloadSources removeObject:source];
    
    [self saveDownloadSource];
    
}
- (void)stopAllTask
{
    for (XXDownItem *source in self.downloadSources) {
        [self stopDownload:source];
    }
}
//添加代理
- (void)addDownloadToolDelegate:(id<XXDownloadToolDelegate>)delegate
{
    for (XXDownloadToolDelegateObject *obj in self.delegateArr) {
        if (obj.delegate == delegate) {
            return;
        }
    }
    
    XXDownloadToolDelegateObject *delegateObj = [[XXDownloadToolDelegateObject alloc] init];
    delegateObj.delegate = delegate;
    [self.delegateArr addObject:delegateObj];
}

//移除代理
- (void)removeDownloadToolDelegate:(id<XXDownloadToolDelegate>)delegate
{
    for (XXDownloadToolDelegateObject *obj in self.delegateArr) {
        if (obj.delegate == delegate) {
            [self.delegateArr removeObject:delegate];
            return;
        }
    }
}

/**
 按字节计算文件大小
 
 @param tytes 字节数
 @return 文件大小字符串
 */
+ (NSString *)calculationDataWithBytes:(int64_t)tytes
{
    NSString *result;
    double length;
    if (tytes > XXDownloadTool_Limit) {
        length = tytes/XXDownloadTool_Limit;
        if (length > XXDownloadTool_Limit) {
            length /= XXDownloadTool_Limit;
            if (length > XXDownloadTool_Limit) {
                length /= XXDownloadTool_Limit;
                if (length > XXDownloadTool_Limit) {
                    length /= XXDownloadTool_Limit;
                    result = [NSString stringWithFormat:@"%.2fTB", length];
                }
                else
                {
                    result = [NSString stringWithFormat:@"%.2fGB", length];
                }
            }
            else
            {
                result = [NSString stringWithFormat:@"%.2fMB", length];
            }
        }
        else
        {
            result = [NSString stringWithFormat:@"%.2fKB", length];
        }
    }
    else
    {
        result = [NSString stringWithFormat:@"%lliB", tytes];
    }
    
    return result;
}

#pragma mark - NSURLSessionDataDelegate代理方法

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
{
    dispatch_async(dispatch_get_main_queue(), ^{
        for (XXDownItem *source in self.downloadSources) {
            if (source.task == dataTask) {
                source.totalBytesExpectedToWrite = source.totalBytesWritten + response.expectedContentLength;
            }
        }
    });
    
    // 允许处理服务器的响应，才会继续接收服务器返回的数据
    completionHandler(NSURLSessionResponseAllow);
}
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    // XXTODO
    /**
      NSFileHandle写文件 手机没有存储空间了，或者需要写的文件太大，会触发"No space left on device"异常
     优化
     开启一个异步线程；去判断下载。当然了，注意加锁。
     额这个代理回调本身在自线程

     */
    
    NSLog(@"当前线程 ==== %@", [NSThread currentThread]);

    dispatch_async(dispatch_get_main_queue(), ^{
        for (XXDownItem *source in self.downloadSources) {
            if (source.task == dataTask) {
                [source.fileHandle seekToEndOfFile];
                [source.fileHandle writeData:data];
                
                
//                {
//                    /**
//                     从服务器下载一个大文件数据,往往会造成内存暴涨,此时用NSOutputStream对文件进行操作就能解决此问题.(也可以用NSFileHandle)
//                     是否避免No space
//                     */
//                //1. 创建一个输入流,数据追加到文件的屁股上
//                //把数据写入到指定的文件地址，如果当前文件不存在，则会自动创建
//                NSOutputStream *stream = [[NSOutputStream alloc]initWithURL:[NSURL fileURLWithPath:source.location] append:YES];
//                //2. 打开流
//                [stream open];
//                //3. 写入流数据
//                [stream write:data.bytes maxLength:data.length];
//                //4.当不需要的时候应该关闭流
//                [stream close];
//                }
                
                source.totalBytesWritten += data.length;
                if ([source.delegate respondsToSelector:@selector(downloadSource:didWriteData:totalBytesWritten:totalBytesExpectedToWrite:)]) {
                    [source.delegate downloadSource:source didWriteData:data totalBytesWritten:source.totalBytesWritten totalBytesExpectedToWrite:source.totalBytesExpectedToWrite];
                }
            }
        }
    });
}
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    if (error) {
        NSLog(@"%@", error);
        NSLog(@"%@", error.userInfo);
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        XXDownItem *currentSource = nil;
        for (XXDownItem *source in self.downloadSources) {
            if (source.fileHandle) {
                [source.fileHandle closeFile];
                source.fileHandle = nil;
            }
            
            if (error) {
                if (source.task == task && source.filedownState == XXDownloadStateDown) {
                    source.filedownState = XXDownloadStateFail;
                    if (error.code == -997) {
                        [self continueDownload:source];
                    }
                }
            }
            else
            {
                if (source.task == task) {
                    currentSource = source;
                    break;
                }
            }
        }
        
        if (currentSource) {
            currentSource.filedownState = XXDownloadStateFinished;
            [self saveDownloadSource];
            for (XXDownloadToolDelegateObject *delegateObj in self.delegateArr) {
                if ([delegateObj.delegate respondsToSelector:@selector(downloadToolDidFinish:downloadItem:)]) {
                    [delegateObj.delegate downloadToolDidFinish:self downloadItem:currentSource];
                }
            }
        }
    });
}




@end



@implementation XXDownloadToolDelegateObject

@end
