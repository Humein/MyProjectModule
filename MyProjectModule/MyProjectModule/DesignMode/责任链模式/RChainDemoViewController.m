//
//  RChainDemoViewController.m
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/7/17.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import "RChainDemoViewController.h"
#import "UIResponder+UIResponderChain.h"
#import "ResponderAbstractView.h"

@interface RChainDemoViewController ()
/// 事件策略字典 key:事件名 value:事件的invocation对象
@property (nonatomic, strong) NSDictionary *eventStrategy;
@end

@implementation RChainDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

// 责任链模式，最典型的就是响应链
    
    [self initALLView];
    

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//  方式1
#warning ---TODO 通 链表的方式 将各个控制层 绑定起来
    
//    HTTopControlView *top = [[HTTopControlView alloc] init];
//    HTMiddleControlView *mid = [[HTMiddleControlView alloc] init];
//    HTBottomControlView *bot = [[HTBottomControlView alloc] init];
//
//    bot.superior = mid;
//    mid.superior = top;
//
////    NSArray *responseEvent = @[@"0",@"1",@"3"];
////    for (NSString *string in responseEvent) {
////        [bot responseEvent:[string integerValue] playItem:nil];
////    }
////   模拟点击
//     [mid responseEvent:1 playItem:nil];

    
    
    
//    2
    [self routerEventWithName:NSStringFromClass([self class]) userInfo:@{@"key": @"Super"}];

}





#pragma mark ------------ 2222

//    方式 2 UIResponder 链接 只能从底到上的 父子关系（不能建立平级关系 ）
-(void)initALLView{
    
 
    ResponderAbstractView  *RAView = [[ResponderAbstractView alloc]initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, 400)];
    RAView.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:RAView];
    
    
}


- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo{
    
    NSLog(@"eventName ===== %@,userInfo =====%@",eventName,userInfo);

    [self handleEventWithName:eventName parameter:userInfo];

    // 把响应链继续传递下去
    [super routerEventWithName:eventName userInfo:userInfo];
    
    
}

- (void)handleEventWithName:(NSString *)eventName parameter:(NSDictionary *)parameter {
    // 获取invocation对象
    NSInvocation *invocation = self.strategyDictionary[eventName];
    // 设置invocation参数
    [invocation setArgument:&parameter atIndex:2];
    // 调用方法
    [invocation invoke];
}



// 用 invocation 封装方法 策略 集中处理当前点击视图响应链上的所有事件

- (NSDictionary <NSString *, NSInvocation *>*)strategyDictionary {
    if (!_eventStrategy) {
        _eventStrategy = @{
                           kEventOneName:[self createInvocationWithSelector:@selector(cellOneEventWithParamter:)],
                           kEventTwoName:[self createInvocationWithSelector:@selector(cellTwoEventWithParamter:)]
                           };
    }
    return _eventStrategy;
}



- (void)cellOneEventWithParamter:(NSDictionary *)paramter {
    NSLog(@"---------参数：%@",paramter);

}

- (void)cellTwoEventWithParamter:(NSDictionary *)paramter {
    NSLog(@"---------参数：%@",paramter);
  
}

@end
