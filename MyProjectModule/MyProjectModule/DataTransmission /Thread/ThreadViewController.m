//
//  ThreadViewController.m
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/7/25.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import "ThreadViewController.h"
#import "NSTimerObserver.h"
#import "ThreadSafeContainer.h"
#import "MyProjectModule-Swift.h"
#import <sqlite3.h>

@interface ThreadViewController ()<TimerObserverDelegate>
{
    int _i;
    pthread_mutex_t _lock; //互斥锁
}
@property (strong, nonatomic, nonnull) dispatch_queue_t coderQueue; // the queue to do image decoding

@end

@implementation ThreadViewController

- (void)dealloc{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self sqlMultipleInsert]; return;
    [self runLoop]; return;
    [self lockTest0]; return;
    [self lockTest1]; return;
    [self testThread1];
    //请求依赖
    [self GCDGroup];
    [self semaphore];
    [self barrier];

    [self threadTestOne];

    [[SDTimerObserver sharedInstance] addTimerObserver:self];
    
}

#pragma mark - 测试
-(void)sqlMultipleInsert{
    NSArray *d = nil;
    NSMutableArray *dataArray = [NSMutableArray arrayWithArray:d];
    NSArray *dataArray1 = [NSArray arrayWithArray:d];
//    NSArray *da2 = @[@"",@"",d,@""]; // 崩溃
    
    dispatch_queue_t serialQueue = dispatch_queue_create("serialQueue", DISPATCH_QUEUE_SERIAL);
    dispatch_sync(serialQueue, ^{
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
        for (int i = 0; i < 20; i++) {
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            [self sendMessage:@"" callback:^(NSString *tag) {
                [self insertData:@"1"];
                dispatch_semaphore_signal(semaphore);
            }];
        }
    });
}

- (BOOL)insertData:(NSString *)jsonStr {
    __block BOOL isSuc;
    dispatch_queue_t serialQueue = dispatch_queue_create("serialQueues", DISPATCH_QUEUE_SERIAL);
    dispatch_sync(serialQueue, ^{
        isSuc = YES;
        int rc;
        sqlite3_stmt *pStmt      = 0x00;
        rc = sqlite3_step(pStmt);
        NSLog(@"000000000000");
    });
    return isSuc;
}

#pragma mark - RunLoop 使用runMode:beforeDate同步
-(void)runLoop{
    __block int done = 0;
    __block NSString *object;
    [self sendMessage:@"" callback:^(NSString *tag) {
        object = tag;
        done = 1;
    }];
    dispatch_async(dispatch_get_main_queue(), ^{
        sleep(1);
        done = 1;
        NSLog(@"哈哈同步成功了。。。");;
    });
    while (done == 0) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
    NSLog(@"=======%@", object);
}

#pragma mark - 测试 block 加锁同步
/// 测试 block 加锁同步
-(void)lockTest0{
    _coderQueue =  dispatch_queue_create("com.hackemist.SDWebImageDownloaderOperationCoderQueue", DISPATCH_QUEUE_CONCURRENT);
    
//    dispatch_semaphore_t dsema = dispatch_semaphore_create(0); //
//    NSRecursiveLock *slock = [[NSRecursiveLock alloc]init]; // 重复加锁没问题
//    NSLock *slock = [NSLock new]; // 重复加锁会死锁
//    pthread_mutex_t pMutex = PTHREAD_MUTEX_INITIALIZER; __block pthread_cond_t pCond = PTHREAD_COND_INITIALIZER; pthread_mutex_lock(&pMutex);// 重复加锁会死锁
//    NSCondition *condition = [[NSCondition alloc] init];[condition lock]; //
//    __block OSSpinLock oslock = OS_SPINLOCK_INIT; OSSpinLockLock(&oslock);
   
    
    
    /* 情况：1 一般自定义block
     OSSpinLock dispatch_semaphore_t pthread_mutex_t 等都会加锁成功
     */
    [self sendMessage:@"" callback:^(NSString *tag) {
        sleep(1);
        NSLog(@"11111111");
//        OSSpinLockUnlock(&oslock);
//        dispatch_semaphore_signal(dsema);
    }];
    NSLog(@"22222222");
//    OSSpinLockLock(&oslock);
//    dispatch_semaphore_wait(dsema, DISPATCH_TIME_FOREVER);
    NSLog(@"33333333");

    
    /* 情况：2 系统的block 危险：因为不知道内部block实现方式有可能会死锁
     比如 iOS14 [PHPhotoLibrary requestAuthorization:] [PHPhotoLibrary requestAuthorizationForAccessLevel:]
     使用dispatch_semaphore_t 请求相册权限时候会死锁。使用别的加锁方式虽然不会卡死，但加锁不成功
     */
    
    
    /* 情况：3
     dispatch_get_main_queue() 主队列
         - dispatch_semaphore_t NSCondition pthread_mutex_t OSSpinLock 会死锁
         - NSLock NSRecursiveLock pthread_mutex_t 加锁会失败 那是因为加锁方式不对 block加锁同步和正常加锁保护 有区别的
     _coderQueue 并发队列
         - 所有加锁方式都会成功
     */
    
    dispatch_async(dispatch_get_main_queue(), ^{
        sleep(1);
        NSLog(@"11111111");
//        OSSpinLockUnlock(&oslock);
//        [condition signal];
//        pthread_cond_signal(&pCond);
//        dispatch_semaphore_signal(dsema);
    });
    NSLog(@"22222222");
//    OSSpinLockLock(&oslock);
//    [condition wait]; [condition unlock];
//    pthread_cond_wait(&pCond, &pMutex); pthread_mutex_destroy(&pMutex);
//    dispatch_semaphore_wait(dsema, DISPATCH_TIME_FOREVER);
    NSLog(@"33333333");
}

