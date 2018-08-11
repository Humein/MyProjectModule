//
//  APPPayTool.m
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/8/11.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import "APPPayTool.h"

@interface APPPayTool ()

@property (nonatomic, strong) NSDictionary *classDict;

@end

@implementation APPPayTool
+ (void)load {
    
    NSLog(@"写上注册的一些key进来");
    
    //注册微信的支付
//    [WXApi registerApp:kWXAppKey];
    
}
+ (id)sharedPayManager {
    
    static APPPayTool *payTool;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        payTool = [APPPayTool new];
        
        payTool.classDict = @{@(PayType_AliPay).stringValue:@"AliPay",@(PayType_WeChatPay).stringValue:@"WeChatPay",@(PayType_ApplePay).stringValue:@"ApplePay",@(PayType_CoinPay).stringValue:@"CoinPay"};
        
    });
    
    return payTool;
}


- (void)payType:(PayType)payType orderId:(NSString *)orderId completionBlock:(void (^)(PayStatus payStatus, PayType type))block {
    
    NSString *key = [NSString stringWithFormat:@"%zi",payType];
    
    Class class = NSClassFromString([self.classDict objectForKey:key]);
    
    id <APPPayProtocol> object = [[class alloc] init];
    
    [object pay:orderId];
    
    [object payResultBlock:^(PayStatus payStatus) {
        
        block(payStatus, payType);
        
    }];
    
}
@end
