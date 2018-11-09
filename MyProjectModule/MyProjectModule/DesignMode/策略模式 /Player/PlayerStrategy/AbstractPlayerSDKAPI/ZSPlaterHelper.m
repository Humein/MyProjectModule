//
//  ZSPlaterHelper.m
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/7/10.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import "ZSPlaterHelper.h"
#import "ZSPlayer.h"
@interface ZSPlaterHelper(){
    id<ZSPlayerProtovol> player;// ZS播放器自身的协议
}

@end
@implementation ZSPlaterHelper
- (instancetype)init
{
    self = [super init];
    if (self) {
        player = [[ZSPlayer alloc] init];
    }
    return self;
}
// 播放
- (NSString *)pl_play{
    return [player i_play];
}

// 暂停
- (NSString *)pl_pause{
    return [player i_pause];
}

// 停止
- (NSString *)pl_stop{
    return [player i_stop];
}

- (void)dealloc
{
    player = nil;
}
@end
