//
//  AbstractTableViewController.m
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2019/1/4.
//  Copyright © 2019 xinxin. All rights reserved.
//

#import "AbstractTableViewController.h"
#import "MJRefresh.h"

@interface AbstractTableViewController ()

@end

@implementation AbstractTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];

}

#pragma mark- 设置头部和尾部刷新
//设置头部刷新
- (void)setUpHeaderRefresh
{
    if (self.tableView.mj_header)
    {
        [self.tableView.mj_header removeFromSuperview];
        self.tableView.mj_header=nil;
    }
//    RefreshHeaderView *header =[RefreshHeaderView headerWithRefreshingTarget:self refreshingAction:@selector(downTableView_in)];
//    // 设置header
//    self.tableView.mj_header = header;
//
//    // 设置自动切换透明度(在导航栏下面自动隐藏)
//    self.tableView.mj_header.automaticallyChangeAlpha = YES;
}

- (void)downTableView_in
{
    if (self.tableView.mj_footer)
    {
        [self setUpFooterRefresh];
    }
    [self downTableViewRefresh];
}

//设置尾部刷新
- (void)setUpFooterRefresh
{
    if (self.tableView.mj_footer)
    {
        [self.tableView.mj_footer removeFromSuperview];
        self.tableView.mj_footer= nil;
    }
//    RefreshFooterView *footer= [RefreshFooterView footerWithRefreshingTarget:self refreshingAction:@selector(pullTableView_in)];
//    self.tableView.mj_footer = footer;
//    self.tableView.mj_footer.automaticallyChangeAlpha= YES;
}

- (void)pullTableView_in
{
    [self pullTableViewRefresh];
}

#pragma mark- 去掉上拉和下拉刷新
- (void)removeDownRefresh
{
    [self.tableView.mj_header removeFromSuperview];
    self.tableView.mj_header= nil;
}

- (void)removePullRefresh
{
    [self.tableView.mj_footer removeFromSuperview];
    self.tableView.mj_footer = nil;
}

- (void)downTableViewRefresh
{
    NSLog(@"下拉刷新");
}

- (void)pullTableViewRefresh
{
    NSLog(@"上拉刷新");
}

- (void)endRefresh
{
    if ([self.tableView.mj_header isRefreshing])
    {
        [self.tableView.mj_header endRefreshing];
    }
    if ([self.tableView.mj_footer isRefreshing])
    {
        [self.tableView.mj_footer endRefreshing];
    }
}

- (void)noMoredata
{
    if (self.tableView.mj_footer)
    {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }
}

- (void)noMorePullData{
    
    if (self.tableView.mj_header)
    {
        [self.tableView.mj_header endRefreshing];
    }
}

- (void)setTableFrame:(CGRect)tableFrame
{
    _tableFrame = tableFrame;
    if (_tableView)
    {
        _tableView.frame = tableFrame;
    }
}

#pragma mark- tableview的懒加载

- (UITableView*)tableView
{
    if (_tableView==nil)
    {
        _tableView=[[UITableView alloc]initWithFrame:_tableFrame style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [UIView new];
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.estimatedSectionFooterHeight=0.0f;
        _tableView.estimatedSectionHeaderHeight=0.0f;
        
        self.extendedLayoutIncludesOpaqueBars = YES;
        
        if (@available(iOS 11.0, *))
        {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        else
        {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _tableView;
}

- (NSMutableArray*)dataArray
{
    if (!_dataArray)
    {
        _dataArray=[NSMutableArray new];
    }
    return _dataArray;
}

- (void)setTableViewStyle:(UITableViewStyle)style
{
    if (style==UITableViewStylePlain)
    {
        return;
    }else{
        _tableView.delegate = nil;
        _tableView.dataSource = nil;
        [_tableView removeFromSuperview];
        _tableView = nil;
        
        _tableView=[[UITableView alloc]initWithFrame:_tableFrame style:UITableViewStyleGrouped];
        _tableView.dataSource=self;
        _tableView.delegate=self;
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;        
        _tableView.estimatedSectionFooterHeight=0.0f;
        _tableView.estimatedSectionHeaderHeight=0.0f;
        
        self.extendedLayoutIncludesOpaqueBars = YES;
        
        if (@available(iOS 11.0, *)) {
            
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
            _tableView.scrollIndicatorInsets = _tableView.contentInset;
            
        }else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    [self.view addSubview:_tableView];
    
}

#pragma mark- tableview

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indentify=@"indentify";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentify];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentify];
    }
    cell.textLabel.text = [_dataArray objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_tableView.separatorStyle == UITableViewCellSeparatorStyleNone) {
        return;
    }
    // 下面这几行代码是用来设置cell的上下行线的位置
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]){
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01f;
}

#pragma mark- tableview的一个无数据占位代理

- (NSString*)tableViewPlaceHolderDescriptForEmptyData
{
    return @"哎呀，无数据，点击重试！";
}

- (UIImage*)tableViewPlaceHolderImageForEmptyData
{
    return [UIImage imageNamed:@"noDataPlace"];
}

#pragma mark- 做适配

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)adjustForHotport
{
    self.tableFrame= self.tableFrame;
}


@end
