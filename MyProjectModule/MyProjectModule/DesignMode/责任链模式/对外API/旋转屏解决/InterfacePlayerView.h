//
//  InterfacePlayerView.h
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2018/11/4.
//  Copyright © 2018 xinxin. All rights reserved.
//

#import "ResponOfChainManager.h"

@interface InterfacePlayerView : ResponOfChainManager
@property (nonatomic, strong) AbstractPlayerHelperManager *videoPlayer;
@property (nonatomic, strong) ResponderAbstractView *controlView;

@end
