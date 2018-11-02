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
#pragma mark --- linkedChain

- (void)attachPlayItem:(id )playItem
{
    [super attachPlayItem:playItem];
    
    
    
}


- (void)responseEvent:(NSInteger)eventType playItem:(id)playItem{
    
    //  self.superior ? [self.superior responseEvent:eventType playItem:playItem] : nil; 类似UIResponder 链条
    
    self.nextNodeView ? [self.nextNodeView responseEvent:eventType playItem:playItem] : nil;
    
    NSLog(@"%@>>>>>>>%ld",[self class],(long)eventType);

    return;
    
    if (eventType == 1) {
        NSLog(@"%@>>>>>>>%ld",[self class],(long)eventType);
    }else if (eventType == 100){
        NSLog(@"%@>>>>>>>%ld",[self class],(long)eventType);
        self.superior ? [self.superior responseEvent:eventType playItem:nil] : nil;

    }
    else{
        self.superior ? [self.superior responseEvent:eventType playItem:nil] : nil;
    }

}



#pragma mark --- Action

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
//    [self routerEventWithName:kEventOneName userInfo:@{@"key": [UIColor brownColor]}];
    
    [self requestEvent:HTVideoPlayEvent playItem:@""];
    
}
#pragma mark -Chain Event Handle


- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo{
    
    NSLog(@"eventName ===== %@,userInfo =====%@",eventName,userInfo);
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
    
    self.backgroundColor = [UIColor brownColor];

}

- (void)cellTwoEventWithParamter:(NSDictionary *)paramter {
    NSLog(@"---------参数：%@",paramter);
    self.backgroundColor = [UIColor greenColor];

    
}

@end
