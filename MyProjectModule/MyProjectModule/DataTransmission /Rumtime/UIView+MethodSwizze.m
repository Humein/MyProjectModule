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
扩大UIButton的响应热区

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

//in custom button .m
//overide this method
//- (BOOL)pointInside:(CGPoint)point withEvent:(nullable UIEvent *)event {
//
//    return CGRectContainsPoint(HitTestingBounds(self.bounds, self.minimumHitTestWidth, self.minimumHitTestHeight), point);
//}
//
//CGRect HitTestingBounds(CGRect bounds, CGFloat minimumHitTestWidth, CGFloat minimumHitTestHeight) {
//    CGRect hitTestingBounds = bounds;
//    if (minimumHitTestWidth > bounds.size.width) {
//        hitTestingBounds.size.width = minimumHitTestWidth;
//        hitTestingBounds.origin.x -= (hitTestingBounds.size.width - bounds.size.width)/2;
//    }
//    if (minimumHitTestHeight > bounds.size.height) {
//        hitTestingBounds.size.height = minimumHitTestHeight;
//        hitTestingBounds.origin.y -= (hitTestingBounds.size.height - bounds.size.height)/2;
//    }
//    return hitTestingBounds;
//}







/* 2
 子view超出了父view的bounds响应事件
 项目中常常遇到button已经超出了父view的范围但仍需可点击的情况，比如自定义Tabbar中间的大按钮
 点击超出Tabbar bounds的区域也需要响应，此时重载父view的-(UIView *)hitTest: withEvent:方法，去掉点击必须在父view内的判断，然后子view就能成为 hit-test view用于响应事件了
 */
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    if (!self.isUserInteractionEnabled || self.isHidden || self.alpha <= 0.01) {
        return nil;
    }
    /**
     *  此注释掉的方法用来判断点击是否在父View Bounds内，
     *  如果不在父view内，就会直接不会去其子View中寻找HitTestView，return 返回
     */
    //    if ([self pointInside:point withEvent:event]) {
    for (UIView *subview in [self.subviews reverseObjectEnumerator]) {
        CGPoint convertedPoint = [subview convertPoint:point fromView:self];
        UIView *hitTestView = [subview hitTest:convertedPoint withEvent:event];
        if (hitTestView) {
            return hitTestView;
        }
    }
//    return self;
    //    }
    return nil;
}



/*  3
 
 让边侧留出的 非scrollview 部分
 
 在scrollview的父view中把蓝色部分的事件都传递给scrollView就可以了，
 
 in scrollView.superView .m
 */

//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//
//    UIView *hitTestView = [super hitTest:point withEvent:event];
//    if (hitTestView) {
//        hitTestView = self.scrollView;
//    }
//    return hitTestView;
//}



@end
