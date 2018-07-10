//
//  AbstractPlayerHelperManager.h
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/7/10.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import <Foundation/Foundation.h>
// 播放器的类型
typedef enum : NSUInteger {
    EPlayerType_ZSPlayer,
    EPlayerType_BJPlayer
} EPlayerType;


@interface AbstractPlayerHelperManager : NSObject
- (instancetype)initWithType:(EPlayerType)type;

/**
 *  Player开启视频
 *
 */
- (NSString *)abs_play;

/**
 *  Player暂停视频
 *
 */
- (NSString *)abs_pause;

/**
 *  Player停止播放
 *
 */
- (NSString *)abs_stop;

@end