// 这种加锁同步block是不对的
-(void)lockTest1{
    NSLock *slock = [NSLock new];
    [self sendMessage:@"" callback:^(NSString *tag) {
        NSLog(@"11111111");
        [slock unlock];
    }];
    NSLog(@"22222222");
    [slock lock];
    NSLog(@"33333333");
}

// 自定义Block
- (void)sendMessage:(NSString *)message callback:(void(^)(NSString *tag))callback {
    float random = 1 + (arc4random()%100)/30.0;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(random * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *tag = [NSString stringWithFormat:@"%@ - random:%f", message, random];
        sleep(1);
        callback(tag);
    });
}

#pragma mark - 多线程线程学习
/** https://juejin.im/post/5e7db4046fb9a03c714b3776
 
 - GCD中dispatch_queue大致可以分为三类
 全局的并行的queue - dispatch_get_global_queue
 主线程的串行的queue - dispatch_get_main_queue
 自定义的queue - dispatch_queue_create
 
 - GCD是同步还是异步情况会开启多线程?
   - 同步是不会开启新的线程的，异步才会开启新的线程。
     通过代码验证 同步 在 串行队列 和 并发队列 情况下会不会创建新的线程
 - dispatch_get_global_queue
 dispatch_get_global_queue是全局队列是并发队列，并由整个进程共享。进程中存在三个全局队列：高、中（默认）、低三个优先级队列。可以调用dispatch_get_global_queue函数传入优先级来访问队列。
 dispatch_queue_create使用户队列，由用户通过dispatch_queue_create来自行创建的串行队列，可以用于完成同步机制

*/
-(void)async0{
    // 创建串行队列
    dispatch_queue_t serialQueue = dispatch_queue_create("serialQueue", DISPATCH_QUEUE_SERIAL);
    // 创建并发队列
    dispatch_queue_t conQueue = dispatch_queue_create("conQueue", DISPATCH_QUEUE_CONCURRENT);

    NSLog(@"(1).=====%@",[NSThread currentThread]);
    // 串行同步
    dispatch_sync(serialQueue, ^{
      NSLog(@"(2).=====%@",[NSThread currentThread]);
    });
    // 并发同步
    dispatch_sync(conQueue, ^{
      NSLog(@"(3).=====%@",[NSThread currentThread]);
    });
    
//    (1).=====<NSThread: 0x2837f6f00>{number = 1, name = main}
//    (2).=====<NSThread: 0x2837f6f00>{number = 1, name = main}
//    (3).=====<NSThread: 0x2837f6f00>{number = 1, name = main}

}

/**
 二问：异步一定会开启新的线程吗。
 答：不会，异步在主队列里不会创建新的线程，在其他串行和并发队列都会创建新的子线程
 */
