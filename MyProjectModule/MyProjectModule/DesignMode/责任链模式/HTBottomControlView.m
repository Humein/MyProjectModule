//
//  HTBottomControlView.m
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/7/17.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import "HTBottomControlView.h"
#import "UIResponder+UIResponderChain.h"

extern NSString *kEventOneName;

@implementation HTBottomControlView
- (void)responseEvent:(NSInteger)eventType playItem:(id)playItem{
    if (eventType == 2) {
        NSLog(@"%@>>>>>>>%ld",[self class],(long)eventType);
    }else if (eventType == 100){
        NSLog(@"%@>>>>>>>%ld",[self class],(long)eventType);
        self.superior ? [self.superior responseEvent:eventType playItem:nil] : nil;

    }
    else{
        self.superior ? [self.superior responseEvent:eventType playItem:nil] : nil;
    }
}


#pragma mark - Event Handle
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self routerEventWithName:kEventOneName userInfo:@{@"key": @"3"}];
    
}

- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo{
    
    NSLog(@"eventName ===== %@,userInfo =====%@",eventName,userInfo);

    // 把响应链继续传递下去
    [super routerEventWithName:eventName userInfo:userInfo];
    
    
}


@end
