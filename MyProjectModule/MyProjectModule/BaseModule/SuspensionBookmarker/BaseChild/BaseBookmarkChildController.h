//
//  BaseBookmarkChildController.h
//  benkelaile-iOS
//
//  Created by Zhang Xin Xin on 2019/4/19.
//  Copyright © 2019 sunlands. All rights reserved.
//

#import "AbstractTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BookmarkChildListViewDelegate <NSObject>

// tableView滑动时的代理方法
- (void)listViewDidScroll:(UIScrollView *)scrollView;

@end

@interface BaseBookmarkChildController : AbstractTableViewController

@property (nonatomic, weak) id<BookmarkChildListViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