-(void)async1{
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    dispatch_queue_t serialQueue = dispatch_queue_create("serialQueueasync1", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t conQueue = dispatch_queue_create("conQueueasync1", DISPATCH_QUEUE_CONCURRENT);

    NSLog(@"(1).=====%@",[NSThread currentThread]);
    dispatch_async(serialQueue, ^{
      NSLog(@"(2).=====%@",[NSThread currentThread]);
    });
    dispatch_async(conQueue, ^{
      NSLog(@"(3).=====%@",[NSThread currentThread]);
    });
    dispatch_async(mainQueue, ^{
      NSLog(@"(4).=====%@",[NSThread currentThread]);
    });

//    (1).=====<NSThread: 0x2800a6f00>{number = 1, name = main}
//    (2).=====<NSThread: 0x2800ca5c0>{number = 3, name = (null)}
//    (3).=====<NSThread: 0x2800ca5c0>{number = 3, name = (null)}
//    (4).=====<NSThread: 0x2800a6f00>{number = 1, name = main}
    
    /**
     但是仔细看线程号 发现（2）和（3） 对应的 number 都是3 。 也就是这两个异步动作只创建了一个新的线程。按照常识来说不是应该创建两个不同线程吗？
     这儿就要从时间和空间谈到GCD对线程调度优化问题了。
     所以GCD会自动权衡根据任务分配合适的线程数，从而达到空间和时间的最优。
     这个问题的总结：

     同步：不具备开启线程的能力，一定串行执行任务
     异步：具有开启线程的能力，但是在主队列里不会开启新的线程。 如果在串行队列和并发队列里开启n个子线程，gcd优化之后未必会真的有n个子线程。
     */

}




#pragma mark - 多线程测试

-(void)threadTestOne{
    //1--   DISPATCH_QUEUE_SERIAL 串行  DISPATCH_QUEUE_CONCURRENT 并发
    _coderQueue =  dispatch_queue_create("com.hackemist.SDWebImageDownloaderOperationCoderQueue", DISPATCH_QUEUE_CONCURRENT);
    // 开启一个子线程
    dispatch_async(self.coderQueue, ^{
        self->_i = 10;
        sleep(1);
        [[NSThread currentThread] setName:@"1"];
        NSLog(@"1------%@", [NSThread currentThread]); // 打印当前线程
        
    });
    
    dispatch_async(self.coderQueue, ^{
        
        NSLog(@"2------%@", [NSThread currentThread]); // 打印当前线程
        
    });
    
    
    //2--  dispatch_get_global_queue 获取一个全局的队列  异步刷新
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"异步线程");
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"异步主线程");
        });
    });
}


// 控制处理延时  先提高再降低
-(void)testSemaphone_process_delay{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        __block BOOL status = NO;
        for (int i = 0; i < 3; i++) {
            dispatch_semaphore_t dsema = dispatch_semaphore_create(0);
            
            [self simulateTime_consumingOperation:^(BOOL suc) {
                status = suc;
                dispatch_semaphore_signal(dsema);
            }];
            
            NSLog(@"status === %@",@(status).stringValue);

            // 等待处理结果 最多等20秒
            dispatch_semaphore_wait(dsema, dispatch_time(DISPATCH_TIME_NOW, 20 * NSEC_PER_SEC));
            
            NSLog(@"status === %@",@(status).stringValue);
            
            if (status)
            {
                // do Something
                break;
            }
        }
        
    });
    
}

// semaphone 控制线程数量 并发/做锁    先降低再提高
-(void)testDispatch_semaphone_Thread{
    //crate的value表示，最多几个资源可访问
    
    //设定的信号值为2，先执行两个线程，等执行完一个，才会继续执行下一个，保证同一时间执行的线程数不超过2。
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(2);
    
    //设定为3，就是不限制线程执行了，因为一共才只有3个线程
//    dispatch_semaphore_t semaphore = dispatch_semaphore_create(3);

    dispatch_queue_t quene = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    //任务1
    dispatch_async(quene, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"run task 1");
        sleep(1);
        NSLog(@"complete task 1");
        dispatch_semaphore_signal(semaphore);
    });
    
    //任务2
    dispatch_async(quene, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"run task 2");
        sleep(1);
        NSLog(@"complete task 2");
        dispatch_semaphore_signal(semaphore);
    });
    
    //任务3
    dispatch_async(quene, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"run task 3");
        sleep(1);
        NSLog(@"complete task 3");
        dispatch_semaphore_signal(semaphore);
    });
}


#pragma mark - 死锁测试
-(void)lockTest{
    dispatch_queue_t myCustomQueue;
    // NULL 默认串行队列
    myCustomQueue = dispatch_queue_create("com.example.MyCustomQueue", NULL);

    // 异步添加
    dispatch_async(myCustomQueue, ^{
        printf("做一些工作\n");
    });
     
    printf("第一个 block 可能还没有执行\n");

    // 同步添加
    dispatch_sync(myCustomQueue, ^{
        printf("做另外一些工作\n");
    });
    
    printf("两个 block 都已经执行完毕\n");

    dispatch_queue_t queue = dispatch_queue_create("com.demo.serialQueue", DISPATCH_QUEUE_SERIAL);
    NSLog(@"1"); // 主队列 - 任务1
    dispatch_async(queue, ^{
        NSLog(@"2"); // queue-任务2
        while (1) {
            // 死循环
        }
        dispatch_sync(queue, ^{
            NSLog(@"死锁"); // queue -任务3 要加到 queue中
        });
        NSLog(@"4"); // queue-任务4
    });
    NSLog(@"5"); // 主队列 - 任务5
    
    dispatch_sync(dispatch_get_main_queue(), ^{
        NSLog(@"死锁"); // 任务2
    });

}


