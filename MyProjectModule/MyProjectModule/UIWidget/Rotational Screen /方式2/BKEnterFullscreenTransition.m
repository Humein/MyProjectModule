//
//  BKEnterFullscreenTransition.m
//  benkelaile-iOS
//
//  Created by Zhang Xin Xin on 2019/4/24.
//  Copyright © 2019 sunlands. All rights reserved.
//

#import "BKEnterFullscreenTransition.h"
#import "InterfacePlayerView.h"
#import "Masonry.h"
@interface BKEnterFullscreenTransition()

@property (nonatomic, strong) InterfacePlayerView *videoView;

@end

@implementation BKEnterFullscreenTransition

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

/**
{
// 获取容器视图，转场发生的地方
UIView *containerView = [transitionContext containerView];

// 获取参与转场的视图控制器
UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

// 获取参与参与转场的视图View
UIView *fromView;
UIView *toView;
 if ([transitionContext respondsToSelector:@selector(viewForKey:)]) {
      //iOS8新增的方法
      fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
      toView = [transitionContext viewForKey:UITransitionContextToViewKey];
  }else{
      //iOS8之前的方法
      fromView = fromVC.view;
      toView = toVC.view;
  }
}
*/
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *presentedViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *presentedView = [transitionContext viewForKey:UITransitionContextToViewKey];;
    
    CGRect smallMovieFrame = [[transitionContext containerView] convertRect:self.videoView.bounds fromView:self.videoView];
    
    /*
     * 先将presentedView变成小屏的大小
     */
    presentedView.bounds = self.videoView.bounds;
    presentedView.transform = CGAffineTransformMakeRotation(-M_PI_2);
    presentedView.center = CGPointMake(CGRectGetMidX(smallMovieFrame), CGRectGetMidY(smallMovieFrame));
    [[transitionContext containerView] addSubview:presentedView];
    
    /*
     * 将movieView放入presentedView中
     */
    [presentedView addSubview:self.videoView];
    
    [self.videoView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0.f);
    }];
    
    /*
     * presentedView在动画中变为finalFrame
     */
    CGRect presentedViewFinalFrame = [transitionContext finalFrameForViewController:presentedViewController];
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0.0 options:UIViewAnimationOptionLayoutSubviews
                     animations:^{
                         presentedView.transform = CGAffineTransformIdentity;
                         presentedView.frame = presentedViewFinalFrame;
                         [self.videoView mas_remakeConstraints:^(MASConstraintMaker *make) {
                             make.edges.mas_equalTo(0.f);
                         }];
                     }
                     completion:^(BOOL finished) {
                         [transitionContext completeTransition:YES];
                     }];
}
@end
