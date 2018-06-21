//
//  PersonCenterBaseViewController.m
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/6/21.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import "PersonalCenterChildViewController.h"

@interface PersonalCenterChildViewController ()
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation PersonalCenterChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pageTitleViewToTop) name:@"pageTitleViewToTop" object:nil];

}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)pageTitleViewToTop {
    _scrollView.contentOffset = CGPointZero;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = scrollView;
    }
    if (self.delegatePersonalCenterChildBaseVC && [self.delegatePersonalCenterChildBaseVC respondsToSelector:@selector(personalCenterChildBaseVCScrollViewDidScroll:)]) {
        [self.delegatePersonalCenterChildBaseVC personalCenterChildBaseVCScrollViewDidScroll:scrollView];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
