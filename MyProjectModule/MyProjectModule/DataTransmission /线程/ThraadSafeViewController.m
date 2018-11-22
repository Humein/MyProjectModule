//
//  ThraadSafeViewController.m
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2018/11/22.
//  Copyright © 2018 xinxin. All rights reserved.
//

#import "ThraadSafeViewController.h"

#define LOCK(lock) dispatch_semaphore_wait(lock, DISPATCH_TIME_FOREVER);

#define UNLOCK(lock) dispatch_semaphore_signal(lock);

@interface ThraadSafeViewController ()

@property (strong, nonatomic, nonnull) dispatch_semaphore_t operationsLock; // a lock to keep the access to `External Operations` thread-safe


// key is copy, value is weak because operation instance is retained by SDWebImageManager's runningOperations property
// we should use lock to keep thread-safe because these method may not be acessed from main queue
@property (nonatomic, strong, nonnull) NSMapTable< NSString * , id<TimerListener> > *weakCache; // strong-weak cache

@property (nonatomic, strong, nonnull) dispatch_semaphore_t weakCacheLock; // a lock to keep the access to `weakCache` thread-safe


@end

@implementation ThraadSafeViewController

- (void)viewDidLoad {
    [super viewDidLoad];


}

#pragma mark - public


@end
