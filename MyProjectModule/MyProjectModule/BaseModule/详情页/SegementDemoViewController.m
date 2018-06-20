//
//  SegementDemoViewController.m
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/6/20.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import "SegementDemoViewController.h"
#import "SegementHeader.h"
@interface SegementDemoViewController () <SGPageTitleViewDelegate,SegmentContentViewDelegate >
@property (nonatomic, strong) SegementTitleView *pageTitleView;
@property (nonatomic, strong) SegmentContentView *pageContentCollectionView;
@end

@implementation SegementDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupPageView];
}

- (void)setupPageView {
    CGFloat statusHeight = CGRectGetHeight([UIApplication sharedApplication].statusBarFrame);
    CGFloat pageTitleViewY = 0;
    if (statusHeight == 20.0) {
        pageTitleViewY = 64;
    } else {
        pageTitleViewY = 88;
    }
    
    NSArray *titleArr = @[@"精选", @"电影", @"电视剧", @"综艺", @"NBA", @"娱乐", @"动漫", @"演唱会", @"VIP会员"];
    SegementTitleConfigured *configure = [SegementTitleConfigured pageTitleViewConfigure];
    configure.showIndicator = NO;
    configure.titleTextZoom = YES;
    configure.titleTextScaling = 0.3;
    configure.spacingBetweenButtons = 30;
    
// title
    self.pageTitleView = [SegementTitleView pageTitleViewWithFrame:CGRectMake(0, pageTitleViewY, self.view.frame.size.width, 44) delegate:self titleNames:titleArr configure:configure];
    [self.view addSubview:_pageTitleView];

// content
    UIViewController *VC = [UIViewController new];
    NSArray *childArr = @[VC, VC, VC, VC, VC, VC, VC, VC, VC];
    
    CGFloat ContentCollectionViewHeight = self.view.frame.size.height - CGRectGetMaxY(_pageTitleView.frame);
    self.pageContentCollectionView = [[SegmentContentView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_pageTitleView.frame), self.view.frame.size.width, ContentCollectionViewHeight) parentVC:self childVCs:childArr];
    _pageContentCollectionView.delegateSegmentContent = self;
    [self.view addSubview:_pageContentCollectionView];

}

#pragma makr ---SegementDelegate
- (void)pageTitleView:(SegementTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex {
    [self.pageContentCollectionView setPageContentCollectionViewCurrentIndex:selectedIndex];

}

- (void)segmentContentView:(SegmentContentView *)segmentContentCollectionView offset:(CGFloat)offset originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex{
    [self.pageTitleView setPageTitleViewWithProgress:offset originalIndex:originalIndex targetIndex:targetIndex];

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
