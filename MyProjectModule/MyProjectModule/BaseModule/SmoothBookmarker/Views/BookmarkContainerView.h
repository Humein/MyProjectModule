//
//  BookmarkContainerView.h
//  benkelaile-iOS
//
//  Created by Zhang Xin Xin on 2019/4/19.
//  Copyright © 2019 sunlands. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BookmarkMainTableView;
@class BookmarkContainerView;

@protocol BookmarkContainerViewDelegate <NSObject>

- (NSInteger)numberOfRowsInListContainerView:(BookmarkContainerView *)listContainerView;

- (UIView *)listContainerView:(BookmarkContainerView *)listContainerView listViewInRow:(NSInteger)row;

- (void)collectionViewDidScroll:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath;

@end

@interface BookmarkContainerView : UIView

@property (nonatomic, strong, readonly) UICollectionView *collectionView;
@property (nonatomic, weak) id<BookmarkContainerViewDelegate> delegate;
@property (nonatomic, weak) BookmarkMainTableView *mainTableView;

/**
 是否禁止mainTableView滑动
 */
@property (nonatomic, assign) BOOL isForbitMainTableViewScroll;

// 当前展示indexPath
@property (nonatomic, strong) NSIndexPath *currentIndexPath;

- (instancetype)initWithDelegate:(id<BookmarkContainerViewDelegate>)delegate NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;

- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

- (void)reloadData;

@end

