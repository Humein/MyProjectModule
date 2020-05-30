//
//  SmoothBookmarkViewController.h
//  benkelaile-iOS
//
//  Created by Zhang Xin Xin on 2019/4/19.
//  Copyright © 2019 sunlands. All rights reserved.
//

#import "AbstractViewController.h"
#import "SmoothBookmarkView.h"
#import "SmoothTitleView.h"
#import "CheckConditionCollectionViewCell.h"
#import "CheckConditionItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface SmoothBookmarkViewController : AbstractViewController <SmoothTitleViewDataSource, SmoothTitleViewDelegate, SmoothBookmarkViewDelegate>


/**
 标题item数组
 */
@property (nonatomic,strong) NSMutableArray<CheckConditionItem *> *itemsArray;
/**
 子视图数组
 */
@property (nonatomic, strong) NSMutableArray<UIView *> *listViewArray;
/**
 标题View
 */
@property (nonatomic, strong) SmoothTitleView *bookmarkView;
/**
 头部View
 */
@property (nonatomic, strong) UIView *headerView;

/**
 该方法不需调用，需要在子类实现
 */
- (void)setupChildVc; // 设置子控制器
/**
 该方法不需调用，需要在子类实现
 */
- (void)setupHeaderView; // 设置头部视图

@end

NS_ASSUME_NONNULL_END
