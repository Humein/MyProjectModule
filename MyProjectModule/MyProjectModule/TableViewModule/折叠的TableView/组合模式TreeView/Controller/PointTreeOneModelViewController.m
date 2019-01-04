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
    
    
    self.rightBarItem(@"刷新树", CGRectMake(0, 0, 30, 30), NO);
    self.rightBarItemClickBlock = ^(UIButton *button, NSInteger index) {
        [weakSelf requestAllPointTreeData];
    };
}







// MARK: - 网络请求
// 分级请求知识树数据
- (void)requestPointTreeDataWithParentId:(NSInteger)parentId isWaiting:(BOOL)isWaiting finished:(void (^)(id data))finished{
    [RequestMediatorBaseBusniess requestConfig:^(RequestMediatorBaseBusniess * _Nullable configObject) {
        configObject.requestUrl = @"https://ns.huatu.com/k/v1/points/collectionsByNode";
        configObject.requestArgument = @{@"parentId":@(parentId).stringValue};
        configObject.requestMethod = YTKRequestMethodGET;
    } withSuccess:^(NSString * _Nonnull succMessage, id  _Nonnull responseObject, NSInteger succCode) {
        NSMutableArray<PointTreeOnlyOneModel *> *dataArrM = [PointTreeOnlyOneModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        finished(dataArrM);
        
    } andFailure:^(NSString * _Nonnull errorMessage, id  _Nonnull result, NSInteger errorCode) {
        
    }];
}

//全段请求用于刷新数据
- (void)requestAllPointTreeData{
    WEAKSELF
    [RequestMediatorBaseBusniess requestConfig:^(RequestMediatorBaseBusniess * _Nullable configObject) {
        configObject.requestUrl = @"https://ns.huatu.com/k/v1/points";
        configObject.requestMethod = YTKRequestMethodGET;
    } withSuccess:^(NSString * _Nonnull succMessage, id  _Nonnull responseObject, NSInteger succCode) {
        NSMutableArray<PointTreeOnlyOneModel *> *dataArrM = [PointTreeOnlyOneModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        // 和之前数据作对比，记忆树形结构
        weakSelf.dataArray = [weakSelf handleMemoryConStructWithOldArr:weakSelf.dataArray newArr:dataArrM];
        [weakSelf.tableView reloadData];
        
    } andFailure:^(NSString * _Nonnull errorMessage, id  _Nonnull result, NSInteger errorCode) {
        
    }];

}




// MARK: - 处理知识树模型，记忆树形展开结构
- (NSMutableArray<PointTreeOnlyOneModel *> *)handleMemoryConStructWithOldArr:(NSMutableArray<PointTreeOnlyOneModel *> *)oldArr newArr:(NSMutableArray<PointTreeOnlyOneModel *> *)newArr {
    
    // 把newArr的所有子节点全部取出来
    NSMutableArray<PointTreeOnlyOneModel *> *totalNewArrM = [NSMutableArray array];
    [self recursionHandleTotalNewArrM:totalNewArrM newArr:newArr isHandleNextRequest:YES];
    
    [oldArr enumerateObjectsUsingBlock:^(PointTreeOnlyOneModel * _Nonnull oldObj, NSUInteger oldIdx, BOOL * _Nonnull stop) {
        
        // 替换
        [totalNewArrM enumerateObjectsUsingBlock:^(PointTreeOnlyOneModel * _Nonnull newObj, NSUInteger newIdx, BOOL * _Nonnull stop) {
            
            if (oldObj.id == newObj.id) {
                
                newObj.isSpread = oldObj.isSpread;
                [oldArr replaceObjectAtIndex:oldIdx withObject:newObj];
            }
        }];
    }];
    
    return oldArr;
}
// 递归获取newArr的所有子节点
- (void)recursionHandleTotalNewArrM:(NSMutableArray<PointTreeOnlyOneModel *> *)totalArr newArr:(NSMutableArray<PointTreeOnlyOneModel *> *)newArr isHandleNextRequest:(BOOL)isHandleNextRequest {
    
    [newArr enumerateObjectsUsingBlock:^(PointTreeOnlyOneModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (isHandleNextRequest) {
            obj.isNextDataRequest = YES;
        }
        [totalArr addObject:obj];
        
        if (obj.children && obj.children.count != 0) {
            
            [self recursionHandleTotalNewArrM:totalArr newArr:obj.children.mutableCopy isHandleNextRequest:isHandleNextRequest];
        }
    }];
}




// MARK: - 知识树展开逻辑
- (void)treeSeparate:(NSIndexPath *)indexPath {
    
    //  不操作组合模式的模型  直接操作 self.dataArray 数据源
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
    
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    强制刷新
    /*
     如果在reloadDate后需要立即获取tableview的cell、高度，或者需要滚动tableview，那么，直接在reloadData后执行代码是有可能出问题的。
     reloadDate并不会等待tableview更新结束后才返回，而是立即返回，然后去计算表高度，获取cell等。
     如果表中的数据非常大，在一个run loop周期没执行完，这时，需要tableview视图数据的操作就会出问题了

     */
    [self.tableView layoutIfNeeded];

}







//MARK: - tableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PointsTreeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PointsTreeTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.dataArray.count > 0) {
        cell.treeModel = self.dataArray[indexPath.row];
    }
    WEAKSELF
    cell.spreadBtnBlock = ^{
        PointTreeOnlyOneModel *model = weakSelf.dataArray[indexPath.row];
        if (model.children && model.children.count != 0 && model.isNextDataRequest) {
            [weakSelf treeSeparate:indexPath];
        } else {
            // 分级请求知识树数据
            [weakSelf requestPointTreeDataWithParentId:model.id isWaiting:YES finished:^(id data) {
                //树形结构模型 存储 数据源
                model.children = data;
                
                model.isNextDataRequest = YES;
                [weakSelf treeSeparate:indexPath];
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


@end
