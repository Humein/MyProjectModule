//
//  UIViewController+wwwwwww.m
//  MyProjectModule
//
//  Created by XinXin on 2020/4/16.
//  Copyright © 2020 xinxin. All rights reserved.
//

#import "UIViewController+Category.h"
#import <objc/runtime.h>

@implementation UIViewController (Category)

+ (void)configOrientation:(Class)class {
    SEL originalSeletor = @selector(shouldAutorotate);
    SEL originalSeletor1 = @selector(supportedInterfaceOrientations);
    SEL originalSeletor2 = @selector(preferredInterfaceOrientationForPresentation);
    SEL swizzledSeletor = @selector(sw_shouldAutorotate);
    SEL swizzledSeletor1 = @selector(sw_supportedInterfaceOrientations);
    SEL swizzledSeletor2 = @selector(sw_preferredInterfaceOrientationForPresentation);
    Method originMethod = class_getInstanceMethod(class, originalSeletor);
    Method originMethod1 = class_getInstanceMethod(class, originalSeletor1);
    Method originMethod2 = class_getInstanceMethod(class, originalSeletor2);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSeletor);
    Method swizzledMethod1 = class_getInstanceMethod(class, swizzledSeletor1);
    Method swizzledMethod2 = class_getInstanceMethod(class, swizzledSeletor2);
    BOOL didAddMethod = class_addMethod(class, originalSeletor, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    BOOL didAddMethod1 = class_addMethod(class, originalSeletor1, method_getImplementation(swizzledMethod1), method_getTypeEncoding(swizzledMethod1));
    BOOL didAddMethod2 = class_addMethod(class, originalSeletor2, method_getImplementation(swizzledMethod2), method_getTypeEncoding(swizzledMethod2));
    if (didAddMethod == NO) {method_exchangeImplementations(originMethod, swizzledMethod);}
    if (didAddMethod1 == NO) {method_exchangeImplementations(originMethod1, swizzledMethod1);}
    if (didAddMethod2 == NO) {method_exchangeImplementations(originMethod2, swizzledMethod2);}

}

- (BOOL)sw_shouldAutorotate {
    return YES;
}
- (UIInterfaceOrientationMask)sw_supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscapeRight;
}

- (UIInterfaceOrientation)sw_preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationPortrait;
}
@end
