//
//  AppDelegate+DownManagerHelper.h
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2019/5/16.
//  Copyright © 2019 xinxin. All rights reserved.
//

#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate (DownManagerHelper)

@property (copy, nonatomic, readonly) void (^completionHandler)();

/// add  objc_setAssociatedObject
@property (copy, nonatomic) NSString *appName;

/// no objc_setAssociatedObject
@property (copy, nonatomic) NSString *bppName;


@end

NS_ASSUME_NONNULL_END
