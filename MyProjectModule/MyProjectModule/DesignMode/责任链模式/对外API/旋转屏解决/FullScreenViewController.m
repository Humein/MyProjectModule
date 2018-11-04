//
//  FullScreenViewController.m
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2018/11/4.
//  Copyright © 2018 xinxin. All rights reserved.
//

#import "FullScreenViewController.h"

@interface FullScreenViewController (){
    
    BOOL _statusBarHidden;

}

@end

@implementation FullScreenViewController

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
    return UIInterfaceOrientationMaskLandscape;
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
