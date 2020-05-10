//
//  Produce-Consume.m
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2019/9/2.
//  Copyright © 2019 xinxin. All rights reserved.
//

typedef void(^Success)(id data);

#import "Produce_Consume.h"
#import <UIKit/UIKit.h>
@interface Produce_Consume()
@property (nonatomic,strong) NSCondition *condition;
@property (nonatomic,strong) NSOperationQueue *producerQueue;
@property (nonatomic,strong) NSOperationQueue *consumerQueue;
@property (nonatomic,copy) NSMutableArray *products;

// 信号量实现
@property (nonatomic, strong) NSMutableArray *array;//存放数据
@property (nonatomic, strong) dispatch_semaphore_t semaphore;

@end

@implementation Produce_Consume

//MARK: - 信号量 实现 https://www.jianshu.com/p/ea1985006e1a
/*
 对于生产者和消费者的理解是：需要有一个缓存池，生产者和消费者需要在不同的线程中去分别操作缓存池，
 这时候就特别容易产生并发问题。
 */

- (void)load {
    //开启计时器
    // 消费多少数据是  由生产的频率决定的。比如 0.05 生产了40个 就会消费40个。下一个0.05生产的数据会等待上次消费完成
    NSTimer *curTimer =[NSTimer timerWithTimeInterval:0.05 target:self selector:@selector(producerFuncWithNumber:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:curTimer forMode:NSDefaultRunLoopMode];
    [curTimer fire];
    
    [self consumerFunc];
}


- (NSMutableArray *)array{
    if (!_array) {
        _array = [NSMutableArray array];
    }
    return  _array;
}

- (dispatch_semaphore_t)semaphore{
    if (!_semaphore) {
        _semaphore = dispatch_semaphore_create(1);
    }
    return _semaphore;
}

//生产者
- (void)producerFuncWithNumber:(NSInteger )number{
    //生产者生成数据
    dispatch_queue_t t = dispatch_queue_create("producerFuncWithNumber", DISPATCH_QUEUE_CONCURRENT);
    number = random()%10;
    dispatch_async(t, ^{
        dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
        NSString  *string = [NSString stringWithFormat:@"信息--------%ld",(long)number];
        [self.array addObject:string];
        NSLog(@"生产了%lu 个",(unsigned long)self.array.count);
        dispatch_semaphore_signal(self.semaphore);
        
    });
}

//消费者
- (void)consumerFunc{
    dispatch_queue_t t1 = dispatch_queue_create("consumerFunc", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(t1, ^{
        while (YES) {
            if (self.array.count > 0) {
                dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
                NSArray *cosumerArray = self.array.mutableCopy;
                // 处理耗时操作
                [self processingWithArray:cosumerArray Success:^(id data) {
                    NSLog(@"消费了%lu 个",(unsigned long)cosumerArray.count);
                    [self.array removeAllObjects];
                    dispatch_semaphore_signal(self.semaphore);
                }];
            }
        }
    });
}

// 耗时操作
-(void)processingWithArray:(NSArray *)array Success:(Success)success{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(2);
        dispatch_async(dispatch_get_main_queue(), ^{
            success(array);
        });
    });
}

//MARK: - NSCondition 实现

// 生产者队列

- (void)scheduleProducerQueue {
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        UIImage *image = nil;//produce an image;
        if (image) {
            [self.condition lock];//请求加锁,成功后开始操作products
            [self.products addObject:image];
            [self.condition signal];
            [self.condition unlock];
        }
    }];
    [self.producerQueue addOperation:operation];
}

// 消费者队列
- (void)scheduleConsumerQueue {
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        [self.condition lock];
        while (self.products.count == 0) {
            [self.condition wait];
        }
        UIImage *image = self.products.firstObject;
        // do image 耗时操作

        [self.products removeObjectAtIndex:0];
        [self.condition unlock];
    }];
    [self.consumerQueue addOperation:operation];
}


- (NSCondition *)condition {
    if (!_condition) {
        _condition = [[NSCondition alloc] init];
    }
    return _condition;
}

//使用NSOperationQueue是为了方便cancel
- (NSOperationQueue *)producerQueue {
    if (!_producerQueue) {
        _producerQueue = [[NSOperationQueue alloc] init];
        [_producerQueue setMaxConcurrentOperationCount:2];
    }
    return _producerQueue;
}

- (NSOperationQueue *)consumerQueue {
    if (!_consumerQueue) {
        _consumerQueue = [[NSOperationQueue alloc] init];
        [_consumerQueue setMaxConcurrentOperationCount:2];
    }
    return _consumerQueue;
}

- (NSMutableArray *)products {
    if (!_products) {
        _products = [[NSMutableArray alloc] initWithCapacity:3];
    }
    return _products;
}



@end
