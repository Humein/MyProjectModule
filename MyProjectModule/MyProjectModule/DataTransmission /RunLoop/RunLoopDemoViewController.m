
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

@end
