//
//  BKDeviceOrientation.h
//  benkelaile-iOS
//
//  Created by Zhang Xin Xin on 2019/3/20.
//  Copyright © 2019 sunlands. All rights reserved.
//
/**
 控制横竖屏管理类
 - 前提是项目必须支持横竖屏
 - 想要支持横竖屏VC，重写supportedInterfaceOrientations
 */
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BKDeviceOrientation : NSObject

+ (instancetype)shareInstance;

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

/**
 *  旋转操作
 */
- (void)screenExChangeforOrientation:(UIInterfaceOrientation)orientation;

@end

NS_ASSUME_NONNULL_END
