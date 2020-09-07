//
//  Manager.h
//  MyProjectModule
//
//  Created by zhangxinxin on 2020/9/2.
//  Copyright © 2020 xinxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MultiDelegate.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol ManagerDelegate;
@interface Manager : NSObject

- (void)reciveBottonClick:(UIButton *)button;

+ (instancetype)shareManager;

- (void)addDelegate:(id<ManagerDelegate>)delegate;

- (void)deleteDelegate:(id<ManagerDelegate>)delegate;

- (void)clearAllDelegates;

@end

@protocol ManagerDelegate <NSObject>

@optional

- (void)manager:(Manager *)manager didBottonClick:(UIButton *)button;

@end
NS_ASSUME_NONNULL_END
