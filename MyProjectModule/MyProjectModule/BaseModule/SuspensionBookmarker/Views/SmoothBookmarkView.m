//
//  SmoothBookmarkView.m
//  benkelaile-iOS
//
//  Created by Zhang Xin Xin on 2019/4/19.
//  Copyright © 2019 sunlands. All rights reserved.
//

#import "SmoothBookmarkView.h"

@interface SmoothBookmarkView () <UITableViewDataSource, UITableViewDelegate, BookmarkContainerViewDelegate>

//@property (nonatomic, strong) BookmarkMainTableView *mainTableView;
@property (nonatomic, strong) BookmarkContainerView *listContainerView;
@property (nonatomic, strong) UIScrollView *currentScrollingListView;
@property (nonatomic, assign) CGFloat lastScrollingListViewContentOffsetY;


@end

@implementation SmoothBookmarkView

- (instancetype)initWithDelegate:(id<SmoothBookmarkViewDelegate>)delegate {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        _delegate = delegate;
        [self initializeViews];
    }
    return self;
}

- (void)initializeViews {
    _mainTableView = [[BookmarkMainTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.mainTableView.backgroundColor = [UIColor whiteColor];
    self.mainTableView.showsVerticalScrollIndicator = NO;
    self.mainTableView.showsHorizontalScrollIndicator = NO;
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mainTableView.dataSource = self;
    self.mainTableView.delegate = self;
    self.mainTableView.bounces = NO;
    self.mainTableView.tableHeaderView = [self.delegate tableHeaderViewInPagingView:self];
    [self.mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    if (@available(iOS 11.0, *)) {
        self.mainTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [self addSubview:self.mainTableView];
    
    _listContainerView = [[BookmarkContainerView alloc] initWithDelegate:self];
    self.listContainerView.mainTableView = self.mainTableView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.mainTableView.frame = self.bounds;
}

- (void)reloadData {
    [self.mainTableView reloadData];
    [self.listContainerView reloadData];
}

- (void)listViewDidScroll:(UIScrollView *)scrollView {
    self.currentScrollingListView = scrollView;
    
    [self preferredProcessListViewDidScroll:scrollView];
}

- (void)preferredProcessListViewDidScroll:(UIScrollView *)scrollView {
    if (self.currentScrollingListView.contentOffset.y == 0) {
        return;
    }
    
    if (self.isForbitMainTableViewScroll) {
        self.mainTableView.contentOffset = CGPointZero;
        self.mainTableView.scrollEnabled = NO;
        scrollView.showsVerticalScrollIndicator = YES;
        return;
    }
    
    BOOL shouldProcess = YES;
    if (self.currentScrollingListView.contentOffset.y > self.lastScrollingListViewContentOffsetY) {
        //往上滚动
    }else {
        //往下滚动
        if (self.mainTableView.contentOffset.y == 0) {
            shouldProcess = YES;
        }else {
            if (self.mainTableView.contentOffset.y < [self.delegate tableHeaderViewHeightInPagingView:self]) {
                //mainTableView的header还没有消失，让listScrollView一直为0
                self.currentScrollingListView.contentOffset = CGPointZero;
                self.currentScrollingListView.showsVerticalScrollIndicator = NO;
            }
        }
    }
    if (shouldProcess) {
        //        if (self.mainTableView.contentOffset.y < [self.delegate tableHeaderViewHeightInPagingView:self])
        if (NO){
            //处于下拉刷新的状态，scrollView.contentOffset.y为负数，就重置为0
            if (self.currentScrollingListView.contentOffset.y > 0) {
                //mainTableView的header还没有消失，让listScrollView一直为0
                self.currentScrollingListView.contentOffset = CGPointZero;
                self.currentScrollingListView.showsVerticalScrollIndicator = NO;
            }
        } else {
            //mainTableView的header刚好消失，固定mainTableView的位置，显示listScrollView的滚动条
            //            self.mainTableView.contentOffset = CGPointMake(0, [self.delegate tableHeaderViewHeightInPagingView:self]);
            self.mainTableView.contentOffset = CGPointMake(0, 0);
            self.currentScrollingListView.showsVerticalScrollIndicator = YES;
        }
    }
    self.lastScrollingListViewContentOffsetY = self.currentScrollingListView.contentOffset.y;
}

- (void)preferredProcessMainTableViewDidScroll:(UIScrollView *)scrollView {
    if (self.isForbitMainTableViewScroll) {
        self.mainTableView.contentOffset = CGPointZero;
        self.mainTableView.scrollEnabled = NO;
        scrollView.showsVerticalScrollIndicator = YES;
        return;
    }
    if (self.currentScrollingListView != nil && self.currentScrollingListView.contentOffset.y > 0) {
        //mainTableView的header已经滚动不见，开始滚动某一个listView，那么固定mainTableView的contentOffset，让其不动
        self.mainTableView.contentOffset = CGPointMake(0, [self.delegate tableHeaderViewHeightInPagingView:self]);
    }
    
    if (scrollView.contentOffset.y < [self.delegate tableHeaderViewHeightInPagingView:self]) {
        //mainTableView已经显示了header，listView的contentOffset需要重置
        for (int i = 0; i < [self.delegate numberOfListViewsInPagingView:self]; i ++) {
            UIView *view = [self.delegate pagingView:self listViewInRow:i];
            if (view.subviews.count > 0 && [view.subviews[0] isKindOfClass:[UIScrollView class]]) {
                UIScrollView *listScrollView = view.subviews[0];
                //正在下拉刷新时，不需要重置
                if (listScrollView.contentOffset.y > 0) {
                    listScrollView.contentOffset = CGPointZero;
                }
            }
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.bounds.size.height - [self.delegate heightForPinSectionHeaderInPagingView:self];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    self.listContainerView.frame = cell.contentView.bounds;
    [cell.contentView addSubview:self.listContainerView];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [self.delegate heightForPinSectionHeaderInPagingView:self];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [self.delegate viewForPinSectionHeaderInPagingView:self];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([self.delegate respondsToSelector:@selector(mainTableViewDidScroll:)]) {
        [self.delegate mainTableViewDidScroll:scrollView];
    }
    
    [self preferredProcessMainTableViewDidScroll:scrollView];
}

// MARK: - BookmarkContainerViewDelegate
- (NSInteger)numberOfRowsInListContainerView:(BookmarkContainerView *)listContainerView {
    return [self.delegate numberOfListViewsInPagingView:self];
}

- (UIView *)listContainerView:(BookmarkContainerView *)listContainerView listViewInRow:(NSInteger)row {
    return [self.delegate pagingView:self listViewInRow:row];
}

- (void)collectionViewDidScroll:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath {
    [self.delegate collectionViewDidScroll:collectionView indexPath:indexPath];
}

@end
