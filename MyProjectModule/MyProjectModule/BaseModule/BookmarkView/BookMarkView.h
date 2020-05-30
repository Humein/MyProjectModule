//
//  BookMarkView.h
//  benkelaile-iOS
//
//  Created by Zhang Xin Xin on 2019/4/19.
//  Copyright © 2019 sunlands. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AbstractCollectionViewCell.h"

@class BookMarkView;

@interface BookmarkContentViewCell :AbstractCollectionViewCell

- (void)loadContentView:(UIView*)controllerView;

@end


@protocol BookMarkViewDataSource <NSObject>

@required

//tagcell的size
- (CGSize)bookmarkViewSizeForTagCellIndexPath:(NSIndexPath*)indexPath bookmarkView:(BookMarkView*)bookmarkView;

//contentCell的size
- (CGSize)bookmarkViewSizeForContentCellIndexPath:(NSIndexPath*)indexPath bookmarkView:(BookMarkView*)bookmarkView;

//tagcell的数据源
- (NSArray*)bookmarkViewTagListItems:(BookMarkView*)bookmarkView;

//contentcell的数据源
- (NSArray*)bookmarkViewContentListItems:(BookMarkView*)bookmarkView;

//tag的cell和item之间的关联,bool表示是否是当前选中的
- (void)bookmarkViewTagListCellForItemIndexPath:(NSIndexPath*)indexPath cell:(UICollectionViewCell*)cell bookmarkView:(BookMarkView*)bookmarkView isCurrentIndexPath:(BOOL)isCurrent;

//content的cell和item之间的关联，bool表示是否是当前的
- (void)bookmarkViewContentListCellForItemIndexPath:(NSIndexPath*)indexPath bookmarkView:(BookMarkView*)bookmarkView cell:(BookmarkContentViewCell*)cell;

@end


@protocol BookMarkViewDelegate<NSObject>

@optional

//重复点击同一个tagList中的cell
- (void)bookmarkViewSelectSameCellForTagCellIndexpath:(NSIndexPath*)indexPath bookmarkView:(BookMarkView*)bookmarkView;

//点击了taglist中的cell
- (void)bookmarkViewSelectCellForTagCellIndexPath:(NSIndexPath*)indexPath bookmarkView:(BookMarkView*)bookmarkView;

//到了某一个位置
- (void)bookmarkViewDisPlayCellForItemIndexPath:(NSIndexPath*)indexPath bookmarkView:(BookMarkView*)bookmarkView;

//即将到某个位置
- (void)bookmarkViewWillDisplayCellForItemIndexPath:(NSIndexPath*)indexPath bookmarkView:(BookMarkView*)bookmarkView;

@end

typedef void (^TopViewRightButtonClickBlock)(UIButton *btn,NSInteger index,BOOL isSelect);

@interface BookMarkView : UIView

@property (nonatomic,strong)UIView *tagView;//上面的view
@property (nonatomic,strong)UICollectionView *tagListView;

@property (nonatomic,strong) UICollectionView *contentListView;//下面的view

@property (nonatomic,copy)TopViewRightButtonClickBlock rightClickBlock;//上面view的按钮点击事件

@property (nonatomic,weak)id <BookMarkViewDelegate> delegate;
@property (nonatomic,weak)id <BookMarkViewDataSource> dataSource;

@property (nonatomic,assign)NSInteger startIndex;//刚开始默认的展示位置

@property (nonatomic,assign)BOOL isCanScroll;//是否可以滑动，这个是指contentList是否可以滑动

@property (nonatomic,assign)BOOL isHiddenTagHeaderView;//上面的tagview是否隐藏,这个必须调用setUpViewInBookmarkView，这个方法才有效果

//绑定tag的cell和数据
- (void)registTagListCellClass:(Class)cellClass forItemClass:(Class)itemClass;

//设置右边的button，可以设置多个,同时在设置的时候，不用去添加事件，因为默认已经把事件添加到本控件中了，通过rightClickBlock去回调
- (void)setbuttonItems:(UIButton*)btnItem,...;

//刷新
- (void)reloadData;

//如果想加载在当前bookmarkview上，调用此方法，默认是不加载的，程序有的时候会单独使用
- (void)setUpViewInBookmarkView;

//获取当前选中的下标
- (NSInteger)currentIndex;

@end
