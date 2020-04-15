//
//  MainTabBarViewController.m
//  MyProjectModule
//
//  Created by XinXin on 2020/4/15.
//  Copyright © 2020 xinxin. All rights reserved.
//

#import "MainTabBarViewController.h"
#import "ViewController.h"
#import "BaseNavViewController.h"

@interface MainTabBarViewController ()
@property (strong, nonatomic) ViewController *meViewController;
@end

@implementation MainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpViewControllers];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)setUpViewControllers {
    BaseNavViewController *meNavVC = [[BaseNavViewController alloc] initWithRootViewController:self.meViewController];
    meNavVC.tabBarItem.title = @"我的";
    meNavVC.tabBarItem.image = [UIImage imageNamed:@"tab-icon-me-normal"];
    meNavVC.tabBarItem.selectedImage = [UIImage imageNamed:@"tab-icon-me-selected"];
    self.viewControllers = @[meNavVC];
}

- (ViewController *)meViewController {
    if (!_meViewController) {
        _meViewController = [[ViewController alloc] init];
    }
    return _meViewController;
}


#pragma mark- 横竖屏控制 状态栏和自动翻转
// 状态栏是否显示
- (BOOL)prefersStatusBarHidden
{
    return [self.selectedViewController prefersStatusBarHidden];
}

//  是否允许旋转
- (BOOL)shouldAutorotate
{
    return [self.selectedViewController shouldAutorotate];
}
// 支持的方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return [self.selectedViewController supportedInterfaceOrientations];
}

// 这个是做状态栏的处理
- (UIViewController *)childViewControllerForStatusBarStyle
{
    return self.selectedViewController;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return [self.selectedViewController preferredStatusBarStyle];
}
@end
