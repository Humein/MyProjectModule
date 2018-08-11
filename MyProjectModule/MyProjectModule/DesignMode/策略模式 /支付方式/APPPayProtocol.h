//
//  APPPayProtocol.h
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/8/11.
//  Copyright © 2018年 xinxin. All rights reserved.
//

@protocol APPPayProtocol <NSObject>

typedef enum : NSUInteger {
    PayType_AliPay = 1, //支付宝支付
    PayType_WeChatPay,  //微信支付
    PayType_ApplePay,   //苹果支付
    PayType_CoinPay     //金币支付
} PayType;


//typedef NSInteger PayStatus;

typedef enum : NSUInteger {
    PayStatus_Failed,                         //支付失败
    PayStatus_Success,                        //支付成功
    PayStatus_NotInstall,                     //未安装客户端（微信）
    PayStatus_UserCancel,                     //用户取消（微信）
    
    //后边这些针对内购
    PayStatus_NotSupportPay,                  //不支持内购
    PayStatus_RequestProductFailed,           //请求商品失败
    PayStatus_NoneProduct,                    //无此商品
    PayStatus_TransactionPayed,               //已经购买过此产品,其实这个是针对非消耗品的。我们的产品都是消耗品
    PayStatus_TransactionPurchasing,          //正在购买
    PayStatus_TransactionErrorInPurchasing,   //在购买过程中发生错误
    PayStatus_TransactionVerrifying,          //验证中
    PayStatus_TransactionVerrifyError,        //购买过程中，验证失败
    
} PayStatus;




- (void)pay:(NSString *)orderId;

- (void)payResultBlock:(void (^)(PayStatus payStatus))resultBlock;

@end