#pragma mark - GCD  Group
//1： dispatch_group_create dispatch_group_enter dispatch_group_leave

-(void)GCDGroup{
    
//    group = dispatch_group_create();
//    for (url in urlsToFetch) {
//        dispatch_group_enter(group);
//        dispatch_async(dispatch_get_global_queue(…), ^{
//            … fetch `url` synchronously …
//            dispatch_group_leave(group);
//        });
//    }
//    dispatch_group_wait(group, …);
    

    
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_enter(group);
    
    
    
    
    dispatch_group_async(group, dispatch_queue_create("com.dispatch.test", DISPATCH_QUEUE_CONCURRENT), ^{
        
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://www.baidu.com"]];
        NSURLSessionDownloadTask *task = [[NSURLSession sharedSession] downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            // 请求完成，可以通知界面刷新界面等操作
            NSLog(@"第一步网络请求完成");
            
        }];
        [task resume];
        // 以下还要进行一些其他的耗时操作
        NSLog(@"耗时操作继续进行0");
    });
    
    dispatch_group_async(group, dispatch_queue_create("com.dispatch.test", DISPATCH_QUEUE_CONCURRENT), ^{
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://www.github.com"]];
        NSURLSessionDownloadTask *task = [[NSURLSession sharedSession] downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            // 请求完成，可以通知界面刷新界面等操作
            NSLog(@"第二步网络请求完成");
            dispatch_group_leave(group);
            
        }];
        [task resume];
        // 以下还要进行一些其他的耗时操作
        NSLog(@"耗时操作继续进行1");
    });
    
    
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"刷新界面等在主线程的操作");
    });
    
}

#pragma mark - 线程同步 --阻塞任务（dispatch_barrier）：
-(void)barrier {
    /* 创建并发队列 */
//    注意：使用 dispatch_barrier_async ，该函数只能搭配自定义并行队列 dispatch_queue_t 使用。不能使用： dispatch_get_global_queue ，否则 dispatch_barrier_async 的作用会和 dispatch_async 的作用一模一样。 ）
    dispatch_queue_t concurrentQueue = dispatch_queue_create("test.concurrent.queue", DISPATCH_QUEUE_CONCURRENT);
    /* 添加两个并发操作A和B，即A和B会并发执行 */
    dispatch_async(concurrentQueue, ^(){
        NSLog(@"OperationA");
    });
    dispatch_async(concurrentQueue, ^(){
        NSLog(@"OperationB");
    });
    /* 添加barrier障碍操作，会等待前面的并发操作结束，并暂时阻塞后面的并发操作直到其完成 */
    dispatch_barrier_async(concurrentQueue, ^(){
        NSLog(@"OperationBarrier!");
    });
    /* 继续添加并发操作C和D，要等待barrier障碍操作结束才能开始 */
    dispatch_async(concurrentQueue, ^(){
        NSLog(@"OperationC");
    });
    dispatch_async(concurrentQueue, ^(){
        NSLog(@"OperationD");
    });
}


#pragma mark - 线程同步 -- 信号量机制（dispatch_semaphore）

//    dispatch_semaphore_create：创建一个信号量（semaphore）
//    dispatch_semaphore_signal：信号通知，即让信号量+1
//    dispatch_semaphore_wait：等待，直到信号量大于0时，即可操作，同时将信号量-1

-(void)semaphore{
    //1.任务一：下载图片
    NSBlockOperation *operation1 = [NSBlockOperation blockOperationWithBlock:^{
        [self request_A];
    }];
    
    //2.任务二：打水印
    NSBlockOperation *operation2 = [NSBlockOperation blockOperationWithBlock:^{
        [self request_B];
    }];
    
    //3.任务三：上传图片
    NSBlockOperation *operation3 = [NSBlockOperation blockOperationWithBlock:^{
        [self request_C];
    }];
    
    //4.设置依赖
    [operation2 addDependency:operation1];      //任务二依赖任务一
    [operation3 addDependency:operation2];      //任务三依赖任务二
    
    //5.创建队列并加入任务
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperations:@[operation3, operation2, operation1] waitUntilFinished:NO];
}

