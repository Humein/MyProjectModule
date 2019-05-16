//
//  URLSessionDownManager.h
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2019/5/16.
//  Copyright © 2019 xinxin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, XXDownloadState) {
    
    XXDownloadStateDown = 0,//下载
    XXDownloadStateSuspend = 1,//暂停
    XXDownloadStateStop = 2,//停止
    XXDownloadStateFinished = 3,//完成
    XXDownloadStateFail = 4//失败
};

typedef NS_ENUM(NSInteger, XXDownloadToolOffLineStyle) {
    
    XXDownloadToolOffLineStyleDefaut = 0,//默认断点后暂停
    XXDownloadToolOffLineStyleAuto = 1,//根据保存的状态自动处理
    XXDownloadToolOffLineStyleFromSource = 2//根据保存的状态自动处理
};

@class XXDownItem,URLSessionDownManager;

@protocol XXDownloadItemDelegate <NSObject>
@optional

- (void)downloadSource:(XXDownItem *)source changedState:(XXDownloadState)state;


- (void)downloadSource:(XXDownItem *)source didWriteData:(NSData *)data totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite;

@end

@interface XXDownItem: NSObject <NSCoding>
//地址路径
@property (copy, nonatomic, readonly) NSString *netPath;
//本地路径
@property (copy, nonatomic, readonly) NSString *location;
//下载状态
@property (assign, nonatomic, readonly) XXDownloadState filedownState;
//下载任务
@property (strong, nonatomic, readonly) NSURLSessionDataTask *task;
//文件名称
@property (strong, nonatomic, readonly) NSString *fileName;
//已下载的字节数
@property (assign, nonatomic, readonly) int64_t totalBytesWritten;
//文件字节数
@property (assign, nonatomic, readonly) int64_t totalBytesExpectedToWrite;
//是否断点下载
@property (assign, nonatomic, getter=isOffLine) BOOL offLine;
//代理
@property (weak, nonatomic) id<XXDownloadItemDelegate> delegate;

@end


@protocol XXDownloadToolDelegate <NSObject>

- (void)downloadToolDidFinish:(URLSessionDownManager *)tool downloadItem:(XXDownItem *)item;

@end

@interface URLSessionDownManager : NSObject

/**
 下载的所有任务资源
 */
@property (strong, nonatomic, readonly) NSArray *downloadSources;


/**
 断点后的下载方式
 */
@property (assign, nonatomic) XXDownloadToolOffLineStyle fileState;


+ (instancetype)shareInstance;

/**
 按字节计算文件大小
 
 @param tytes 字节数
 @return 文件大小字符串
 */
+ (NSString *)calculationDataWithBytes:(int64_t)tytes;


/**
 添加下载任务
 
 @param netPath 下载地址
 @return 下载任务数据模型
 */
- (XXDownItem *)addDownloadTast:(NSString *)netPath andOffLine:(BOOL)offLine;

/**
 添加代理
 
 @param delegate 代理对象
 */
- (void)addDownloadToolDelegate:(id<XXDownloadToolDelegate>)delegate;
/**
 移除代理
 
 @param delegate 代理对象
 */
- (void)removeDownloadToolDelegate:(id<XXDownloadToolDelegate>)delegate;

/**
 暂停下载任务
 
 @param source 下载任务数据模型
 */
- (void)suspendDownload:(XXDownItem *)source;
/**
 暂停所有下载任务
 */
- (void)suspendAllTask;

/**
 继续下载任务
 
 @param source 下载任务数据模型
 */
- (void)continueDownload:(XXDownItem *)source;
/**
 开启所有下载任务
 */
- (void)startAllTask;
/**
 停止下载任务
 
 @param source 下载任务数据模型
 */
- (void)stopDownload:(XXDownItem *)source;
/**
 停止所有下载任务
 */
- (void)stopAllTask;

@end


@interface XXDownloadToolDelegateObject : NSObject

@property (weak, nonatomic) id<XXDownloadToolDelegate> delegate;

@end
