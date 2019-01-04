//
//  ZTKBaseRequest.h
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2019/1/3.
//  Copyright © 2019 xinxin. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^RequestCompleteFilterBlock)(void);

typedef void(^RequestFailedFilterBlock)(void);

typedef void(^CacheFileNameFilterForRequestArgumentBlock)(id argument);


@interface ZTKBaseRequest : YTKRequest
/**
 请求成功的回调
 */
@property(nonatomic,assign) RequestCompleteFilterBlock requestCompleteFilterBlock;

/**
 请求失败的回调
 */
@property(nonatomic,assign) RequestFailedFilterBlock requestFailedFilterBlock;

/**
 用于在cache结果，计算cache文件名时，忽略掉一些指定的参数
 */
@property(nonatomic,assign) CacheFileNameFilterForRequestArgumentBlock cacheFileNameFilterBlock;

/**
 请求方式
 */
@property(nonatomic,assign) YTKRequestMethod requestMethod;

/**
 设置返回对象的格式，YTKRequestSerializerTypeHTTP代表返回二进制格式，YTKRequestSerializerTypeJSON代表返回一个json的根对象（NSDictionary或者NSArray）
 */
@property(nonatomic,assign) YTKRequestSerializerType requestSerializerType;
/**
  当需要断点续传时，获得下载进度的回调
 */
//@property(nonatomic,assign) AFDownloadProgressBlock resumableDownloadProgressBlock;
@property (nonatomic,assign) AFURLSessionTaskProgressBlock ZTKresumableDownloadProgressBlock;
@property (nonatomic, copy, nullable) AFConstructingBlock ZTKconstructingBodyBlock;


/**
 请求URL
 */
@property(nonatomic,copy) NSString *requestUrl;
@property(nonatomic,copy) NSString *cdnUrl;
@property(nonatomic,copy) NSString *baseUrl;

/**
  错误信息
 */
@property (nonatomic,strong,readwrite)NSDictionary * ZTKErrorDic;

/**
 请求超时
 */
@property(nonatomic,assign) NSTimeInterval requestTimeoutInterval;

/**
 请求参数 dic/json
 */
@property(nonatomic,strong) id requestArgument;
@property(nonatomic,strong) NSArray *requestAuthorizationHeaderFieldArray;

/**
 请求头
 */
@property(nonatomic,strong) NSDictionary *requestHeaderFieldValueDictionary;
@property(nonatomic,strong) NSURLRequest *buildCustomUrlRequest;
@property(nonatomic,assign) BOOL useCDN;
@property(nonatomic,strong) id jsonValidator;
@property(nonatomic,assign) BOOL statusCodeValidator;
@property (nonatomic, strong, nullable) NSString *ZTKresumableDownloadPath;

/**
 缓存时间
 */
@property(nonatomic,assign) NSInteger cacheTimeInSecond;
@property(nonatomic,assign) long long cacheVersion;
@property(nonatomic,strong) id cacheSensitiveData;



/// 请求成功的回调
- (void)requestCompleteFilter;

/// 请求失败的回调
- (void)requestFailedFilter;

/// 请求的URL
- (NSString *)requestUrl;

/// 请求的CdnURL
- (NSString *)cdnUrl;

/// 请求的BaseURL
- (NSString *)baseUrl;

/// 请求的连接超时时间，默认为60秒
- (NSTimeInterval)requestTimeoutInterval;

/// 请求的参数列表
- (id)requestArgument;

/// 用于在cache结果，计算cache文件名时，忽略掉一些指定的参数
- (id)cacheFileNameFilterForRequestArgument:(id)argument;

/// Http请求的方法
- (YTKRequestMethod)requestMethod;

/// 请求的SerializerType
- (YTKRequestSerializerType)requestSerializerType;

/// 请求的Server用户名和密码
- (NSArray *)requestAuthorizationHeaderFieldArray;

/// 在HTTP报头添加的自定义参数
- (NSDictionary *)requestHeaderFieldValueDictionary;

/// 构建自定义的UrlRequest，
/// 若这个方法返回非nil对象，会忽略requestUrl, requestArgument, requestMethod, requestSerializerType
- (NSURLRequest *)buildCustomUrlRequest;

/// 是否使用CDN的host地址
- (BOOL)useCDN;

/// 用于检查JSON是否合法的对象
- (id)jsonValidator;

/// 用于检查Status Code是否正常的方法
- (BOOL)statusCodeValidator;

/// 当POST的内容带有文件等富文本时使用
- (AFConstructingBlock)constructingBodyBlock;

/// 当需要断点续传时，指定续传的地址
- (NSString *)resumableDownloadPath;

/// 当需要断点续传时，获得下载进度的回调
- (AFURLSessionTaskProgressBlock )resumableDownloadProgressBlock;

/// For subclass to overwrite
- (NSInteger)cacheTimeInSeconds;

- (long long)cacheVersion;

- (id)cacheSensitiveData;

//删除全部缓存
-(void)clearAllCache;
@end

NS_ASSUME_NONNULL_END
