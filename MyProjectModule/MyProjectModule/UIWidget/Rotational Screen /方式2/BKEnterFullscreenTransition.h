//
//  BKEnterFullscreenTransition.h
//  benkelaile-iOS
//
//  Created by Zhang Xin Xin on 2019/4/24.
//  Copyright © 2019 sunlands. All rights reserved.
//

#import <UIKit/UIKit.h>
@class InterfacePlayerView;
NS_ASSUME_NONNULL_BEGIN

@interface BKEnterFullscreenTransition : NSObject<UIViewControllerAnimatedTransitioning>

- (instancetype)initWithMovieView:(InterfacePlayerView *)videoView;
@end

NS_ASSUME_NONNULL_END
