//
//  SegementDemoViewController.m
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/6/20.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import "SegementDemoViewController.h"
#import "SegementHeader.h"
#import "SegementChildViewController.h"
@interface SegementDemoViewController () <SGPageTitleViewDelegate,SegmentContentViewDelegate >
@property (nonatomic, strong) SegementTitleView *pageTitleView;
@property (nonatomic, strong) SegmentContentView *pageContentCollectionView;

@property (nonatomic,strong)NSMutableDictionary *gl_items_dict;//控制器的数组

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
    

    SegementTitleConfigured *configure = [SegementTitleConfigured pageTitleViewConfigure];
    configure.showIndicator = YES;
    configure.indicatorStyle = SGIndicatorStyleFixed;
    configure.indicatorFixedWidth = 30;
    configure.titleTextScaling = 0.3;
    configure.spacingBetweenButtons = 30;
    

    NSArray *dicArray = [NSArray arrayWithObjects:@{@"categoryId":@"11"},@{@"categoryId":@"22"},@{@"categoryId":@"33"},@{@"categoryId":@"44"},@{@"categoryId":@"55"},@{@"categoryId":@"65"}, nil];
    
    NSMutableArray *childArray = [NSMutableArray array];
    NSMutableArray *titleArr = [NSMutableArray array];

    for (NSDictionary *dic in dicArray) {
        [titleArr addObject:[dic objectForKey:@"categoryId"]];
        NSInteger cID = [[dic objectForKey:@"categoryId"] integerValue];
        [childArray addObject:[self viewControlForCategoryId:cID]];
    }

    self.pageTitleView = [SegementTitleView pageTitleViewWithFrame:CGRectMake(0, pageTitleViewY, self.view.frame.size.width, 44) delegate:self titleNames:titleArr configure:configure];
    [self.view addSubview:_pageTitleView];
    
    
    
    CGFloat ContentCollectionViewHeight = self.view.frame.size.height - CGRectGetMaxY(_pageTitleView.frame);
    self.pageContentCollectionView = [[SegmentContentView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_pageTitleView.frame), self.view.frame.size.width, ContentCollectionViewHeight) parentVC:self childVCs:childArray];
    _pageContentCollectionView.delegateSegmentContent = self;
    [self.view addSubview:_pageContentCollectionView];

}


- (UIViewController*)viewControlForCategoryId:(NSInteger)categoryId
{
    NSString *key = [NSString stringWithFormat:@"%zi",categoryId];
    
    SegementChildViewController *vc= [self.gl_items_dict objectForKey:key];
    
    if (vc) {
        
    }else{
        vc = [[SegementChildViewController alloc] init];
        vc.categoryId = categoryId;
        [self.gl_items_dict setObject:vc forKey:key];
    }
    return vc;
}


#pragma makr ---SegementDelegate
- (void)pageTitleView:(SegementTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex {
    [self.pageContentCollectionView setPageContentCollectionViewCurrentIndex:selectedIndex];

}

- (void)segmentContentView:(SegmentContentView *)segmentContentCollectionView offset:(CGFloat)offset originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex{
    [self.pageTitleView setPageTitleViewWithProgress:offset originalIndex:originalIndex targetIndex:targetIndex];

}


#pragma mark --- get&set
- (NSMutableDictionary*)gl_items_dict
{
    if (_gl_items_dict == nil) {
        _gl_items_dict = [NSMutableDictionary new];
    }
    return _gl_items_dict;
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
