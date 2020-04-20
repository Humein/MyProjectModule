//
//  BKExitFullscreenTransition.m
//  benkelaile-iOS
//
//  Created by Zhang Xin Xin on 2019/4/24.
//  Copyright © 2019 sunlands. All rights reserved.
//

#import "BKExitFullscreenTransition.h"
#import "InterfacePlayerView.h"
@interface BKExitFullscreenTransition ()

@property (nonatomic, strong) InterfacePlayerView *videoView;

@end
@implementation BKExitFullscreenTransition

- (instancetype)initWithMovieView:(InterfacePlayerView *)videoView
{
    self = [super init];
    if (self)
    {
        _videoView = videoView;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.1;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIView *dismissingView = nil;
    
    dismissingView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    
    CGRect smallMovieFrame = [[transitionContext containerView] convertRect:self.videoView.videoViewFrame fromView:self.videoView.videoViewParentView];
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0.0
                        options:UIViewAnimationOptionLayoutSubviews
                     animations:^{
                         dismissingView.transform = CGAffineTransformIdentity;
                         dismissingView.frame = smallMovieFrame;
                         self.videoView.frame = dismissingView.bounds;
                     }
                     completion:^(BOOL finished) {
                         [self.videoView.videoViewParentView addSubview:self.videoView];
                         // 记得回去恢复布局 Masonry
                         [dismissingView removeFromSuperview];
                         [transitionContext completeTransition:YES];
                     }];
}

@end
