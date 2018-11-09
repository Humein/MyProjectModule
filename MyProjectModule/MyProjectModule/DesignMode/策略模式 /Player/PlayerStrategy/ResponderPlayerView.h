//
//  ResponderPlayerView.h
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2018/11/9.
//  Copyright © 2018 xinxin. All rights reserved.
//

#import "ResponOfChainManager.h"


/*
  所有的事件，集中在这里 在AbstractPlayerProtocol中，
  播放器抛出的事件，在HTVideoPlayerViewProtocol中
  每个播放器里面要有统一的动作标准
*/
@interface ResponderPlayerView : ResponOfChainManager

@end
