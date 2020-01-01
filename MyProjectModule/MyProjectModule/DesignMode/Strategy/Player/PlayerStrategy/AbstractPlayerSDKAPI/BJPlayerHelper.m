//
//  BJPlayerHelper.m
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/7/10.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import "BJPlayerHelper.h"
#import "BJPlayer.h"
@interface BJPlayerHelper(){
    id<BJPlayerProtocol> player; // BJ 播放协议
    
}
@end
@implementation BJPlayerHelper

-(instancetype)init{
    self = [super init];
    if (self) {
        player = [[BJPlayer alloc] init];
    }
    return self;
}
// 播放
- (NSString *)pl_play{
    return [player a_play];
}

// 暂停
- (NSString *)pl_pause{
    return [player a_pause];
}

// 停止
- (NSString *)pl_stop{
    return [player a_stop];
}

- (void)dealloc
{
    player = nil;
}
@end
