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

//(无返回值，有参数，非匿名)
typedef void (^HTPlayItemEventHandleBlock)(HTPlayItemEventType eventType,id playItem);


@interface ResponOfChainManager : UIView <ActionProtocol>

@property (nonatomic, strong) id<ActionProtocol> superior;

@property (nonatomic,weak)ResponOfChainManager *nextNodeView;

@property (nonatomic,weak)ResponOfChainManager *proNodeView;

@property (nonatomic,weak)ResponOfChainManager *headerNodeView;


//设置next节点，默认在最后一个位置插入，链式操作，比较方便 (有返回值，有参数，匿名)
- (ResponOfChainManager * (^)(ResponOfChainManager* nextView))nextView;

//打印所有节点
- (void)logAllNextNode;


//发送事件
- (void)requestEvent:(HTPlayItemEventType)eventType playItem:(id )playItem;



@end
