//
//  SmoothTitleView.h
//  benkelaile-iOS
//
//  Created by Zhang Xin Xin on 2019/4/19.
//  Copyright © 2019 sunlands. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class SmoothTitleView;

@interface BookmarkTagViewCell :UICollectionViewCell

- (void)loadContentView:(UIView*)controllerView;

@end


@protocol SmoothTitleViewDataSource <NSObject>

@required

//tagcell的size
- (CGSize)bookmarkViewSizeForTagCellIndexPath:(NSIndexPath*)indexPath bookmarkView:(SmoothTitleView*)bookmarkView;

//tagcell的数据源
- (NSArray*)bookmarkViewTagListItems:(SmoothTitleView*)bookmarkView;

//tag的cell和item之间的关联,bool表示是否是当前选中的
- (void)bookmarkViewTagListCellForItemIndexPath:(NSIndexPath*)indexPath cell:(UICollectionViewCell*)cell bookmarkView:(SmoothTitleView*)bookmarkView isCurrentIndexPath:(BOOL)isCurrent;

@end


@protocol SmoothTitleViewDelegate<NSObject>

@optional

//重复点击同一个tagList中的cell
- (void)bookmarkViewSelectSameCellForTagCellIndexpath:(NSIndexPath*)indexPath bookmarkView:(SmoothTitleView*)bookmarkView;

//点击了taglist中的cell
- (void)bookmarkViewSelectCellForTagCellIndexPath:(NSIndexPath*)indexPath bookmarkView:(SmoothTitleView*)bookmarkView;

@end

typedef void (^TopViewRightButtonClickBlock)(UIButton *btn,NSInteger index,BOOL isSelect);

@interface SmoothTitleView : UIView

@property (nonatomic,strong)UIView *tagView;//上面的view
@property (nonatomic,strong)UICollectionView *tagListView;

@property (nonatomic,copy)TopViewRightButtonClickBlock rightClickBlock;//上面view的按钮点击事件

@property (nonatomic,weak)id <SmoothTitleViewDelegate> delegate;
@property (nonatomic,weak)id <SmoothTitleViewDataSource> dataSource;

@property (nonatomic,assign)NSInteger startIndex;//刚开始默认的展示位置

@property (nonatomic,assign) NSInteger currentTmpIndex;// 这里可以赋值，然后调用updateStyleWithCurrentIndexPath方法更新

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

// 更新TagList下标
- (void)updateStyleWithCurrentIndexPath;

@end



NS_ASSUME_NONNULL_END
