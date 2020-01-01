//
//  APPPayTool.h
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/8/11.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APPPayProtocol.h"


@interface APPPayTool : NSObject

+ (id)sharedPayManager;

/**
 APP Pay

 @param payType Pay Way
 @param orderId Order ID
 @param block Status Respond
 */
- (void)payType:(PayType)payType orderId:(NSString *)orderId completionBlock:(void (^)(PayStatus payStatus, PayType type))block;


@end
