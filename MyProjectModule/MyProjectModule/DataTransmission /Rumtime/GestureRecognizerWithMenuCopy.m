//
//  GestureRecognizerWithMenuCopy.m
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2020/1/7.
//  Copyright © 2020 xinxin. All rights reserved.
//
/**
 - UITouch对象的定义是表示在屏幕上发生的触摸的位置、大小、运动和力的物体
   - 触摸对象包含内容 通过UITouch 对象可以获取你点击的控件以及相关属性
      - 触摸发生的视图或窗口
      - 触摸在视图或窗口中的位置
 
 CJLabel
 [UIGestureRecognizer 详解](https://www.jianshu.com/p/4f83db7e3e31)
 */

#import "GestureRecognizerWithMenuCopy.h"
#import <objc/runtime.h>

@interface GestureRecognizerWithMenuCopy()<UIGestureRecognizerDelegate>
/**
 - UIGestureRecognizer的子类
 UITapGestureRecognizer（轻触，点按）
 UILongPressGestureRecognizer（长按）
 UISwipeGestureRecognizer（轻扫手势）
 UIRotationGestureRecognizer（旋转手势）
 UIPanGestureRecognizer（拖拽手势）
 UIPinchGestureRecognizer（捏合手势，缩放用）
   通过这些手势 在结合 RunTime为其添加UITouch对象，我们可以做出很多事情
 */
@property (nonatomic, strong) UILongPressGestureRecognizer *longPressGestureRecognizer; ///长按手势
@property (nonatomic, strong) UITapGestureRecognizer *doubleTapGes; ///双击手势
@end

@implementation GestureRecognizerWithMenuCopy


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

#pragma mark - init Action

-(void)initView{
    /// 为长按手势添加事件
    _longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureDidFire:)];
    _longPressGestureRecognizer.delegate = self;
    [self addGestureRecognizer:_longPressGestureRecognizer];
    
}

- (void)setEnableCopy:(BOOL)enableCopy {
    _enableCopy = enableCopy;
    if (_enableCopy) {
        /// 为双击手势添加事件
        self.doubleTapGes =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTwoAct:)];
        self.doubleTapGes.numberOfTapsRequired = 2;
        self.doubleTapGes.delegate = self;
        [self addGestureRecognizer:self.doubleTapGes];
    }
}



/// 通过 touchesBegan 处理 屏幕上的事件
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
        UITouch *touch = [touches anyObject];
        CGPoint point = [touch locationInView:self];
        if (!CGRectContainsPoint(self.frame, point)) {
    //        [self hidden];
    //        _tapBlock ? _tapBlock (YES) : nil;
        }
}

#pragma mark - UIGestureRecognizerDelegate

/// 是否允许触发手势
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    
    return YES;
}

/// 是否允许同时支持多个手势，默认是不支持多个手势 可以处理手势冲突(来实现多个手势识别器的共同识别)
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return  YES;
}

/// 手指触摸屏幕后回调的方法，返回NO则不再进行手势识别，方法触发等
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    // 1: RunTime 为UILongPressGestureRecognizer 添加 UITouch 对象
    if (gestureRecognizer == self.longPressGestureRecognizer) {
        objc_setAssociatedObject(self.longPressGestureRecognizer, &kAssociatedUITouchKey, touch, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    // 1: RunTime 为UITapGestureRecognizer 添加 UITouch 对象
    else if (gestureRecognizer == self.doubleTapGes) {
        objc_setAssociatedObject(self.doubleTapGes, &kAssociatedUITouchKey, touch, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return YES;
}

/// 手指按压屏幕后回调的方法，返回NO则不再进行手势识别，方法触发等
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceivePress:(UIPress *)press{
    return YES;
}

#pragma mark - Execute Action
/// 双击
- (void)tapTwoAct:(UITapGestureRecognizer *)sender {
    // 2:根据键值获取到关联对象
    UITouch *touch = objc_getAssociatedObject(self.doubleTapGes, &kAssociatedUITouchKey);
    if (NO) {}
    else{
        if (self.enableCopy) {
            CGPoint point = [touch locationInView:self];
            // 唤起 选择复制视图
            [self showMenuView];
        }
    }
}

/// 长按
- (void)longPressGestureDidFire:(UILongPressGestureRecognizer *)sender {
    
}

/// 弹出复制 Test
- (void)showMenuView {
    [self becomeFirstResponder];
    [[UIMenuController sharedMenuController] setTargetRect:CGRectZero inView:self];
    [[UIMenuController sharedMenuController] setMenuVisible:YES animated:YES];
}
@end
