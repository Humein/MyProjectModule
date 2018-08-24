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






@end
