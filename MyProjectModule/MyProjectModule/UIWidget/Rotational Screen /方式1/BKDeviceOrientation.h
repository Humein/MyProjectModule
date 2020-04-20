//
//  BKDeviceOrientation.h
//  benkelaile-iOS
//
//  Created by Zhang Xin Xin on 2019/3/20.
//  Copyright © 2019 sunlands. All rights reserved.
//
/**  方式1和2 的管理类
 控制横竖屏管理类
 - 前提是项目必须支持横竖屏
 - 在想要支持横竖屏VC
   SDDeviceOrientation.shareInstance().allowRotation(self)
   
 */
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BKDeviceOrientation : NSObject

+ (instancetype)shareInstance;

/// 允许横竖屏
/// @param vc UIViewController
- (void)allowRotation:(UIViewController *)vc;

/**
 *  旋转操作
 */
- (void)screenExChangeforOrientation:(UIInterfaceOrientation)orientation;

/**
 *  是否竖屏
 */
- (BOOL)isPortrait;

/**
 *  是否横屏
 */
- (BOOL)isHorizontal;

/**
 *  观测屏幕变化
 */
- (void)addDeviceOrientationNotificationBlockHandle:(void (^)(UIInterfaceOrientation orientation))blockHandle;

/**
 *  移除掉通知
 */
- (void)removeDeviceOrientationNotification;


@end

NS_ASSUME_NONNULL_END
