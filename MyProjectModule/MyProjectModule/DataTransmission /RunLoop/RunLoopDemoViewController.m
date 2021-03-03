
//  RunLoopDemoViewController.m
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2018/11/17.
//  Copyright © 2018 xinxin. All rights reserved.
//

#import "RunLoopDemoViewController.h"

typedef void(^RunloopBlock)(void);

@interface RunLoopDemoViewController ()

@property (nonatomic, strong) NSMutableArray *tasks;


@end

@implementation RunLoopDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tasks = [NSMutableArray array];
    [self addRunloopObserver];
    
}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
//    可以看出，为imageView设置image,是在UITrackingRunLoopMode中进行的，如果图片很大，图片解压缩和渲染肯定会很耗时，那么卡顿就是必然的。
    
    NSLog(@"current:%@",[NSRunLoop currentRunLoop].currentMode);
    [self addtask:^{
        
        NSLog(@"1111111111");
        
    }];
}




#pragma mark - <关于Runloop的>
// 添加任务的方法
- (void)addtask:(RunloopBlock)block{
    
    [self.tasks addObject:block];
    // 为了保证屏幕以外的图片不用渲染,超出最大显示数量的图片时
    if (self.tasks.count > 18) {
        //        [self.tasks removeObjectAtIndex:0];
    }
    
}

// 添加观察者
- (void)addRunloopObserver{
    //拿到当前Runloop
    CFRunLoopRef runloop = CFRunLoopGetCurrent();
    
    //定义观察者
    static CFRunLoopObserverRef runloopObserver;
    
    // 创建上下文
    CFRunLoopObserverContext context = {
        0,
        (__bridge void *)self, //在会调用中获取到self
        &CFRetain,
        &CFRelease,
        NULL
    };
    NSObject
    runloopObserver = CFRunLoopObserverCreate(NULL, kCFRunLoopBeforeWaiting, YES, 0, &callBack, &context);
    
    //    监听 kCFRunLoopCommonModes 模式
//     添加到当前的Runloop中,使用kCFRunLoopCommonModes模式可以在拖动时渲染
//       避免在 UITrackingRunLoopMode 进行的，如果图片很大，图片解压缩和渲染肯定会很耗时，那么卡顿就是必然的。
    CFRunLoopAddObserver(runloop, runloopObserver, kCFRunLoopCommonModes);
    
    CFRelease(runloopObserver);
    
}

static void callBack(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info){
    // 在这个函数里self不能用，需要用context转换一下，info就是控制器，从context传过来的
    RunLoopDemoViewController *vc = (__bridge RunLoopDemoViewController *)info;
    
    
    NSLog(@"observer+ current:%@",[NSRunLoop currentRunLoop].currentMode);
    NSLog(@"来了%zd------activity=%lu",vc.tasks.count,activity);
    
    if (vc.tasks.count) {
        // 从数组中获取任务
        RunloopBlock block = vc.tasks.firstObject;
        // 执行任务
        block();
        // 干掉数组中完成的任务
        [vc.tasks removeObjectAtIndex:0];
    }
    
}

