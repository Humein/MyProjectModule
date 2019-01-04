//
//  AbstractTableViewController.h
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2019/1/4.
//  Copyright © 2019 xinxin. All rights reserved.
//

#import "AbstractViewController.h"
NS_ASSUME_NONNULL_BEGIN


@interface AbstractTableViewController : AbstractViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,assign)UITableViewStyle tableViewStyle;
@property (nonatomic,strong)NSMutableArray *dataArray;

@property (nonatomic,assign)CGRect tableFrame;//设置桌面试图的frame

#pragma mark- 安装上拉和下拉

- (void)setUpHeaderRefresh;//设置头部刷新

- (void)setUpFooterRefresh;//设置尾部刷新

#pragma mark- 上拉和下拉的处理方法

- (void)downTableViewRefresh;//下拉刷新重写方法

- (void)pullTableViewRefresh;//上拉刷新重写方法

#pragma mark- 去掉上拉和下拉

- (void)removeDownRefresh;//去掉下拉

- (void)removePullRefresh;//去掉下拉

#pragma mark- 结束刷新状态

- (void)endRefresh;

- (void)noMoredata;

- (void)noMorePullData;

@end

NS_ASSUME_NONNULL_END
