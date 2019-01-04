//
//  RequestMediatorBaseBusniess.h
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2019/1/3.
//  Copyright © 2019 xinxin. All rights reserved.
//

#import "ZTKBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface RequestMediatorBaseBusniess : ZTKBaseRequest
/**
 *  成功。
 *  @param responseObject 返回的数据。
 */
typedef void(^Succsess)(NSString *succMessage,id responseObject, NSInteger succCode);

/**
 *  失败。
 *  @param errorCode 失败原因。
 */
typedef void(^Failure)(NSString *errorMessage, id result, NSInteger errorCode);


/**
 网络请求配置

 @param configObject ZTKBaseRequest
 */
typedef void (^RequestMediatorBaseBusniessBlock)(RequestMediatorBaseBusniess  *configObject);


- (void)noNetWork;//无网络

- (void)dataError;//网络请求发生错误

- (void)recoverNormal;//数据恢复正常


+(void)requestConfig:(RequestMediatorBaseBusniessBlock)configBlock withSuccess:(Succsess)succsess andFailure:(Failure)failure;

@end

NS_ASSUME_NONNULL_END
