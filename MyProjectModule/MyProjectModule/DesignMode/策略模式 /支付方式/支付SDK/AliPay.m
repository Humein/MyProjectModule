//
//  AliPay.m
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/8/11.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import "AliPay.h"

typedef void (^PayResultBlock)(PayStatus payStatus);

@interface AliPay()

@property (nonatomic, copy) PayResultBlock resultBlock;

@property (nonatomic, copy) NSString *orderId;
@end

@implementation AliPay
- (id)init {
    
    self= [super init];
    
    /*
     这里可以写阿里支付配置信息
     */
    
    return self;
    
}
- (void)pay:(NSString *)orderId {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self callBack];
    });
    
}


//接受回调，这里有微信和支付宝的回调
- (void)callBack{
    
    self.resultBlock ? self.resultBlock(PayStatus_Success) : nil;

}

- (void)payResultBlock:(void (^)(PayStatus))resultBlock {
    
    resultBlock ? self.resultBlock = [resultBlock copy] : nil;
    
}

@end
