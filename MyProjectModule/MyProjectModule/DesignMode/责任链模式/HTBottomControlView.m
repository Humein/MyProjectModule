//
//  HTBottomControlView.m
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/7/17.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import "HTBottomControlView.h"

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
@end
