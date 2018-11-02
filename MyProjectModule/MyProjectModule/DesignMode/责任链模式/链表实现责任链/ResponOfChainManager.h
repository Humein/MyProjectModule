//
//  ResponOfChainManager.h
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/7/17.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ActionProtocol.h"



@interface ResponOfChainManager : UIView <ActionProtocol>

@property (nonatomic, strong) id<ActionProtocol> superior;

//发送事件
- (void)requestEvent:(HTPlayItemEventType)eventType playItem:(id )playItem;
@end
