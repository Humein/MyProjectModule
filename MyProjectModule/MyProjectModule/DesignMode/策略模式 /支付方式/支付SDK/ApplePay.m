//
//  ApplePay.m
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/8/11.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import "ApplePay.h"

#import <StoreKit/StoreKit.h>

typedef void (^PayResultBlock)(PayStatus payStatus);

@interface ApplePay () <SKPaymentTransactionObserver,SKProductsRequestDelegate>

@property (nonatomic, copy) PayResultBlock resultBlock;

@property (nonatomic, copy) NSString *productId;  //此处表示产品的付费id

@end

@implementation ApplePay

- (id)init {
    
    self= [super init];
    
    /*配置信息*/
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    
    return self;
    
}

#pragma 支付入口
- (void)pay:(NSString *)orderId {
    
    _productId = orderId;
    
    if([SKPaymentQueue canMakePayments]) {//如果可以支付，就根据id号去商店请求这个商品，然后再去支付
        
        NSArray *product = [[NSArray alloc] initWithObjects:orderId, nil];
        
        NSSet *nsset = [NSSet setWithArray:product];
        
        SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:nsset];
        
        request.delegate = self;
        
        [request start];
        
//        [self showWaiting];
        
    } else {
        
        NSLog(@"不允许程序内付费");
        
        _resultBlock ? _resultBlock(PayStatus_NotSupportPay) : nil;
        
    }
    
}

#pragma mark- 请求商品的代理信息
//收到产品返回信息
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    
    NSArray *product = response.products;
    
    if([product count] == 0){
        
        _resultBlock ? _resultBlock(PayStatus_NoneProduct) : nil;
        
        return;
        
    }
    
    NSLog(@"productID:%@", response.invalidProductIdentifiers);
    
    SKProduct *currentProductItem = nil;
    
    for (SKProduct *productItem in product) {
        
        NSLog(@"%@", [productItem description]);
        
        NSLog(@"%@", [productItem localizedTitle]);
        
        NSLog(@"%@", [productItem localizedDescription]);
        
        NSLog(@"%@", [productItem price]);
        
        NSLog(@"%@", [productItem productIdentifier]);
        
        if([productItem.productIdentifier isEqualToString:self.productId]) {
            
            currentProductItem = productItem;
            
        }
        
    }
    
    SKPayment *payment = [SKPayment paymentWithProduct:currentProductItem];
    
    NSLog(@"内购--发送购买请求");
    
    [[SKPaymentQueue defaultQueue] addPayment:payment];
    
}

#pragma mark- 监听支付结果
//请求失败
- (void)request:(SKRequest *)request didFailWithError:(NSError *)error {
    
//    [self hiddenWaiting];
    
    NSLog(@"内购--请求失败");
    
    _resultBlock ? _resultBlock(PayStatus_RequestProductFailed) : nil;
    
}

#pragma mark - 请求完成
- (void)requestDidFinish:(SKRequest *)request {
    
    NSLog(@"内购--请求完成");
    
}

#pragma mark- 监听支付结果
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transaction {
    
    SKPaymentTransaction *currentPaymentTransaction = nil;
    
    for(SKPaymentTransaction *tran in transaction) {
        
        if ([tran.payment.productIdentifier isEqualToString:self.productId]) {//如果订单是这个商品的
            
            currentPaymentTransaction = tran;
            
        }
        
    }
    
    if (currentPaymentTransaction) {
        
        switch (currentPaymentTransaction.transactionState) {
                
            case SKPaymentTransactionStatePurchased:
                
                NSLog(@"内购--交易完成");
                
                //交易成功，接下来要对这个产品进行验证
                
                //客户端验证，不建议使用
                //                [self verifyPurchaseWithPaymentTransaction];
                
                //上报服务器验证
                [self verifyPurchaseWithServer];
                
                [[SKPaymentQueue defaultQueue] finishTransaction:currentPaymentTransaction];
                
                break;
                
            case SKPaymentTransactionStatePurchasing:
                
                NSLog(@"内购--商品添加进列表,就是正在购买");
                
                _resultBlock ? _resultBlock(PayStatus_TransactionErrorInPurchasing) : nil;
                
                break;
                
            case SKPaymentTransactionStateRestored:
                
                NSLog(@"已经购买过商品");
                
                _resultBlock ? _resultBlock(PayStatus_TransactionPayed) : nil;
                
                [[SKPaymentQueue defaultQueue] finishTransaction:currentPaymentTransaction];
                
                break;
                
            case SKPaymentTransactionStateFailed:
                
                NSLog(@"交易失败");
                
//                [self hiddenWaiting];
                
                _resultBlock ? _resultBlock(PayStatus_Failed) : nil;
                
                [[SKPaymentQueue defaultQueue] finishTransaction:currentPaymentTransaction];
                
                break;
                
            default:
                
                break;
                
        }
        
    }
    
}

#pragma mark - 交易结束
- (void)completeTransaction:(SKPaymentTransaction *)transaction {
    
    NSLog(@"内购--交易结束");
    
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
    
}

#pragma mark - 上报服务器验证
- (void)verifyPurchaseWithServer {
    /*
     请求后台接口，服务器处验证是否支付成功，依据返回结果做相应逻辑处理
     0 代表沙盒  1 正式的内购
     */
    
}

//沙盒测试环境验证
#define SANDBOX @"https://sandbox.itunes.apple.com/verifyReceipt"

//正式环境验证
#define AppStore @"https://buy.itunes.apple.com/verifyReceipt"

