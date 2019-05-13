//
//  SmoothBookmarkViewController.m
//  benkelaile-iOS
//
//  Created by Zhang Xin Xin on 2019/4/19.
//  Copyright © 2019 sunlands. All rights reserved.
//

#import "SmoothBookmarkViewController.h"

#define SCREEN_WIDTH                     ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT                    ([UIScreen mainScreen].bounds.size.height)
#define Font(a) [UIFont systemFontOfSize:(a)]
#define HexColor(value,a)   [UIColor colorWithRed:((value & 0xFF0000) >> 16)/255.0 green:((value & 0x00FF00) >> 8)/255.0 blue:(value & 0x0000FF)/255.0 alpha:(a)]
#define TableHeaderViewHeight 200

static const CGFloat HeightForHeaderInSection = 55;

@interface SmoothBookmarkViewController ()

@property (nonatomic, strong) SmoothBookmarkView *pagingView;

@end

@implementation SmoothBookmarkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.translucent = false;
    
    [self setupChildVc];
    
    [self setupHeaderView];
    
    _pagingView = [[SmoothBookmarkView alloc] initWithDelegate:self];
    [self.view addSubview:self.pagingView];
    
    [self.bookmarkView setUpViewInBookmarkView];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.pagingView.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y , self.view.frame.size.width, self.view.frame.size.height);
}

- (void)setupChildVc {
    NSLog(@"子类实现");
}
- (void)setupHeaderView {
    NSLog(@"子类实现");
}

- (SmoothTitleView *)bookmarkView
{
    if (_bookmarkView == nil) {
        
        _bookmarkView = [[SmoothTitleView alloc] initWithFrame:self.view.bounds];
        
        [_bookmarkView registTagListCellClass:[CheckConditionCollectionViewCell class] forItemClass:[CheckConditionItem class]];
        
        _bookmarkView.dataSource = self;
        _bookmarkView.delegate = self;
    }
    return _bookmarkView;
}
- (NSMutableArray *)itemsArray
{
    if (_itemsArray == nil) {
        _itemsArray = [NSMutableArray new];
    }
    return _itemsArray;
}

#pragma mark - BookmarkChildListViewDelegate

- (void)listViewDidScroll:(UIScrollView *)scrollView {
    [self.pagingView listViewDidScroll:scrollView];
}

#pragma mark - SmoothBookmarkViewDelegate

- (UIView *)tableHeaderViewInPagingView:(SmoothBookmarkView *)pagingView {
    return self.headerView;
}

- (CGFloat)tableHeaderViewHeightInPagingView:(SmoothBookmarkView *)pagingView {
    return TableHeaderViewHeight;
}

- (CGFloat)heightForPinSectionHeaderInPagingView:(SmoothBookmarkView *)pagingView {
    return HeightForHeaderInSection;
}

- (UIView *)viewForPinSectionHeaderInPagingView:(SmoothBookmarkView *)pagingView {
    return self.bookmarkView;
}

- (NSInteger)numberOfListViewsInPagingView:(SmoothBookmarkView *)pagingView {
    return self.listViewArray.count;
}

- (UIView *)pagingView:(SmoothBookmarkView *)pagingView listViewInRow:(NSInteger)row {
    return self.listViewArray[row];
}

- (void)mainTableViewDidScroll:(UIScrollView *)scrollView {
    //    [self.userHeaderView scrollViewDidScroll:scrollView.contentOffset.y];
}

- (void)collectionViewDidScroll:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath {
    self.bookmarkView.currentTmpIndex = indexPath.row;
    [self.bookmarkView updateStyleWithCurrentIndexPath];
}

#pragma mark- bookmarkview的代理

//tagcell的size
- (CGSize)bookmarkViewSizeForTagCellIndexPath:(NSIndexPath*)indexPath bookmarkView:(SmoothTitleView*)bookmarkView
{
    if (indexPath.row>= self.itemsArray.count) {
        return CGSizeZero;
    }
    CheckConditionItem *item = [self.itemsArray objectAtIndex:indexPath.row];
    return CGSizeMake(item.titleWidth, item.titleHeight);
}


//contentCell的size
- (CGSize)bookmarkViewSizeForContentCellIndexPath:(NSIndexPath*)indexPath bookmarkView:(SmoothTitleView*)bookmarkView
{
    return CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT - HeightForHeaderInSection);
}


//tagcell的数据源
- (NSArray*)bookmarkViewTagListItems:(SmoothTitleView*)bookmarkView
{
    return self.itemsArray;
}


//contentcell的数据源
- (NSArray*)bookmarkViewContentListItems:(SmoothTitleView*)bookmarkView
{
    return self.childViewControllers;
}


//tag的cell和item之间的关联,bool表示是否是当前选中的
- (void)bookmarkViewTagListCellForItemIndexPath:(NSIndexPath *)indexPath cell:(UICollectionViewCell *)cell bookmarkView:(SmoothTitleView *)bookmarkView isCurrentIndexPath:(BOOL)isCurrent
{
    CheckConditionItem *item = [self.itemsArray objectAtIndex:indexPath.row];
    CheckConditionCollectionViewCell *tmpCell = (CheckConditionCollectionViewCell*)cell;
    if (isCurrent)
    {
        NSDictionary *attribtDic = @{
                                     NSFontAttributeName:Font(16),
                                     };
        NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:item.name attributes:attribtDic];
        tmpCell.nameLable.attributedText = attribtStr;
        tmpCell.select = YES;
    }
    else
    {
        NSDictionary *attribtDic = @{
                                     NSForegroundColorAttributeName:HexColor(0x4A4A4A, 1),
                                     NSFontAttributeName:Font(15),
                                     };
        NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:item.name attributes:attribtDic];
        tmpCell.nameLable.attributedText = attribtStr;
        tmpCell.select = NO;
    }
}

//重复点击同一个tagList中的cell
- (void)bookmarkViewSelectSameCellForTagCellIndexpath:(NSIndexPath*)indexPath bookmarkView:(SmoothTitleView*)bookmarkView
{
    NSLog(@"same");
}

//点击了taglist中的cell
- (void)bookmarkViewSelectCellForTagCellIndexPath:(NSIndexPath*)indexPath bookmarkView:(SmoothTitleView*)bookmarkView
{
    [self.pagingView.listContainerView.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}

@end
