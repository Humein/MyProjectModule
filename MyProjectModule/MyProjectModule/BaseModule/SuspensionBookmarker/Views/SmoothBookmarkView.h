//
//  SmoothBookmarkView.h
//  benkelaile-iOS
//
//  Created by Zhang Xin Xin on 2019/4/19.
//  Copyright © 2019 sunlands. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookmarkMainTableView.h"
#import "BookmarkContainerView.h"

@class SmoothBookmarkView;

/**
 该协议主要用于mainTableView已经显示了header，listView的contentOffset需要重置时，内部需要访问到外部传入进来的listView内的scrollView
 */
@protocol BookmarkListViewDelegate <NSObject>

- (UIScrollView *)listScrollView;

@end

@protocol SmoothBookmarkViewDelegate <NSObject>


/**
 返回tableHeaderView的高度
 
 @param pagingView pagingView description
 @return return tableHeaderView的高度
 */
- (CGFloat)tableHeaderViewHeightInPagingView:(SmoothBookmarkView *)pagingView;


/**
 返回tableHeaderView
 
 @param pagingView pagingView description
 @return tableHeaderView
 */
- (UIView *)tableHeaderViewInPagingView:(SmoothBookmarkView *)pagingView;


/**
 返回悬浮HeaderView的高度。
 
 @param pagingView pagingView description
 @return 悬浮HeaderView的高度
 */
- (CGFloat)heightForPinSectionHeaderInPagingView:(SmoothBookmarkView *)pagingView;


/**
 返回悬浮HeaderView
 
 @param pagingView pagingView description
 @return 悬浮HeaderView
 */
- (UIView *)viewForPinSectionHeaderInPagingView:(SmoothBookmarkView *)pagingView;

/**
 底部listView的条数
 
 @param pagingView pagingView description
 @return 底部listView的条数
 */
- (NSInteger)numberOfListViewsInPagingView:(SmoothBookmarkView *)pagingView;


/**
 返回对应index的listView，需要是UIView的子类
 
 @param pagingView pagingView description
 @param row row index
 @return UIView
 */
- (UIView *)pagingView:(SmoothBookmarkView *)pagingView listViewInRow:(NSInteger)row;

/**
 collectionView滑动结束
 
 @param collectionView collectionView
 @param indexPath 当前展示的indexPath
 */
- (void)collectionViewDidScroll:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath;

@optional

/**
 mainTableView的滚动回调，用于实现头图跟随缩放
 
 @param scrollView mainTableView
 */
- (void)mainTableViewDidScroll:(UIScrollView *)scrollView;

@end

@interface SmoothBookmarkView : UIView

@property (nonatomic, weak) id<SmoothBookmarkViewDelegate> delegate;

@property (nonatomic, strong) BookmarkMainTableView *mainTableView;

@property (nonatomic, strong, readonly) BookmarkContainerView *listContainerView;

/**
 是否禁止mainTableView滑动
 */
@property (nonatomic, assign) BOOL isForbitMainTableViewScroll;

- (instancetype)initWithDelegate:(id<SmoothBookmarkViewDelegate>)delegate NS_DESIGNATED_INITIALIZER;

@property (nonatomic, strong, readonly) UIScrollView *currentScrollingListView;

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;

- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

- (void)initializeViews NS_REQUIRES_SUPER;

- (void)reloadData;

- (void)layoutSubviews;

/**
 外部传入的listView，当其内部的scrollView滚动时，需要调用该方法
 
 @param scrollView scrollView
 */
- (void)listViewDidScroll:(UIScrollView *)scrollView;

@end

