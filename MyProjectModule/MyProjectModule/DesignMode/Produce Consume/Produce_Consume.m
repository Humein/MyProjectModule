//
//  Produce-Consume.m
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2019/9/2.
//  Copyright © 2019 xinxin. All rights reserved.
//

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
 我对于生产者和消费者的理解是：需要有一个缓存池，生产者和消费者需要在不同的线程中去分别操作缓存池，
 这时候就特别容易产生并发问题。
 
 我们公司自己项目中，有个场景，就是IM消息，当我们收到消息时候，进行一些业务逻辑的处理，还有数据库的操作，然后刷新列表。存在的问题是，如果消息接收的特别快，例如离线消息，可能登陆的是，有几百条消息拉取下来，如果每一条每一条的处理，将会导致两个问题：

 上次刷新还没完成，下次就进来了。导致界面闪的问题
 每条消息进行一次写入数据库操作，IO操作耗时，所以导致，性能问题严重

 */

- (void)load {
    //开启计时器
    NSTimer *curTimer =[NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(producerFuncWithNumber:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:curTimer forMode:NSDefaultRunLoopMode];
    [curTimer fire];
    
    [self consumerFunc];
}


-(void)reload{
    NSLog(@"休眠2秒");
    // 处理耗时操作
    sleep(2);
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
    
    number = random()%10;
    //生产者生成数据
    dispatch_queue_t t = dispatch_queue_create("222222", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(t, ^{
        dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
        
        [self.array addObject:[NSString stringWithFormat:@"%ld",(long)number]];
        NSLog(@"生产了%lu 个",(unsigned long)self.array.count);
        dispatch_semaphore_signal(self.semaphore);
        
    });
}

//消费者
- (void)consumerFunc{
    
    dispatch_queue_t t1 = dispatch_queue_create("11111", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(t1, ^{
        
        while (YES) {
            if (self.array.count > 0) {
                dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
                NSLog(@"消费了%lu 个",(unsigned long)self.array.count);
                [self.array removeAllObjects];
                // 消费时机 处理完成就可以消费了 不用特指？
                [self reload];
                dispatch_semaphore_signal(self.semaphore);
                
            }
        }
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
