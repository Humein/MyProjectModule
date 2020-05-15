//
//  ThreadSafeContainer.m
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2020/3/29.
//  Copyright © 2020 xinxin. All rights reserved.
//

#import "ThreadSafeContainer.h"
#import "UIButton+ButtonBlockCategory.h"

@interface ThreadSafeContainer()
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic, strong) dispatch_semaphore_t semaphore;
@property (strong, nonatomic, nonnull) dispatch_queue_t syncQueue;

@end

@implementation ThreadSafeContainer {
    NSMutableArray<id<YTKUrlFilterProtocol>> *_readOnlyArray;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _readOnlyArray = [NSMutableArray array];
    }
    return self;
}

- (void)dealloc {
    
}

- (void)viewDidLoad
{
    [self configData];
    __weak typeof (self) weakSelf = self;
    UIButton *start = [UIButton createButtonWithFrame:CGRectMake(20, 100, 44, 44) title:@"开始" titleColor:[UIColor blueColor] bgImageName:@"" actionBlock:^(UIButton *button) {
        [weakSelf start];
    }];
    [self.view addSubview:start];
    
    UIButton *stop = [UIButton createButtonWithFrame:CGRectMake(70, 100, 44, 44) title:@"移除" titleColor:[UIColor redColor] bgImageName:@"" actionBlock:^(UIButton *button) {
        [weakSelf removeAllObjs];
    }];
    [self.view addSubview:stop];
        
    //  初始化信号量
    _semaphore = dispatch_semaphore_create(1);
    //  派发队列
    _syncQueue = dispatch_queue_create("com.effectiveobjectivec.syncQueue", NULL);


}


#pragma mark - 数据安全测试  1:操作保证线程安全 数据完整性没有处理
- (void)configData
{
    self.dataSource = [NSMutableArray array];
    for (int i = 0; i < 100; i++) {
        [self.dataSource addObject:[NSString stringWithFormat:@"Obj - %i", i]];
    }
}

- (void)start{
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        @synchronized(self.dataSource) {
//            for (int i = 0; i < self.dataSource.count; i++) {
//                   [NSThread sleepForTimeInterval:0.05];
//                   NSLog(@"%@", self.dataSource[i]);
//            }
//        }
//    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
        for (int i = 0; i < self.dataSource.count; i++) {
            [NSThread sleepForTimeInterval:0.05];
            NSLog(@"%@",self.dataSource[i]);
        }
        dispatch_semaphore_signal(self.semaphore);
    });
}

- (void)removeAllObjs{
//    @synchronized(self.dataSource) {
//        [self.dataSource removeAllObjects];
//    }
    
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    [self.dataSource removeAllObjects];
    dispatch_semaphore_signal(self.semaphore);
}

#pragma mark - 数据安全测试  2:线程安全 读取操作及写入操作都安排在同一个队列里，即可保证数据同步。
/** https://lockxmonk.github.io/15049238737460.html
 但是如果我们想要自己实现属性访问方法时，可以：
 -(NSString*)someString {
     @synchronized(self) {
         return _someString;
     }
 }
 -(void)setSomeString:(NSString*)someString {
     @synchronized(self) {
         _someString = someString;
     }
 }
 但是滥用@synchronized(self)会很危险，因为所有同步块都会彼此抢夺同一个锁。要是有很多个属性都这么写的话，那么每个属性的同步块都要等其他所有同步块执行完毕才能执行，这也许并不是开发者想要的效果。我们只是想令每个属性各自独立地同步。

 - 而且上述做法并不是绝对的线程安全。因为在两次访问操作之间，其他线程可能会写入新的属性值。
 
 - 这里我们使用“串行同步队列”（serial synchronization queue)。将读取操作及写入操作都安排在同一个队列里，即可保证数据同步。
 
 此模式的思路是：把设置操作与获取操作都安排在序列化的队列里执行（串行同步队列并不会拓展新的线程），这样的话，所有针对属性的访问操作就都同步了。（关于GCD的串行队列/并发队列与iOS多线程这里不详细讲解了，后续深入探讨）。
 */

/**
 _syncQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

 -(NSString*}someString {
     __block NSString *localSomeString;
     dispatch_sync( _syncQueue, ^{
         localSomeString = _someString;
     })；
     return localSomeString;
 }

 -(void)setSomeString:(NSString*)someString {
         dispatch_async(syncQueue, ^{
         _someString = someScring;
     });
 }
 */



#pragma mark - 设计一个只读的容器
// 重写 get
- (NSArray<id<YTKUrlFilterProtocol>> *)readOnlyArray {
    return [_readOnlyArray copy];
}



#pragma mark - 设计一个读写安全的容器
/**
 - 怎么使用GCD实现线程安全的属性，他们的getter和setter应该怎么写 (读写隔离，线程安全的容器)
    创建一个串行队列，然后setter和getter都使用dispatch.sync的方法，利用串行队列的特性，限制读写行为有次序的进行
   
 - 如果我想能并发的读，要做什么修改
    改成并发队列，setter改成使用dispatch_barrier_async，实现多读单写

 */

@end
