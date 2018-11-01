//
//  HTTopControlView.m
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/7/17.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import "HTTopControlView.h"
#import "UIResponder+UIResponderChain.h"

@implementation HTTopControlView
- (void)responseEvent:(NSInteger)eventType playItem:(id)playItem{
    if (eventType == 0) {
        NSLog(@"%@>>>>>>>%ld",[self class],(long)eventType);
    }else if (eventType == 100){
        NSLog(@"联动事件");
    }
    else{
        NSLog(@"无法响应");
    }
}

#pragma mark - Event Handle
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self routerEventWithName:NSStringFromClass([self class]) userInfo:@{@"key": @"1"}];
    
}

- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo{
    
    NSLog(@"eventName ===== %@,userInfo =====%@",eventName,userInfo);
    
    // 把响应链继续传递下去
    [super routerEventWithName:eventName userInfo:userInfo];
    
    
}



@end
