//
//  ThraadSafeViewController.h
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2018/11/22.
//  Copyright © 2018 xinxin. All rights reserved.
//

#import "AbstractViewController.h"

@class ThraadSafeViewController;

@protocol TimerListener <NSObject>

@required

- (void)timerCallBack:(ThraadSafeViewController *)timer;

@end

@interface ThraadSafeViewController : AbstractViewController

@property (nonatomic, weak) id <TimerListener> delegate;

@end
