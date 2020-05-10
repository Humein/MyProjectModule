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
        NSLog(@"-----------%@", self.location);
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

@property (strong, nonatomic) NSURLSession *session;

@end

@implementation URLSessionDownManager

static URLSessionDownManager *_shareInstance;


#pragma mark - LifeCycle

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
            [source setTask:[self.session dataTaskWithRequest:request]];
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



- (NSURLSession *)session
{
    if (_session == nil) {
        
        //可以上传下载HTTP和HTTPS的后台任务(程序在后台运行)。 在后台时，将网络传输交给系统的单独的一个进程,即使app挂起、推出甚至崩溃照样在后台执行。
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:@"XXDownload"];
        _session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    }
    
    return _session;
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
- (XXDownItem *)addDownloadTast:(NSString *)netPath andOffLine:(BOOL)offLine;
{
    XXDownItem *source = [[XXDownItem alloc] init];
    [source setNetPath:netPath];
    [source setTask:[self.session dataTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[netPath stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]]]]];
    
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
        source.task = [self.session dataTaskWithRequest:request];
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
    NSLog(@"%s", __FUNCTION__);
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
