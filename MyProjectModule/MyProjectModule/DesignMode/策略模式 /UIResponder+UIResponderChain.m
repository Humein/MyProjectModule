//
//  UIResponder+UIResponderChain.m
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2018/10/31.
//  Copyright © 2018 xinxin. All rights reserved.
//

#import "UIResponder+UIResponderChain.h"

@implementation UIResponder (UIResponderChain)
/**
 通过事件响应链条传递事件
 
 @param eventName 事件名
 @param userInfo 附加参数
 */
- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo {
    [[self nextResponder] routerEventWithName:eventName userInfo:userInfo];
}

@end
