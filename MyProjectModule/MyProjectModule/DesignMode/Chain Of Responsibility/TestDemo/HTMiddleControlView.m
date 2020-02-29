//
//  HTMiddleControlView.m
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/7/17.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import "HTMiddleControlView.h"
#import "UIResponder+UIResponderChain.h"

@interface HTMiddleControlView()
/// 事件策略字典 key:事件名 value:事件的invocation对象
@property (nonatomic, strong) NSDictionary *eventStrategy;
@end

@implementation HTMiddleControlView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //UIResponder
//    [self routerEventWithName:kEventOneName userInfo:@{@"key": @"middle"}];return;

    //LinkResponder
    [self attachPlayItem:@"2"];
    [self requestEvent:HTVideoPlayEvent playItem:@"middle"];
}

#pragma mark - LinkResponder
- (void)attachPlayItem:(id )playItem
{
//    [super attachPlayItem:playItem];
}

- (void)responseEvent:(NSInteger)eventType playItem:(id)playItem{
    
    self.nextNodeView ? [self.nextNodeView responseEvent:eventType playItem:playItem] : nil;
    NSLog(@"%@>>>>>>>相应的事件%ld>>>>>传递的数据%@",[self class],(long)eventType,playItem);

//    if (eventType == 1) {
//        NSLog(@"%@>>>>>>>%ld",[self class],(long)eventType);
//    }else if (eventType == 100){
//        NSLog(@"%@>>>>>>>%ld",[self class],(long)eventType);
//        self.superior ? [self.superior responseEvent:eventType playItem:nil] : nil;
//    }
//    else{
//        self.superior ? [self.superior responseEvent:eventType playItem:nil] : nil;
//    }

}

#pragma mark - UIResponderChain
- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo{
    
    ///    Decorator模式  结合Decorator(装饰者)模式
//    NSLog(@"eventName ===== %@,userInfo =====%@",eventName,userInfo);
//    NSMutableDictionary *decoratedUserInfo = [[NSMutableDictionary alloc] initWithDictionary:userInfo];
//    decoratedUserInfo[@"key"] = [UIColor redColor]; // 添加数据
//    [decoratedUserInfo removeObjectForKey:@"key"];
//    NSLog(@"eventName ===== %@,userInfo =====%@",eventName,decoratedUserInfo);
    
    [self handleEventWithName:eventName parameter:userInfo];
    // 把响应链继续传递下去
    [super routerEventWithName:eventName userInfo:userInfo];
    
}


// 用 invocation 封装方法 策略 集中处理当前点击视图响应链上的所有事件
- (void)handleEventWithName:(NSString *)eventName parameter:(NSDictionary *)parameter {
    // 获取invocation对象
    NSInvocation *invocation = self.strategyDictionary[eventName];
    // 设置invocation参数
    [invocation setArgument:&parameter atIndex:2];
    // 调用方法
    [invocation invoke];
}

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
    
//    NSLog(@"---------参数：%@",paramter);

}

- (void)cellTwoEventWithParamter:(NSDictionary *)paramter {
    NSLog(@"---------参数：%@",paramter);
}

@end
