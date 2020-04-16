//
//  BKDeviceOrientation.m
//  benkelaile-iOS
//
//  Created by Zhang Xin Xin on 2019/3/20.
//  Copyright © 2019 sunlands. All rights reserved.
//

#import "BKDeviceOrientation.h"
#import "UIViewController+Category.h"

@interface BKDeviceOrientation()
@property (nonatomic, strong) id objc;
@end

@implementation BKDeviceOrientation

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    static BKDeviceOrientation * objc;
    dispatch_once(&onceToken, ^{
        objc = [[[self class] alloc] init];
    });
    return objc;
}

/**
 *  是否竖屏
 */
- (BOOL)isPortrait
{
    UIInterfaceOrientation inter = [self interfaceOrientationForDeviceOrientation:[UIDevice currentDevice].orientation];
    return UIInterfaceOrientationIsPortrait(inter);
}

/**
 *  是否横屏
 */

- (BOOL)isHorizontal
{
    UIInterfaceOrientation inter = [self interfaceOrientationForDeviceOrientation:[UIDevice currentDevice].orientation];
    return UIInterfaceOrientationIsLandscape(inter);
}

- (UIInterfaceOrientation)interfaceOrientationForDeviceOrientation:(UIDeviceOrientation)orientation
{
    switch (orientation) {
        case UIDeviceOrientationUnknown:
            return UIInterfaceOrientationUnknown;
            break;
        case UIDeviceOrientationPortrait:
            return UIInterfaceOrientationPortrait;
            break;
        case UIDeviceOrientationPortraitUpsideDown:
            return UIInterfaceOrientationPortraitUpsideDown;
            break;
        case UIDeviceOrientationLandscapeLeft:
            return UIInterfaceOrientationLandscapeRight;
            break;
        case UIDeviceOrientationLandscapeRight:
            return UIInterfaceOrientationLandscapeLeft;
            break;
        case UIDeviceOrientationFaceUp:
        case UIDeviceOrientationFaceDown:
            return [UIApplication sharedApplication].statusBarOrientation;
            break;
            
        default:
            return [UIApplication sharedApplication].statusBarOrientation;
            break;
    }
}

/**
 *  观测屏幕变化
 */
- (void)addDeviceOrientationNotificationBlockHandle:(void (^)(UIInterfaceOrientation orientation))blockHandle
{
    if (_objc) {
        [self removeDeviceOrientationNotification];
    }
    //监听旋转屏
    self.objc = [[NSNotificationCenter defaultCenter] addObserverForName:UIDeviceOrientationDidChangeNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        if (blockHandle) {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIInterfaceOrientation inter = [self interfaceOrientationForDeviceOrientation:[UIDevice currentDevice].orientation];
                if (inter != UIInterfaceOrientationUnknown) {
                    blockHandle(inter);
                }
            });
        }
    }];
}

/**
 *  移除掉通知
 */
- (void)removeDeviceOrientationNotification
{
    if (_objc) {
        [[NSNotificationCenter defaultCenter] removeObserver:_objc];
    }
    _objc = nil;
}

- (void)screenExChangeforOrientation:(UIInterfaceOrientation)orientation{
    UIInterfaceOrientation val = orientation;
    [UIViewController attemptRotationToDeviceOrientation];
    SEL selector = NSSelectorFromString(@"setOrientation:");
    NSInvocation *invocation =[NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
    [invocation setSelector:selector];
    [invocation setTarget:[UIDevice currentDevice]];
    [invocation setArgument:&val atIndex:2];
    [invocation invoke];
}

- (void)allowRotation:(UIViewController *)vc{
    Class class = [vc class];
    [UIViewController configOrientation:class];
}

@end
