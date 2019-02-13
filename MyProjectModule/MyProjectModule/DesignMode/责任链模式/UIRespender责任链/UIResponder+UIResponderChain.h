//
//  UIResponder+UIResponderChain.h
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2018/10/31.
//  Copyright © 2018 xinxin. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIResponder (UIResponderChain)
/**
 通过事件响应链条传递事件
 
 @param eventName 事件名
 @param userInfo 附加参数
 */
- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo;

/**
 通过方法SEL生成NSInvocation
 
 @param selector 方法
 @return Invocation对象
 */
- (NSInvocation *)createInvocationWithSelector:(SEL)selector;
@end
