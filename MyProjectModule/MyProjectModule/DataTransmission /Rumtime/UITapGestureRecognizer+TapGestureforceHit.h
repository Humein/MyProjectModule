//
//  UITapGestureRecognizer+TapGestureforceHit.h
//  RuntimeAndRunloop
//
//  Created by 鑫鑫 on 2018/5/28.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#pragma mark ---- 1:利用关联对象为分类增加伪属性

@interface UITapGestureRecognizer (TapGestureforceHit)<UIGestureRecognizerDelegate>
/**
 添加点击事件
 
 @param target taeget
 @param action action
 @param duration 时间间隔
 */
- (instancetype)initWithTarget:(id)target action:(SEL)action withDuration:(NSTimeInterval)duration;


///时间间隔
@property (nonatomic,assign) NSTimeInterval duration;

@end
