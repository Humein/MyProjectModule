//
//  UIView+MethodSwizze.m
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/8/24.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import "UIView+MethodSwizze.h"
#import <objc/runtime.h>
@implementation UIView (MethodSwizze)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        SEL originalSelector = @selector(pointInside:withEvent:);
        SEL swizzledSelector = @selector(bk_pointInside:withEvent:);
        Class cls = [self class];
        Method originalMethod = class_getInstanceMethod(cls, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(cls, swizzledSelector);
        
        //先尝试給源SEL添加IMP，这里是为了避免源SEL没有实现IMP的情况

        BOOL didAddMethod = class_addMethod(cls, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod)
        {
            //添加成功：说明源SEL没有实现IMP，将源SEL的IMP替换到交换SEL的IMP

            class_replaceMethod(cls, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        }
        else
        {
            //添加失败：说明源SEL已经有IMP，直接将两个SEL的IMP交换即可

            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

- (UIEdgeInsets)hitTestEdgeInsets
{
    NSValue* value = objc_getAssociatedObject(self, @selector(hitTestEdgeInsets));
    UIEdgeInsets insets = UIEdgeInsetsZero;
    [value getValue:&insets];
    return insets;
}

- (void)setHitTestEdgeInsets:(UIEdgeInsets)hitTestEdgeInsets
{
    NSValue* value = [NSValue value:&hitTestEdgeInsets withObjCType:@encode(UIEdgeInsets)];
    objc_setAssociatedObject(self, @selector(hitTestEdgeInsets), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}



/** 1
 
 
扩大UIButton的响应热区 swizzle

重载UIButton的-(BOOL)pointInside: withEvent:方法，让Point即使落在Button的Frame外围也返回YES。
 //in custom button .m
 //overide this method
 */
- (BOOL)bk_pointInside:(CGPoint)point withEvent:(UIEvent*)event
{
    UIEdgeInsets insets = self.hitTestEdgeInsets;
    if (UIEdgeInsetsEqualToEdgeInsets(insets, UIEdgeInsetsZero))
    {
        return [self bk_pointInside:point withEvent:event];
    }
    else
    {
        CGRect hitBounds = UIEdgeInsetsInsetRect(self.bounds, insets);
        return CGRectContainsPoint(hitBounds, point);
    }
}






// TEST



//in custom button .m  overide this method
//扩大UIButton

- (BOOL)CP0_pointInside:(CGPoint)point withEvent:(nullable UIEvent *)event {

    CGFloat minimumHitTestWidth = 100;
    CGFloat minimumHitTestHeight = 100;
    return CGRectContainsPoint(HitTestingBounds(self.bounds, minimumHitTestWidth, minimumHitTestHeight), point);
}


- (BOOL)CP1_pointInside:(CGPoint)point withEvent:(nullable UIEvent *)event {
    BOOL success = CGRectContainsPoint(self.bounds, point);
    if (success) {
        NSLog(@"点在%@里",self.class);
    }else {
        NSLog(@"点不在%@里",self.class);
    }
    return success;
}


CGRect HitTestingBounds(CGRect bounds, CGFloat minimumHitTestWidth, CGFloat minimumHitTestHeight) {
    CGRect hitTestingBounds = bounds;
    if (minimumHitTestWidth > bounds.size.width) {
        hitTestingBounds.size.width = minimumHitTestWidth;
        hitTestingBounds.origin.x -= (hitTestingBounds.size.width - bounds.size.width)/2;
    }
    if (minimumHitTestHeight > bounds.size.height) {
        hitTestingBounds.size.height = minimumHitTestHeight;
        hitTestingBounds.origin.y -= (hitTestingBounds.size.height - bounds.size.height)/2;
    }
    return hitTestingBounds;
}


/* 2
 
 
 //模拟一下系统点击事件， OverWirte
 子view超出了父view的bounds响应事件
 项目中常常遇到button已经超出了父view的范围但仍需可点击的情况，比如自定义Tabbar中间的大按钮
 点击超出Tabbar bounds的区域也需要响应，此时重载父view的-(UIView *)hitTest: withEvent:方法，去掉点击必须在父view内的判断，然后子view就能成为 hit-test view用于响应事件了
 */
#warning -------- 滥用导致无法定位的bug 不可以点击屏幕 self.isHidden == YES

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (!self.isUserInteractionEnabled || self.isHidden || self.alpha <= 0.01) return nil;
    //判断点在不在这个视图里
    if ([self pointInside:point withEvent:event]) {
        //在这个视图 遍历该视图的子视图
        for (UIView *subview in [self.subviews reverseObjectEnumerator]) {
            //转换坐标到子视图
            CGPoint convertedPoint = [subview convertPoint:point fromView:self];
            //递归调用hitTest:withEvent继续判断
            UIView *hitTestView = [subview hitTest:convertedPoint withEvent:event];
            if (hitTestView) {
                //在这里打印self.class可以看到递归返回的顺序。
                return hitTestView;
            }
        }
        //这里就是该视图没有子视图了 点在该视图中，所以直接返回本身，上面的hitTestView就是这个。
        NSLog(@"命中的view:%@",self.class);
        return self;
    }
    //不在这个视图直接返回nil
    return nil;

}



/*  3
 
 让边侧留出的 非scrollview 部分   可以用于扩大（转移）button点击区域 （注意 forControlEvents：UIControlEventTouchDown 事件类型不同响应的也不同）
 
 在scrollview的父view中把蓝色部分的事件都传递给scrollView就可以了，
 
 in scrollView.superView .m
 */

- (UIView *)CP1_hitTest:(CGPoint)point withEvent:(UIEvent *)event {

//    UIView *hitTestView = [super hitTest:point withEvent:event];
//    if (hitTestView) {
//        hitTestView = self.scrollView;
//    }
//    return hitTestView;
    return nil;
}

//   缺点会 阻断 cell 的didselected 方法
//- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    UITouch *touch = [touches anyObject];
//    CGPoint point = [touch locationInView:self];
//    if (CGRectContainsPoint(_imageView.frame, point) && [[[event allTouches] anyObject] phase] == UITouchPhaseEnded) {
//        _headBlock ? _headBlock (_historyModelmodel) : nil;
//    }
//}

// 通过hitTest 代替事件传递，缺点hitTest会掉2次 官方解释
//    Yes, it’s normal. The system may tweak the point being hit tested between the calls. Since hitTest should be a pure function with no side-effects, this should be fine.
//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
//    if (CGRectContainsPoint(self.courseImage.frame, point)) {
//        if ((_tostFlag % 2 == 0)) {
//            if ([[_model plCourseID] intValue]>0) {
//                _courseBlock ? _courseBlock(_model) : nil;
//            }
//        }
//        _tostFlag += 1;
//    }
//    return [super hitTest:point withEvent:event];
//}

// 避免按钮禁用状态下点击穿透到 contentView，导致 controls 被隐藏
// @see https://stackoverflow.com/a/40786920/456536
//for (UIView *superview in containerViews) {
//    for (UIView *subview in superview.subviews) {
//        UIControl *control = bjl_cast(UIControl, subview);
//        CGPoint pointInControl = [self.view convertPoint:point toView:control];
//        if (control && !control.enabled && [control pointInside:pointInControl withEvent:event]) {
//            return self.view; // !!!: self.view.userInteractionEnabled = YES;
//        }
//    }
//}

// 解决 button 超出 bounds 之后点击失效的问题
// @see https://stackoverflow.com/questions/5432995/interaction-beyond-bounds-of-uiview
// @see https://developer.apple.com/library/content/qa/qa2013/qa1812.html
//- (BOOL)pointInside:(CGPoint)point withEvent:(nullable UIEvent *)event {
//    if (CGRectContainsPoint(self.exitButton.frame, point)) {
//        return YES;
//    }
//    for (UIView *subview in self.customContainerView.subviews) {
//        if (CGRectContainsPoint([self convertRect:subview.bounds fromView:subview], point)) {
//            return YES;
//        }
//    }
//    return [super pointInside:point withEvent:event];
//}
@end