//验证购买，避免越狱软件模拟苹果请求达到非法购买问题
//客户端验证不建议使用
- (void)verifyPurchaseWithPaymentTransaction {
    
    //验证中...
    _resultBlock ? _resultBlock(PayStatus_TransactionVerrifying) : nil;
    
    //从沙盒中获取交易凭证并且拼接成请求体数据
    NSURL *receiptUrl=[[NSBundle mainBundle] appStoreReceiptURL];
    
    NSData *receiptData=[NSData dataWithContentsOfURL:receiptUrl];
    
    NSString *receiptString=[receiptData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];//转化为base64字符串
    
    NSString *bodyString = [NSString stringWithFormat:@"{\"receipt-data\" : \"%@\"}", receiptString];//拼接请求数据
    
    NSData *bodyData = [bodyString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *verfifyUrl = [NSURL URLWithString:AppStore];
    
    //创建请求验证购买
    NSMutableURLRequest *requestM = [NSMutableURLRequest requestWithURL:verfifyUrl];
    
    requestM.HTTPBody = bodyData;
    
    requestM.HTTPMethod = @"POST";
    
    //创建连接并发送同步请求
    __weak typeof(self) weakSelf = self;
//    __strong typeof ()
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:requestM completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSLog(@"内购--验证失败！");
                
                weakSelf.resultBlock ? weakSelf.resultBlock(PayStatus_TransactionErrorInPurchasing) : nil;
                
            });
            
        } else {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                
                NSLog(@"%@",dic);
                
                if([dic[@"status"] intValue] == 0) {
                    
                    NSLog(@"内购--验证成功！");
                    
                    /* 购买商品的信息
                     NSDictionary *dicReceipt = dic[@"receipt"];
                     
                     NSDictionary *dicInApp = [dicReceipt[@"in_app"] firstObject];
                     
                     NSString *productIdentifier = dicInApp[@"product_id"];//读取产品标识
                     */
                    
                    //如果是消耗品则记录购买数量，非消耗品则记录是否购买过
                    
                    weakSelf.resultBlock ? weakSelf.resultBlock(PayStatus_Success) : nil;
                    
                } else if ([dic[@"status"] integerValue] == 21007 ) { //沙盒环境下的测试
                    
                    //苹果本身走的也是测试环境，所以在审核的时候会走到这个方法里面，我们再次做验证
                    
                    NSURL *receiptUrl = [[NSBundle mainBundle] appStoreReceiptURL];
                    
                    NSData *receiptData = [NSData dataWithContentsOfURL:receiptUrl];
                    
                    //转化为base64字符串
                    NSString *receiptString = [receiptData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
                    
                    //拼接请求数据
                    NSString *bodyString = [NSString stringWithFormat:@"{\"receipt-data\" : \"%@\"}", receiptString];
                    
                    NSData *bodyData = [bodyString dataUsingEncoding:NSUTF8StringEncoding];
                    
                    NSURL *verfifyUrl = [NSURL URLWithString:SANDBOX];
                    
                    //创建请求验证购买
                    NSMutableURLRequest *requestM = [NSMutableURLRequest requestWithURL:verfifyUrl];
                    
                    requestM.HTTPBody = bodyData;
                    
                    requestM.HTTPMethod = @"POST";
                 /*
                  Variable ‘tempDataDask‘ is uninitialized when captured by block.
                  
                  block内部对于tempDataDask的使用上. 在进入block的时候，tempDataDask是一个未初始化的变量.
                  
                  解决方法很简单，加上__block修饰为block变量就好了.

                  */
                    __block NSURLSessionDataTask *tempDataDask = [[NSURLSession sharedSession] dataTaskWithRequest:requestM completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                        
                        if (error) {
                            
                            dispatch_async(dispatch_get_main_queue(), ^{
                                
                                NSLog(@"内购--验证未通过");
                                
                                weakSelf.resultBlock ? weakSelf.resultBlock(PayStatus_TransactionErrorInPurchasing) : nil;
                                
                            });
                            
                        } else {
                            
                            dispatch_async(dispatch_get_main_queue(), ^{
                                
                                NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                
                                if ([dic[@"status"] intValue] == 0) {
                                    
                                    NSLog(@"内购--验证成功！");
                                    
                                    /* 购买商品的信息
                                     NSDictionary *dicReceipt = dic[@"receipt"];
                                     
                                     NSDictionary *dicInApp = [dicReceipt[@"in_app"] firstObject];
                                     
                                     NSString *productIdentifier = dicInApp[@"product_id"];//读取产品标识
                                     */
                                    
                                    //如果是消耗品则记录购买数量，非消耗品则记录是否购买过
                                    
                                    weakSelf.resultBlock ? weakSelf.resultBlock(PayStatus_Success) : nil;
                                    
                                } else {
                                    
                                    weakSelf.resultBlock ? weakSelf.resultBlock(PayStatus_TransactionVerrifyError) : nil;
                                    
                                }
                                
                                [tempDataDask resume];
                                
                            });
                            
                        }
                        
                    }];
                    
                    [tempDataDask resume];
                    
                } else {
                    
                    NSLog(@"内购--购买失败，未通过验证！");
                    
                    weakSelf.resultBlock ? weakSelf.resultBlock(PayStatus_TransactionVerrifyError) : nil;
                    
                }
                
            });
            
        }
        
    }];
    
    [dataTask resume];
    
}

- (void)payResultBlock:(void (^)(PayStatus))resultBlock {
    
    resultBlock ? self.resultBlock = [resultBlock copy] : nil;
    
}

- (void)dealloc {
    
    NSLog(@"内购--释放");
    
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
    
}


@end
