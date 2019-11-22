//
//  SegementContentView.h
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2019/11/21.
//  Copyright © 2019 xinxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AbstractCollectionViewCell.h"
@class SegementContentView;
typedef void (^TopViewRightButtonClickBlock)(UIButton *btn,NSInteger index,BOOL isSelect);


@interface BookmarkContentViewCell :AbstractCollectionViewCell

- (void)loadContentView:(UIView*)controllerView;

@end
// 数据源代理
@protocol BookMarkViewDataSource <NSObject>
@required

//tagcell的size
- (CGSize)bookmarkViewSizeForTagCellIndexPath:(NSIndexPath *)indexPath bookmarkView:(SegementContentView *)bookmarkView;

//contentCell的size
- (CGSize)bookmarkViewSizeForContentCellIndexPath:(NSIndexPath *)indexPath bookmarkView:(SegementContentView *)bookmarkView;

//tagcell的数据源
- (NSArray*)bookmarkViewTagListItems:(SegementContentView *)bookmarkView;

//contentcell的数据源
- (NSArray*)bookmarkViewContentListItems:(SegementContentView *)bookmarkView;

//tag的cell和item之间的关联,bool表示是否是当前选中的
- (void)bookmarkViewTagListCellForItemIndexPath:(NSIndexPath *)indexPath cell:(UICollectionViewCell*)cell bookmarkView:(SegementContentView *)bookmarkView isCurrentIndexPath:(BOOL)isCurrent;

//content的cell和item之间的关联，bool表示是否是当前的
- (void)bookmarkViewContentListCellForItemIndexPath:(NSIndexPath *)indexPath bookmarkView:(SegementContentView *)bookmarkView cell:(BookmarkContentViewCell *)cell;

@end

//事件代理
@protocol BookMarkViewDelegate<NSObject>
@optional

//重复点击同一个tagList中的cell
- (void)bookmarkViewSelectSameCellForTagCellIndexpath:(NSIndexPath *)indexPath bookmarkView:(SegementContentView *)bookmarkView;

//点击了taglist中的cell
- (void)bookmarkViewSelectCellForTagCellIndexPath:(NSIndexPath *)indexPath bookmarkView:(SegementContentView *)bookmarkView;

//到了某一个位置
- (void)bookmarkViewDisPlayCellForItemIndexPath:(NSIndexPath *)indexPath bookmarkView:(SegementContentView *)bookmarkView;

//即将到某个位置
- (void)bookmarkViewWillDisplayCellForItemIndexPath:(NSIndexPath *)indexPath bookmarkView:(SegementContentView *)bookmarkView;

@end

@interface SegementContentView : UIView
@property (nonatomic,strong)UIView *tagView;//上面的view
@property (nonatomic,strong) UIView *tagLineView;//上面的分割线
@property (nonatomic,strong)UICollectionView *tagListView; // segement Container
@property (nonatomic,copy)TopViewRightButtonClickBlock rightClickBlock;//上面view的按钮点击事件

@property (nonatomic,strong) UICollectionView *contentListView; // VC Container

@property (nonatomic,weak)id <BookMarkViewDelegate> delegate;
@property (nonatomic,weak)id <BookMarkViewDataSource> dataSource;


@end

