//
//  InterfacePlayerView.h
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2018/11/4.
//  Copyright © 2018 xinxin. All rights reserved.
//

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
