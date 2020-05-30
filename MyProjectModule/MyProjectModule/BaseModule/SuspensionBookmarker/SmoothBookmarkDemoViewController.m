//
//  SmoothBookmarkDemoViewController.m
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2019/11/14.
//  Copyright © 2019 xinxin. All rights reserved.
//

#import "SmoothBookmarkDemoViewController.h"
#import "BaseBookmarkChildDemoController.h"
@interface SmoothBookmarkDemoViewController ()<BookmarkChildListViewDelegate>
// 控制器数组
@property (nonatomic, copy) NSArray<BaseBookmarkChildController *> *contentVcArray;

@property (nonatomic, strong) SmoothBookmarkView *pagingView;

@end

@implementation SmoothBookmarkDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupChildVc];
    
    [self setupPagingView];


}

// 父类调用，设置子控制器
- (void)setupChildVc {
    
    BaseBookmarkChildDemoController *catalogVC = [BaseBookmarkChildDemoController new];
    catalogVC.delegate = self;
    
    BaseBookmarkChildDemoController *handoutsVC = [BaseBookmarkChildDemoController new];
    handoutsVC.delegate = self;
    
    BaseBookmarkChildDemoController *moreVC = [BaseBookmarkChildDemoController new];
    moreVC.delegate = self;
    
    self.contentVcArray = @[catalogVC, handoutsVC, moreVC];
    self.listViewArray = [NSMutableArray array];
    
    [self.contentVcArray enumerateObjectsUsingBlock:^(AbstractViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self addChildViewController:obj];
        [self.listViewArray addObject:obj.view];
    }];

}

-(void)setupPagingView{
    
    self.pagingView = [[SmoothBookmarkView alloc] initWithDelegate:self];
    
    self.pagingView.isForbitMainTableViewScroll = YES;
    
    [self.view addSubview:self.pagingView];
    
    [self.bookmarkView setUpViewInBookmarkView];
    
    NSArray * nameArray = @[@"聊天",@"章节",@"随堂考"];
    
    for (NSInteger i = 0; i < nameArray.count; i++) {
        CheckConditionItem * tagItem = [CheckConditionItem new];
        tagItem.name = nameArray[i];
        tagItem.itemWidth = [tagItem itemWidth] + 7;
        tagItem.itemHeight = [tagItem itemHeight];
        [self.itemsArray addObject:tagItem];
    }
    
    [self setBookmarkRightButton];
    
    [self.bookmarkView reloadData];
}

-(void)setupPlayer{

//
//    [self.headerView addSubview:self.videoView];
//
//    [self.videoView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.headerView).offset(kTopSafeHeight);
//        make.left.right.bottom.equalTo(self.headerView);
//    }];
//    
//
//    [self.headerView setSize:CGSizeMake(SCREEN_WIDTH , TableHeaderPPTViewHeight+kTopSafeHeight)];

}



// 设置Bookmark右边按钮
- (void)setBookmarkRightButton {
//    [self.bookmarkView setbuttonItems:self.downloadBtn, nil];
//
//    [self.bookmarkView reloadData];
//
//    Weak_Self
//    self.bookmarkView.rightClickBlock = ^(UIButton *btn, NSInteger index, BOOL isSelect) {
//        [weakSelf pushToDownloadWithSCrollIndex:weakSelf.bookmarkView.currentIndex];
//
//    };
}


// MARK: - SmoothBookmarkViewDelegate
- (void)mainTableViewDidScroll:(UIScrollView *)scrollView {
;
}

- (CGFloat)tableHeaderViewHeightInPagingView:(SmoothBookmarkView *)pagingView {

    return 0;
}

// MARK: - BookmarkChildListViewDelegate
- (void)listViewDidScroll:(UIScrollView *)scrollView {
    [self.pagingView listViewDidScroll:scrollView];
}

- (BOOL)prefersStatusBarHidden {

    return NO;
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
