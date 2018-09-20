//
//  NSTimer+WeakTimerBlock.h
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2018/9/19.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (WeakTimerBlock)
+ (instancetype)repeatWithInterval:(NSTimeInterval)interval block:(void(^)(NSTimer *timer))block;

@end
