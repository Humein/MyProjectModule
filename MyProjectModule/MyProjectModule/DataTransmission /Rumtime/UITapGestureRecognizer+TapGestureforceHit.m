//
//  UITapGestureRecognizer+TapGestureforceHit.m
//  RuntimeAndRunloop
//
//  Created by 鑫鑫 on 2018/5/28.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import "UITapGestureRecognizer+TapGestureforceHit.h"
#import <objc/runtime.h>

static const void *UITapGestureRecognizerduration = @"UITapGestureRecognizerduration";

@implementation UITapGestureRecognizer (TapGestureforceHit)

#pragma mark - Getter Setter

- (NSTimeInterval)duration{
    NSNumber *number = objc_getAssociatedObject(self, &UITapGestureRecognizerduration);
    return number.doubleValue;
}

- (void)setDuration:(NSTimeInterval)duration{
    NSNumber *number = [NSNumber numberWithDouble:duration];
    objc_setAssociatedObject(self, &UITapGestureRecognizerduration, number, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.delegate = self;
}



/**
 添加点击事件
 
 @param target taeget
 @param action action
 @param duration 时间间隔
 */
- (instancetype)initWithTarget:(id)target action:(SEL)action withDuration:(NSTimeInterval)duration{
    
    self = [super init];
    if (self) {
        self.duration = duration;
        self.delegate = self;
        [self addTarget:target action:action];
    }
    return self;
    
}



#pragma mark -- 代理 --
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    self.enabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.enabled = YES;
    });
    
    return YES;
}

@end