-(void)request_A{
//1    创建
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://www.cocoachina.com"]];
    NSURLSessionDownloadTask *task = [[NSURLSession sharedSession] downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //2 计数+1操作
        dispatch_semaphore_signal(sema);
        
        NSLog(@"第一步网络请求完成");
        
    }];
    
    [task resume];
    
    //3 若计数为0则一直等待
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    
}
-(void)request_B{
    
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://www.github.com"]];
    NSURLSessionDownloadTask *task = [[NSURLSession sharedSession] downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_semaphore_signal(sema);
        
        NSLog(@"第二步网络请求完成");
        
    }];
    [task resume];
    
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    
}
-(void)request_C{
    
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://www.baidu.com"]];
    NSURLSessionDownloadTask *task = [[NSURLSession sharedSession] downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_semaphore_signal(sema);
        
        NSLog(@"第三步网络请求完成");
        
    }];
    [task resume];
    
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    
}

#pragma mark - NSOperation 和 NSOperationQueue


#pragma mark - dispatch_apply

-(void)dispatch_apply1{
    dispatch_queue_t queue = dispatch_queue_create("myqueue", DISPATCH_QUEUE_CONCURRENT);
    //并发的运行一个block任务5次
    dispatch_apply(5, queue, ^(size_t i) {
        NSLog(@"%@我开始执行 %zu times",[NSThread currentThread],i+1);
        NSLog(@"do a job %zu times",i+1); // 还是有序的。。。
    });
    NSLog(@"go on");
}

-(void)dispatch_apply2{
    dispatch_queue_t q = dispatch_queue_create("queue", DISPATCH_QUEUE_CONCURRENT);
    //危险，可能导致线程爆炸以及死锁
    for (int i = 0; i < 99; i++){
       dispatch_async(q, ^{
           NSLog(@"do a job %d times",i+1);
       });
    }
    dispatch_barrier_sync(q, ^{});
    NSLog(@"dispatch_async go on");


    // 较优选择， GCD 会管理并发
    dispatch_apply(99, q, ^(size_t i){
        NSLog(@"dispatch_apply do a job %lu times",i+1);
    });
    NSLog(@"dispatch_apply go on");
    
    // or
    NSArray *dictArray = nil;//存放从服务器返回的字典数组
    /*!
    2  *  @brief  推荐在dispatch_async函数中异步执行dispatch_apply函数
    3     效果     dispatch_apply函数与dispatch_sync函数形同,会等待处理执行结束
    4  */
    dispatch_queue_t queue = dispatch_queue_create("queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        dispatch_apply(dictArray.count, queue,  ^(size_t index){
            //字典转模型
        });
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"主线程更新");
        });
    });

}

- (void)testThread1 {
    
    dispatch_queue_t queue = dispatch_queue_create("com.demo.serialQueue", DISPATCH_QUEUE_SERIAL);
    NSLog(@"1"); // 主队列 - 任务1
    dispatch_async(queue, ^{
        NSLog(@"2"); // queue-任务2
//        dispatch_sync(queue, ^{
//            NSLog(@"3"); // queue -任务3 要加到 queue中
//        });
//        NSLog(@"4"); // queue-任务4
    });
    NSLog(@"5"); // 主队列 - 任务5
    // log 1 5 2 然后崩溃
    
    
    /**
     a b c都需要5分钟, 问打印结果 以及 abc当前线程和一共执行时间
     串行队列
     async（a）
     sync（b）
     c
     
     */
    dispatch_queue_t serialQueue = dispatch_queue_create("serialQueue111", DISPATCH_QUEUE_SERIAL);
    dispatch_async(serialQueue, ^{
      sleep(5);
      NSLog(@"a.=====%@",[NSThread currentThread]);
    });
    // 主要原因  这个地方同步 导致 先执行a
    dispatch_sync(serialQueue, ^{
//        sleep(5);
      NSLog(@"b.=====%@",[NSThread currentThread]);
    });
//    sleep(5);
    NSLog(@"c.=====%@",[NSThread currentThread]);
    
    /**
     串行队列的话 打印 a.b.c
     时间15
     
     并行队列的话 打印 b a c 如果 a 中有耗时 打印 b c  a
     */
}


#pragma mark - 一些事件
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [[SDTimerObserver sharedInstance] removeTimerObserver:self];
//
//    [self testSemaphone_process_delay];
//
//    [self async0];
//    [self async1];
    
    [self dispatch_apply2];
    
}


/// 回调
- (void)timerCallBackWithTimer:(SDTimerObserver * _Nonnull)timer {
        _i++;
    NSLog(@"%@====%d",[self class],_i);
}


@end
