//
//  AbstractPlayerHelperManager.m
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/7/10.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import "AbstractPlayerHelperManager.h"
#import "BJPlayerHelper.h"
#import "ZSPlaterHelper.h"
#import "AbstractPlayerProtocol.h"


@interface AbstractPlayerHelperManager(){
}

@end

@implementation AbstractPlayerHelperManager



// 初始化播放器
- (void)exchangeItem:(EPlayerType)type{
    switch (type) {
        case EPlayerType_ZSPlayer:
        {
            _player = [[ZSPlaterHelper alloc] init];
            break;
        }
        case EPlayerType_BJPlayer:
        {
            _player = [[BJPlayerHelper alloc] init];
            break;
        }
    }
}
//开启视频
- (NSString *)abs_play{
    return [_player pl_play];
}

//暂停视频
- (NSString *)abs_pause{
    return [_player pl_pause];
}

//停止播放
- (NSString *)abs_stop{
    return [_player pl_stop];
}
- (void)dealloc
{
    _player = nil;
}


@end
