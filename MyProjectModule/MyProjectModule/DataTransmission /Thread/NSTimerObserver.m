//
//  ThraadSafeViewController.m
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2018/11/22.
//  Copyright © 2018 xinxin. All rights reserved.
//
/**
 - NSHashTable
   - NSHashTable效仿了NSSet(NSMutableSet)，但提供了比NSSet更多的操作选项，尤其是在对弱引用关系的支持上，NSHashTable在对象/内存处理时更加的灵活。相较于NSSet，NSHashTable
 具有以下特性
         1.NSHashTable是可变的，它没有不可变版本。
         2.它可以持有元素的弱引用，而且在对象被销毁后能正确地将其移除。而这一点在NSSet是做不到的。
         3.它的成员可以在添加时被拷贝。
         4.它的成员可以使用指针来标识是否相等及做hash检测。
         5.它可以包含任意指针，其成员没有限制为对象。我们可以配置一个NSHashTable实例来操作任意的指针，而不仅仅是对象。
         
 - NSMapTable
   - NSMapTable是更广泛意义上的NSDictionary。和NSDictionary/NSMutableDictionary相比具有如下特性：
         1.NSDictionary/NSMutableDictionary会复制keys并且通过强引用values来实现存储；
         2.NSMapTable是可变的；
         3.NSMapTable可以通过弱引用来持有keys和values，所以当key或者value被deallocated的时候，所存储的实体也会被移除；
         4.NSMapTable可以在添加value的时候对value进行复制；
     和NSHashTable类似，NSMapTable可以随意的存储指针，并且利用指针的唯一性来进行对比和重复检查。
     假设用NSMapTable来存储不用被复制的keys和被若引用的value，这里的value就是某个delegate或者一种弱类型
         @property (nonatomic, strong, nonnull) NSMapTable<KeyType, ObjectType> *weakCache; // strong-weak cache
     

 */

#import "NSTimerObserver.h"

#define LOCK(lock) dispatch_semaphore_wait(lock, DISPATCH_TIME_FOREVER);

#define UNLOCK(lock) dispatch_semaphore_signal(lock);

@interface NSTimerObserver ()

@property (strong, nonatomic, nonnull) dispatch_semaphore_t operationsLock; // a lock to keep the access to `External Operations` thread-safe

// key is copy, value is weak because operation instance is retained by SDWebImageManager's runningOperations property
// we should use lock to keep thread-safe because these method may not be acessed from main queue
@property (nonatomic, strong, nonnull) NSMapTable< NSString * , id<TimerObserver> > *weakCache; // strong-weak cache

//@property (nonatomic, weak) id <TimerObserver> delegate;

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
