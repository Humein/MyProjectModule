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
/**
 通过方法SEL生成NSInvocation
 
 @param selector 方法
 @return Invocation对象
 */
- (NSInvocation *)createInvocationWithSelector:(SEL)selector {
    //通过方法名创建方法签名
    NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:selector];
    //创建invocation
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    [invocation setTarget:self];
    [invocation setSelector:selector];
    return invocation;
}

@end
