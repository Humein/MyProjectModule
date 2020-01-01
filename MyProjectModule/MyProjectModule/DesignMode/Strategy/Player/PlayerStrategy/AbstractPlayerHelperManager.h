//
//  AbstractPlayerHelperManager.h
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/7/10.
//  Copyright © 2018年 xinxin. All rights reserved.
//


#import "ResponOfChainManager.h"
#import "AbstractPlayerProtocol.h"
// 播放器的类型
typedef enum : NSUInteger {
    EPlayerType_ZSPlayer,
    EPlayerType_BJPlayer
} EPlayerType;


@interface AbstractPlayerHelperManager : ResponOfChainManager

@property (nonatomic,strong)ResponOfChainManager <AbstractPlayerProtocol> *player;


//这里的切换，只让切换播放器即可

- (void)exchangeItem:(EPlayerType )playItem;


///**
// *  Player开启视频
// *
// */
//- (NSString *)abs_play;
//
///**
// *  Player暂停视频
// *
// */
//- (NSString *)abs_pause;
//
///**
// *  Player停止播放
// *
// */
//- (NSString *)abs_stop;

@end
