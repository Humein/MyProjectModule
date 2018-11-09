//
//  InterfacePlayerView.h
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2018/11/4.
//  Copyright © 2018 xinxin. All rights reserved.
//

/*
 
 一下都继承 ResponOfChainManager
 
 HTPlayerView(InterfacePlayerView) { ResponderPlayerView + ResponderControlView}
 ResponderPlayerView { AbstractPlayerHelperManager < 播放API > }
 ResponderControlView(ResponderControlView) {各个控制层（Top mid Bot）}
 
 */




#import "ResponOfChainManager.h"

@interface InterfacePlayerView : ResponOfChainManager


#pragma mark ---- 具体业务

//界面出现
- (void)viewWillAppear;

//界面消失
- (void)viewWilDisappear;

//做播放的切换

- (void)exchangePlayItem:(id )playItem;
@end
