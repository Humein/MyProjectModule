//
//  TreeDiffModelViewController.m
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2019/1/4.
//  Copyright © 2019 xinxin. All rights reserved.
//

#import "TreeDiffModelViewController.h"
#import "RequestMediatorBaseBusniess.h"
#import "PointTreeTypeOne.h"
#import "MJExtension.h"
#import "PointTreeTypeTwo.h"
#import "PointTreeTypeThree.h"
#import "PointsTreeTableViewCell.h"

@interface TreeDiffModelViewController ()

@end

@implementation TreeDiffModelViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    WEAKSELF;
    [self requestPointTreeDataWithParentId:0 isWaiting:NO finished:^(id data) {
        
        weakSelf.dataArray = data;
    }];
    
    
    self.rightBarItem(@"下一级", CGRectMake(0, 0, 30, 30), NO).rightBarItem(@"再下一级",CGRectMake(0, 0, 30, 30),NO);
    self.rightBarItemClickBlock = ^(UIButton *button, NSInteger index) {
        CompositePointTreeModel *model = weakSelf.dataArray[index];
        // 分级请求知识树数据
        [weakSelf requestPointTreeDataWithParentId:[[model cParentId] integerValue] isWaiting:YES finished:^(id data) {
            //树形结构模型 存储 数据源  ([self.dataArray insertObjects:model.children atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(indexPath.row + 1, model.children.count)]])
            model.children = data;
            
        }];
    };

}

// 分级请求知识树数据
- (void)requestPointTreeDataWithParentId:(NSInteger)parentId isWaiting:(BOOL)isWaiting finished:(void (^)(id data))finished{

    [RequestMediatorBaseBusniess requestConfig:^(RequestMediatorBaseBusniess * _Nullable configObject) {
        configObject.requestUrl = @"https://ns.huatu.com/c/v5/courses/70969/classSyllabus";
        configObject.requestArgument = @{
                                         @"page":@1,
                                         @"pageSize":@20,
                                         @"parentId":@(parentId).stringValue
                                         };
        configObject.requestMethod = YTKRequestMethodGET;
    } withSuccess:^(NSString * _Nonnull succMessage, id  _Nonnull responseObject, NSInteger succCode) {
        
        NSArray * listArray = responseObject[@"data"][@"list"];
        NSMutableArray *dataArrM = [NSMutableArray array];
        [listArray enumerateObjectsUsingBlock:^(NSDictionary*  _Nonnull objDic, NSUInteger idx, BOOL * _Nonnull stop) {
            //            同一个数据源里面 有多个模型组合
            
            // 用字典取
            id <ModelProtocol>abstmodel;
            if([objDic[@"type"] integerValue] == 0) {
                
                abstmodel = [PointTreeTypeOne mj_objectWithKeyValues:objDic];
            }else if([objDic[@"type"] integerValue] == 1){
                
                abstmodel = [PointTreeTypeTwo mj_objectWithKeyValues:objDic];
            }else if([objDic[@"type"] integerValue] == 2){
                
                abstmodel = [PointTreeTypeThree mj_objectWithKeyValues:objDic];
            }
            
            CompositePointTreeModel *dataModle = [CompositePointTreeModel  new];
            dataModle.showTitle = [abstmodel showTitle];
            dataModle.cParentId = [abstmodel cParentId];
            [dataArrM addObject:dataModle];
        }];
        
        finished(dataArrM);


    } andFailure:^(NSString * _Nonnull errorMessage, id  _Nonnull result, NSInteger errorCode) {
        
    }];
    
}



@end
