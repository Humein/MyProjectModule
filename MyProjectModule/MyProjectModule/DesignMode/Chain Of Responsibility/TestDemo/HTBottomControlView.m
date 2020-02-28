//
//  HTBottomControlView.m
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/7/17.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import "HTBottomControlView.h"
#import "UIResponder+UIResponderChain.h"

@interface HTBottomControlView()
/// 事件策略字典 key:事件名 value:事件的invocation对象
@property (nonatomic, strong) NSDictionary *eventStrategy;
@end

@implementation HTBottomControlView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    //UIResponder
//    [self routerEventWithName:kEventOneName userInfo:@{@"key": @"bottom"}];return
    
    //LinkResponder
    [self attachPlayItem:@"3"];
    [self requestEvent:HTVideoPlayerBackEvent playItem:@"bottom"];
}

#pragma mark - LinkResponder
- (void)attachPlayItem:(id )playItem
{
//    [super attachPlayItem:playItem];
}

- (void)responseEvent:(NSInteger)eventType playItem:(id)playItem{
    
    self.nextNodeView ? [self.nextNodeView responseEvent:eventType playItem:playItem] : nil;
    NSLog(@"%@>>>>>>>相应的事件%ld>>>>>传递的数据%@",[self class],(long)eventType,playItem);

    
//    if (eventType == 2) {
//
//    }else if (eventType == 100){
//        self.superior ? [self.superior responseEvent:eventType playItem:nil] : nil;
//    }
//    else{
//        self.superior ? [self.superior responseEvent:eventType playItem:nil] : nil;
//    }
}


#pragma mark - UIResponderChain
- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo{
    
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
