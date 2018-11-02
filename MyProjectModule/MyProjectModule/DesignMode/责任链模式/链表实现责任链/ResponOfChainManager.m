//
//  ResponOfChainManager.m
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/7/17.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import "ResponOfChainManager.h"

@implementation ResponOfChainManager

//绑定数据
- (void)attachPlayItem:(id )playItem{
    
    self.superior ? [self.superior attachPlayItem:playItem] : nil;
    
}

//响应事件

- (void)responseEvent:(NSInteger)eventType playItem:(id)playItem{
    
    
    NSLog(@"%@>>>>>>>%ld",[self class],(long)eventType);
    
    self.superior ? [self.superior responseEvent:eventType playItem:playItem] : nil;
    
}


//对哪些事件不做响应，可以不实现

- (BOOL)isEventTransferForEventType:(NSInteger)eventType
{
    return YES;
}


//发送事件
- (void)requestEvent:(HTPlayItemEventType)eventType playItem:(id )playItem
{

    ResponOfChainManager *nodeView= self;
    
//    while (nodeView) {
//        
//        if (nodeView.superior== nil) {
//            break;
//        }
//    }
    
    [nodeView responseEvent:eventType playItem:playItem];
}




@end
