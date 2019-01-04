//
//  PointTreeOneModelViewController.m
//  MyProjectModule
//
//  Created by 鑫鑫 on 2019/1/2.
//  Copyright © 2019 xinxin. All rights reserved.
//

#import "PointTreeOneModelViewController.h"
#import "RequestMediatorBaseBusniess.h"
#import "PointsTreeTableViewCell.h"
#import "MJExtension.h"

@interface PointTreeOneModelViewController ()

@end

@implementation PointTreeOneModelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableFrame= CGRectMake(0, 0, SCREEN_W, SCREEN_H);
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.tableView registerClass:[PointsTreeTableViewCell class] forCellReuseIdentifier:@"PointsTreeTableViewCell"];

    WEAKSELF;
    [self requestPointTreeDataWithParentId:0 isWaiting:NO finished:^(id data) {
        weakSelf.dataArray = data;
        [weakSelf.tableView reloadData];
    }];
    
}



// 分级请求知识树数据
- (void)requestPointTreeDataWithParentId:(NSInteger)parentId isWaiting:(BOOL)isWaiting finished:(void (^)(id data))finished{
    [RequestMediatorBaseBusniess requestConfig:^(RequestMediatorBaseBusniess * _Nullable configObject) {
        configObject.requestUrl = @"http://123.103.86.52/k/v1/points/collectionsByNode";
        configObject.requestArgument = @{@"parentId":@"0"};
        configObject.requestMethod = YTKRequestMethodGET;
    } withSuccess:^(NSString * _Nonnull succMessage, id  _Nonnull responseObject, NSInteger succCode) {
        NSMutableArray<PointTreeOnlyOneModel *> *dataArrM = [PointTreeOnlyOneModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        finished(dataArrM);
        
    } andFailure:^(NSString * _Nonnull errorMessage, id  _Nonnull result, NSInteger errorCode) {
        
    }];
}



//MARK: - tableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PointsTreeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PointsTreeTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.dataArray.count > 0) {
        // 该判断，是为了处理考试类型切换，数组越界，导致的一处崩溃问题
        cell.treeModel = self.dataArray[indexPath.row];
    }
    WEAKSELF
    cell.spreadBtnBlock = ^{
        PointTreeOnlyOneModel *model = weakSelf.dataArray[indexPath.row];
        
        if (model.children && model.children.count != 0 && model.isNextDataRequest) {
            [weakSelf treeSeparate:indexPath];
            [self.tableView reloadData];
        } else {
            // 分级请求知识树数据
            [weakSelf requestPointTreeDataWithParentId:model.id isWaiting:YES finished:^(id data) {
                model.children = data;
                model.isNextDataRequest = YES;
                [weakSelf treeSeparate:indexPath];
                [self.tableView reloadData];
            }];
        }
    };
    return cell;
}

//MARK: - tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 82;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 144;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

// MARK: - 知识树展开逻辑
- (void)treeSeparate:(NSIndexPath *)indexPath {
    
    PointTreeOnlyOneModel *model = self.dataArray[indexPath.row];
    model.isSpread = !(model.isSpread);
    
    if (model.isSpread) {
        // 展开
        NSMutableArray *indexPathArray = [[NSMutableArray alloc] init];
        for(NSInteger i = indexPath.row + 1; i <= indexPath.row + model.children.count; i++){
            NSIndexPath *obj = [NSIndexPath indexPathForRow:i inSection:0];
            [indexPathArray addObject:obj];
        }
        [self.dataArray insertObjects:model.children atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(indexPath.row + 1, model.children.count)]];
        [self.tableView insertRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationFade];
    } else {
        // 收回
        __block NSInteger childrenCount = 0;
        [model.children enumerateObjectsUsingBlock:^(PointTreeOnlyOneModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.isSpread) {
                childrenCount += obj.children.count;
                obj.isSpread = !(obj.isSpread);
            }
        }];
        NSMutableArray *indexPathArray = [[NSMutableArray alloc] init];
        for(NSInteger i = indexPath.row + 1; i <= indexPath.row + model.children.count + childrenCount; i++){
            NSIndexPath *obj = [NSIndexPath indexPathForRow:i inSection:0];
            [indexPathArray addObject:obj];
        }
        [self.dataArray removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(indexPath.row + 1, model.children.count + childrenCount)]];
        [self.tableView deleteRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationFade];
    }
}


@end
