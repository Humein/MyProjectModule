//
//  ThraadSafeViewController.m
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2018/11/22.
//  Copyright © 2018 xinxin. All rights reserved.
//

#import "NSTimerObserver.h"

#define LOCK(lock) dispatch_semaphore_wait(lock, DISPATCH_TIME_FOREVER);

#define UNLOCK(lock) dispatch_semaphore_signal(lock);

@interface NSTimerObserver ()

@property (strong, nonatomic, nonnull) dispatch_semaphore_t operationsLock; // a lock to keep the access to `External Operations` thread-safe

// key is copy, value is weak because operation instance is retained by SDWebImageManager's runningOperations property
// we should use lock to keep thread-safe because these method may not be acessed from main queue
@property (nonatomic, strong, nonnull) NSMapTable< NSString * , id<TimerObserver> > *weakCache; // strong-weak cache

@property (nonatomic, strong, nonnull) NSHashTable *timerMap; // strong-weak cache

@property (nonatomic, strong, nonnull) dispatch_semaphore_t weakCacheLock; // a lock to keep the access to `weakCache` thread-safe

@property (nonatomic, strong) NSTimer *timer;


@end

@implementation NSTimerObserver

+ (nonnull instancetype)sharedInstance {
    static dispatch_once_t pred;
    static NSTimerObserver *sharedInstance = nil;
    dispatch_once(&pred, ^{
        sharedInstance = [[self alloc] init];
        [sharedInstance loadDefaultConfig];
    });
    return sharedInstance;
}

- (void)loadDefaultConfig {
    
    _operationsLock = dispatch_semaphore_create(1);
    _timerMap = [[NSHashTable alloc] initWithOptions:NSPointerFunctionsWeakMemory|NSPointerFunctionsObjectPointerPersonality capacity:0];


    
}

- (void)trigger:(NSTimer *)timer {
    [self.timerMap.allObjects enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        id<TimerObserver> listener = obj;
        if([listener respondsToSelector:@selector(timerCallBack:)]){
            [listener timerCallBack:self];
        }
    }];
}

-(void)startTimer{
    
    if (_timer == nil) {
        
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(trigger:) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }

    
}

-(void)stopTimer{
    [_timer invalidate];
    _timer = nil;
}

#pragma mark - public
- (void)addTimerObserver:(id<TimerObserver>)listener withCount:(NSUInteger )count{
{
        
        LOCK(self.operationsLock)
        if(![self.timerMap containsObject:listener]){
            [self.timerMap addObject:listener];
            if(self.timerMap.count > 0){
                //启动
                
                [self startTimer];
            }
        }
        UNLOCK(self.operationsLock)
    }
}

- (void)addTimerObserver:(id<TimerObserver>)listener {
    
    LOCK(self.operationsLock)
    if(![self.timerMap containsObject:listener]){
        [self.timerMap addObject:listener];
        if(self.timerMap.count > 0){
            //启动
            [self startTimer];
        }
    }
    UNLOCK(self.operationsLock)
}

- (void)removeTimerObserver:(id<TimerObserver>)listener {
    LOCK(self.operationsLock)
    if([self.timerMap containsObject:listener]){
        [self.timerMap removeObject:listener];
        if(self.timerMap.count == 0){
            //暂停
            [self stopTimer];
        }
    }
    UNLOCK(self.operationsLock)
}


@end
