//
//  AbstractPlayerProtocol.h
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/7/10.
//  Copyright © 2018年 xinxin. All rights reserved.
//

@protocol AbstractPlayerProtocol<NSObject>
/**
 *  Player开启视频
 *
 */
- (NSString *)pl_play;

/**
 *  Player暂停视频
 *
 */
- (NSString *)pl_pause;

/**
 *  Player停止播放
 *
 */
- (NSString *)pl_stop;

@end


