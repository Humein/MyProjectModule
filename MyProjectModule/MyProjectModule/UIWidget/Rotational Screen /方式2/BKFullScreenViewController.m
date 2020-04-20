//
//  BKFullScreenViewController.m
//  benkelaile-iOS
//
//  Created by Zhang Xin Xin on 2019/4/24.
//  Copyright © 2019 sunlands. All rights reserved.
//

#import "BKFullScreenViewController.h"

@interface BKFullScreenViewController ()

@end

@implementation BKFullScreenViewController
{
    BOOL _statusBarHidden;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _statusBarHidden = NO;
    self.view.backgroundColor = [UIColor blackColor];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationLandscapeRight;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscapeRight;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation
{
    return UIStatusBarAnimationFade;
}

- (BOOL)prefersStatusBarHidden
{
    return _statusBarHidden;
}

- (void)setStatusBarHidden:(BOOL)hidden
{
    _statusBarHidden = hidden;
    [self setNeedsStatusBarAppearanceUpdate];
}


@end
