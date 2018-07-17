//
//  HTTopControlView.m
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/7/17.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import "HTTopControlView.h"

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
@end
