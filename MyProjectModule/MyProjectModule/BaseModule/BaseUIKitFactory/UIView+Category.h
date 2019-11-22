//
//  UIView+frameAdjust.h
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/7/7.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (frameAdjust)

/**
 Returns the view's view controller (may be nil). 通过view去找到对应的控制器
 */
@property (nullable, nonatomic, readonly) UIViewController *xx_viewController;


/*****************************/
- (CGPoint)origin;
- (void)setOrigin:(CGPoint) point;

- (CGSize)size;
- (void)setSize:(CGSize) size;

- (CGFloat)x;
- (void)setX:(CGFloat)x;

- (CGFloat)y;
- (void)setY:(CGFloat)y;

- (CGFloat)height;
- (void)setHeight:(CGFloat)height;

- (CGFloat)width;
- (void)setWidth:(CGFloat)width;

- (CGFloat)tail;
- (void)setTail:(CGFloat)tail;

- (CGFloat)bottom;
- (void)setBottom:(CGFloat)bottom;

- (CGFloat)right;
- (void)setRight:(CGFloat)right;


/** UIView 的中心点X值 */
@property (nonatomic, assign) CGFloat centerX;
/** UIView 的中心点Y值 */
@property (nonatomic, assign) CGFloat centerY;
/** UIView的最大X值 */
@property (assign, nonatomic) CGFloat maxX;
/** UIView的最大Y值 */
@property (assign, nonatomic) CGFloat maxY;
/** UIView 的宽度 bounds */
@property (nonatomic, assign) CGFloat boundsWidth;
/** UIView 的高度 bounds */
@property (nonatomic, assign) CGFloat boundsHeight;
/** 上 < Shortcut for frame.origin.y */
@property (nonatomic) CGFloat top;
/** 左 < Shortcut for frame.origin.x. */
@property (nonatomic) CGFloat left;

@end
