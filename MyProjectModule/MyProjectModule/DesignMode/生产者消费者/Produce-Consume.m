//
//  Produce-Consume.m
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2019/9/2.
//  Copyright © 2019 xinxin. All rights reserved.
//

#import "Produce-Consume.h"
#import <UIKit/UIKit.h>
@interface Produce_Consume()
@property (nonatomic,strong) NSCondition *condition;
@property (nonatomic,strong) NSOperationQueue *producerQueue;
@property (nonatomic,strong) NSOperationQueue *consumerQueue;
@property (nonatomic,copy) NSMutableArray *products;


@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, strong) dispatch_semaphore_t semaphore;

@end

@implementation Produce_Consume

//MARK: - 信号量 实现 https://www.jianshu.com/p/ea1985006e1a
/*
 我对于生产者和消费者的理解是：需要有一个缓存池，生产者和消费者需要在不同的线程中去分别操作缓存池，
 这时候就特别容易产生并发问题。
 
 */


- (void)producerFuncs{

__block int count = 0;

//生产者生成数据
dispatch_queue_t t = dispatch_queue_create("222222", DISPATCH_QUEUE_CONCURRENT);

dispatch_async(t, ^{
while (YES) {
    count++;
    int t = random()%10;
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    [self.array addObject:[NSString stringWithFormat:@"%zd",t]];
dispatch_semaphore_signal(self.semaphore);
NSLog(@"生产了%zd",count);

}
});
    
    
}

//消费者
- (void)consumerFunc{
    
    __block int count = 0;
    
    //消费者消费数据
    
    dispatch_queue_t t1 = dispatch_queue_create("11111", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(t1, ^{
        
        while (YES) {
            if (self.array.count > 0) {
                count++;
                dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
                [self.array removeLastObject];
                dispatch_semaphore_signal(self.semaphore);
                NSLog(@"消费了%zd",count);
            }
        }
    });
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
        [self.products removeObjectAtIndex:0];
        //do something with image
        
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
