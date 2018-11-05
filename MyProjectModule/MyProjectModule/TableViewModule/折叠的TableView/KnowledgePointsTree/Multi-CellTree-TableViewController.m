//
//  Multi-CellTree-TableViewController.m
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2018/11/5.
//  Copyright © 2018 xinxin. All rights reserved.
//

#import "Multi-CellTree-TableViewController.h"
#import "TreeViewCell.h"
#import "PointTreeStatisTableViewCell.h"
@interface Multi_CellTree_TableViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)  NSMutableArray *dataArray;

@property (nonatomic,strong)UITableView *tableView;

@end

@implementation Multi_CellTree_TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [NSMutableArray array];
    [self initTalbleView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


-(void)initTalbleView{
    
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.estimatedRowHeight = 200;
    
    [self.tableView registerClass:[TreeViewCell class] forCellReuseIdentifier:@"TreeViewCell"];
    [self.tableView registerClass:[TreeViewCell class] forCellReuseIdentifier:@"TreeViewCell"];
    [self.tableView registerClass:[PointTreeStatisTableViewCell class] forCellReuseIdentifier:@"PointTreeStatisTableViewCell"];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger answerCardSection = 0;
    NSInteger pointsTreeSection = 1;
    switch (section) {
        case 0:
            return 10;
            break;
        case 1:
//            Tree Array
            return self.dataArray.count;
            break;
        case 2:
            return 10;
            break;
        default:
            return 1;
            break;
    };
    
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSInteger answerCardSection = 0;
    NSInteger pointsTreeSection = 1;
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 25)];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, self.view.frame.size.width, 20)];
    title.font = [UIFont systemFontOfSize:12];
    [headerView addSubview:title];
    
    if (section == answerCardSection) {
        title.text = @"答题卡";
    } else if (section == pointsTreeSection) {
        title.text = @"知识点情况";
    } else {
        return nil;
    }
    return headerView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return 0;
    } else {
        return 25;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger answerCardSection = 0;
    NSInteger pointsTreeSection = 1;
    
    if (indexPath.section == answerCardSection) {
        return 126;
    } else if (indexPath.section == pointsTreeSection) {
        return UITableViewAutomaticDimension;
    } else {
        return 80;
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    __weak typeof(self) weakSelf = self;
    
    NSInteger answerCardSection = 0;
    NSInteger pointsTreeSection = 1;

    if (indexPath.section == answerCardSection) {
        TreeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TreeViewCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = @"wwwwwwwwwww";
        return cell;
    } else if (indexPath.section == pointsTreeSection) {
        TreeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TreeViewCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = @"wwwwwwwwwww";
        return cell;
    } else {
        PointTreeStatisTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PointTreeStatisTableViewCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.treeModel = self.dataArray[indexPath.row];
        cell.spreadBtnBlock = ^{
            [weakSelf treeSeparate:indexPath];
        };
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger answerCardSection = 1;
    NSInteger pointsTreeSection = 2;

    if (indexPath.section == pointsTreeSection) {
        PointTreeModel * treeModel = self.dataArray[indexPath.row];
        if (treeModel.level == 2) {
            return;
        }
        [self treeSeparate:indexPath];
    }
    
}



// MARK: - 知识树展开逻辑
- (void)treeSeparate:(NSIndexPath *)indexPath {
    
    PointTreeModel *model = self.dataArray[indexPath.row];
    model.isSpread = !(model.isSpread);
    
    if (model.isSpread) {
        // 展开
        NSMutableArray *indexPathArray = [[NSMutableArray alloc] init];
        for(NSInteger i = indexPath.row + 1; i <= indexPath.row + model.children.count; i++){
            NSIndexPath *obj = [NSIndexPath indexPathForRow:i inSection:indexPath.section];
            [indexPathArray addObject:obj];
        }
        [self.dataArray insertObjects:model.children atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(indexPath.row + 1, model.children.count)]];
        [self.tableView insertRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationFade];
    } else {
        // 收回
        __block NSInteger childrenCount = 0;
        [model.children enumerateObjectsUsingBlock:^(PointTreeModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.isSpread) {
                childrenCount += obj.children.count;
                obj.isSpread = !(obj.isSpread);
            }
        }];
        NSMutableArray *indexPathArray = [[NSMutableArray alloc] init];
        for(NSInteger i = indexPath.row + 1; i <= indexPath.row + model.children.count + childrenCount; i++){
            NSIndexPath *obj = [NSIndexPath indexPathForRow:i inSection:indexPath.section];
            [indexPathArray addObject:obj];
        }
        [self.dataArray removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(indexPath.row + 1, model.children.count + childrenCount)]];
        [self.tableView deleteRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationFade];
    }
    // 这里刷新tableView，为了展开效果更好。还有一些cell的数据改变
    [self.tableView reloadData];
}

#pragma mark --- LazyLoad
#pragma mark- tableview的懒加载

- (UITableView*)tableView
{
    if (_tableView==nil)
    {
        _tableView=[[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
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

@end