//MARK: 监控卡顿
/*
// 注册RunLoop状态观察，并计算是否卡顿  单个Observer监听，有问题。应该使用双Observer监听
- (void)registerRunLoopObserver
{
    self.ANRShortTimeInterval = (self.ANRShortTimeInterval > 0 ?: 2) * 1000;
    self.ANRLongTimeInterval = (self.ANRLongTimeInterval > 0 ?: 5) * 1000;
    
    // Dispatch Semaphore保证同步
    self->semaphore = dispatch_semaphore_create(0);
    
    // 创建一个观察者
    CFRunLoopObserverContext context = {0,(__bridge void*)self,NULL,NULL};
    CFRunLoopObserverRef observer = CFRunLoopObserverCreate(kCFAllocatorDefault,
                                                            kCFRunLoopAllActivities,
                                                            YES,
                                                            0,
                                                            &runLoopObserverCallBack,
                                                            &context);
    // 将观察者添加到主线程runloop的common模式下的观察中
    CFRunLoopAddObserver(CFRunLoopGetMain(), observer, kCFRunLoopCommonModes);
    
    __block NSTimeInterval startTime;

    // 在子线程监控时长
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 子线程开启一个持续的loop用来进行监控
        while (YES) {
            // 假定连续5次超时50ms认为卡顿(当然也包含了单次超时250ms)
            long semaphoreWait = dispatch_semaphore_wait(self->semaphore, dispatch_time(DISPATCH_TIME_NOW, 50 * NSEC_PER_MSEC));
            if (semaphoreWait != 0) {///如果返回不等于0  说明没收到dispatch_semaphore_signal信号，说明一次runloop没完成
                if (self->runLoopActivity == kCFRunLoopBeforeSources || self->runLoopActivity == kCFRunLoopAfterWaiting) {
                    self->timeoutCount++;
                }
            }
            else{///说明已经完成一次runloop
                if (self->timeoutCount >=5){
                    //timeoutCount大于等于5，说明这次runloop卡顿时间超过5次*50ms的时间，也就是大于250ms，需要记录卡顿
                    
                    // 卡顿时间
                    long long ANRTimeInterval = 50 * self->timeoutCount;
                    long long endTimeInterval = [[NSDate date] timeIntervalSince1970] * 1000;
                    long long startTimeInterval = endTimeInterval - ANRTimeInterval;
                    
                    if (ANRTimeInterval >= self.ANRShortTimeInterval) {
//                        TALAPMLogMsg(@"卡顿结束了，这次卡了%lf秒，timeoutCount=%ld",ANRTimeInterval,self->timeoutCount);
                        NSString* blockType = @"ShortBlock";
                        if (ANRTimeInterval >= self.ANRLongTimeInterval) {
                            blockType = @"LongBlock";
                        }
                        NSDictionary *longBlockInfo = [NSMutableDictionary dictionary];
                        [longBlockInfo setValue:@(ANRTimeInterval) forKey:@"threadTimeCost"];
                        [longBlockInfo setValue:@(endTimeInterval) forKey:@"timeEnd"];
                        [longBlockInfo setValue:@(startTimeInterval) forKey:@"timeStart"];
                        [longBlockInfo setValue:@(ANRTimeInterval) forKey:@"blockTime"];
                        
                        NSString *stackStr = [TALAPMANRStack tal_backtraceOfMainThread];
                        NSString *name = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleExecutableKey];
                        NSArray *array = [stackStr componentsSeparatedByString:@"\n"];
                        __block NSString *blockMessage = @"";
                        [array enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                            if ([obj containsString:name]) {
                                blockMessage = obj;
                                * stop = YES;
                            }
                        }];
                        if (!blockMessage.length) {
                            blockMessage = array.firstObject;
                        }
                        [longBlockInfo setValue:blockMessage?:@"" forKey:@"blockMessage"];
                        [longBlockInfo setValue:stackStr?:@"" forKey:@"threadStackEntriesForExport"];
                        
                        NSMutableDictionary * paramDict = [NSMutableDictionary dictionary];
                        
                        [paramDict setValue:blockType forKey:@"blockType"];
                        [paramDict setValue:longBlockInfo forKey:@"longBlockInfo"];
                        if (self.dataCallBack) {
                            self.dataCallBack(paramDict);
                        }
                    }
                }
                self->timeoutCount = 0;
            }
        }
    });
    
//    #"blockType": "LongBlock", //卡顿类型 ShortBlock  LongBlock
//      "scene":"com.xueersi.home.homeActivity"
//      "longBlockInfo": {
//        "blockTime": 645,     //卡顿时长
//        "threadStackEntriesForExport": {  //线程的堆栈情况(去重并且转换为字符串显示)
//          "12-28 16:48:30.949": [
//            "android.os.BinderProxy.transactNative(Native Method)",
//            "android.os.BinderProxy.transact(BinderProxy.java:547)",
//            "android.content.pm.IPackageManager$Stub$Proxy.getApplicationInfo(IPackageManager.java:5212)",
//            ...
//          ]
//        },
//        #"threadTimeCost": 440,//卡顿所在线程消耗的时间
//        #"timeEnd": 1577522911368,// //卡顿结束时间
//        #"timeStart": 1577522910723//卡顿开始时间
//      }
    
}

/// RunLoop状态观察回调
static void runLoopObserverCallBack(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info)
{
    TALAPMANRPlugin *object = (__bridge TALAPMANRPlugin*)info;
    // 记录状态值
    object->runLoopActivity = activity;
    
    // 发送信号
    dispatch_semaphore_t semaphore = object->semaphore;
    dispatch_semaphore_signal(semaphore);
    
}
*/

@end
