//
//  NSTimer+WeakTimerBlock.m
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2018/9/19.
//  Copyright © 2018年 xinxin. All rights reserved.
//

/*
 添加一个NSTimer类的扩展，把target指给[NSTimer class]，事件由加方法接收，然后把事件通过block传递出来。
 
 巧妙点在于把block作为timer的userInfo传递进入trigger:方法，避免了在本类中再添加个参数记录block。
 

 */
#import "NSTimer+WeakTimerBlock.h"

@implementation NSTimer (WeakTimerBlock)

+ (instancetype)repeatWithInterval:(NSTimeInterval)interval block:(void(^)(NSTimer *timer))block {
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(trigger:) userInfo:[block copy] repeats:YES];
    return timer;
}

+ (void)trigger:(NSTimer *)timer {
    void(^block)(NSTimer *timer) = [timer userInfo];
    if (block) {
        block(timer);
    }
}
@end
