//
//  BaseNavViewController.m
//  MyProjectModule
//
//  Created by XinXin on 2020/4/15.
//  Copyright © 2020 xinxin. All rights reserved.
//

#import "BaseNavViewController.h"
@interface BaseNavigationBar : UINavigationBar
@property (assign, nonatomic) CGFloat customHeight;
@end
@implementation BaseNavigationBar
- (CGSize)sizeThatFits:(CGSize)size {
    CGSize newSize;
    
    if (self.customHeight) {
        newSize = CGSizeMake(self.superview.bounds.size.width, self.customHeight);
    } else {
        newSize = [super sizeThatFits:size];
    }
    
    return newSize;
}
@end
@interface BaseNavViewController ()

@end

@implementation BaseNavViewController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    if (!rootViewController) {
        return nil;
    }
    self = [super initWithNavigationBarClass:[BaseNavigationBar class] toolbarClass:[UIToolbar class]];
    if (self) {
        self.viewControllers = @[rootViewController];
        rootViewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    }
    return self;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    viewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    [super pushViewController:viewController animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewControllers.firstObject.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    [(BaseNavigationBar *)self.navigationBar setCustomHeight:44];
}



#pragma mark- 横竖屏控制 状态栏和自动翻转

- (BOOL)prefersStatusBarHidden
{
    return [self.topViewController prefersStatusBarHidden];
}
//这个是方向的支持的处理
- (BOOL)shouldAutorotate
{
    return [self.topViewController shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return [self.topViewController supportedInterfaceOrientations];
}

//这个是做状态栏的处理
- (UIViewController *)childViewControllerForStatusBarStyle{
    return self.topViewController;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return [self.topViewController preferredStatusBarStyle];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
