//
//  ResponderAbstractView.h
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2018/11/1.
//  Copyright © 2018 xinxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResponOfChainManager.h"

/*
 都继承 ResponOfChainManager
 HTPlayerView { HTVideoPlayerView + HTPlayerControlView}
 HTVideoPlayerView { HTVideoPlayer < 播放API > }
 HTPlayerControlView(ResponderAbstractView) {各个控制层（Top mid Bot）}
 */

@interface ResponderAbstractView : ResponOfChainManager

@end
