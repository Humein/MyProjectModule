//
//  HitEventStrikeView.h
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2018/11/6.
//  Copyright © 2018 xinxin. All rights reserved.
//

#import <UIKit/UIKit.h>

// 事件穿透

typedef UIView * _Nullable (^ _Nullable XXHitTestBlock)(UIView * _Nullable hitView, CGPoint point, UIEvent * _Nullable event);

@interface HitEventStrikeView : UIView

@property (nonatomic, readwrite, copy) XXHitTestBlock hitTestBlock;


+ (instancetype)viewWithFrame:(CGRect)frame hitTestBlock:(UIView * _Nullable (^)(UIView * _Nullable hitView, CGPoint point, UIEvent * _Nullable event))hitTestBlock;

- (void)setHitTestBlock:(UIView * _Nullable (^)(UIView * _Nullable hitView, CGPoint point, UIEvent * _Nullable event))hitTestBlock;


@end
