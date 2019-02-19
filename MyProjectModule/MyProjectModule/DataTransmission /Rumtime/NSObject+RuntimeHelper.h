//
//  NSObject+RuntimeHelper.h
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/8/24.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (RuntimeHelper)

// RunTime增加方法
-(void)runTimeAddInstanceMethod;

/**
 交换方法
 */
+ (void)pxy_swizzleMethodWithOriginalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector;

/**
 获取类中的所有属性
 */
- (void)pxy_printPropertyList;

/**
 获取类中的所有成员变量
 */
- (void)pxy_printIvaList;

/**
 获取类中的所有方法
 */
- (void)pxy_printMethodList;

/**
 获取协议列表
 */
- (void)pxy_printProtocolList;
@end
