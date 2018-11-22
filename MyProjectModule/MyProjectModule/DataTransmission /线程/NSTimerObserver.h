//
//  ThraadSafeViewController.h
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2018/11/22.
//  Copyright © 2018 xinxin. All rights reserved.
//

/*
 需要接收定时器回调的模块，只要实现TimerListener协议，在需要接收定时器回调的时把其添加到TimerService中，在业务不需要接收定时器回调的时候把其从TimerService中移除即可，这样所有的倒计时业务只需要维护一个定时器即可搞定。
 
 多线程加锁 防止 野指针  https://satanwoo.github.io/2016/10/23/multithread-dangling-pointer/

 */

#import "AbstractViewController.h"

@class NSTimerObserver;

@protocol TimerObserver <NSObject>

@required

- (void)timerCallBack:(NSTimerObserver *)timer;

@end

@interface NSTimerObserver : NSObject

@property (nonatomic, weak) id <TimerObserver> delegate;

+ (instancetype)sharedInstance;

- (void)addTimerObserver:(id<TimerObserver>)listener;

- (void)removeTimerObserver:(id<TimerObserver>)listener;

@end
