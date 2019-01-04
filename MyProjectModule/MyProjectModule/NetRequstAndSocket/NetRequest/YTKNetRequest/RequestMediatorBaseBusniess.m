//
//  RequestMediatorBaseBusniess.m
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2019/1/3.
//  Copyright © 2019 xinxin. All rights reserved.
//

#import "RequestMediatorBaseBusniess.h"
#define STR_NET_RETURN_TYPE_ERROR @"返回数据无法解析"
#define STR_NET_RETURN_TYPE_SUCCSESS @"请求成功"

@implementation RequestMediatorBaseBusniess


+(void)requestConfig:(RequestMediatorBaseBusniessBlock)configBlock withSuccess:(Succsess)succsess andFailure:(Failure)failure{
    
    __block RequestMediatorBaseBusniess *configAPI = [[RequestMediatorBaseBusniess alloc] init];

    configBlock ? configBlock(configAPI) : nil;

    [configAPI startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        id responseObject = request.responseJSONObject;
        if(![responseObject isKindOfClass:[NSDictionary class]]){
            if(failure){
                failure(STR_NET_RETURN_TYPE_ERROR,request,0);
            }
            return;
        }
        NSInteger code = [[responseObject objectForKey:@"code"] integerValue];
        if (code == 1000000){
            if(succsess){
                succsess(STR_NET_RETURN_TYPE_SUCCSESS,responseObject,code);
            }
        }else{
            NSString *message = [responseObject objectForKey:@"message"];
            if(succsess){
                succsess(message,responseObject,code);
            }
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if(failure){
            failure([configAPI.ZTKErrorDic objectForKey:@"message"],NSStringFromClass([request class]),request.responseStatusCode);
        }
    }];

}

@end
