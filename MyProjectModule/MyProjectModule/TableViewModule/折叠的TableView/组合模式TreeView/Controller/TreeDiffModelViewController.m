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

@interface TreeDiffModelViewController ()

@end

@implementation TreeDiffModelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    [RequestMediatorBaseBusniess requestConfig:^(RequestMediatorBaseBusniess * _Nullable configObject) {
        configObject.requestUrl = @"https://ns.huatu.com/c/v5/courses/70969/classSyllabus";
        configObject.requestArgument = @{
                                         @"page":@1,
                                         @"pageSize":@20,
                                         @"parentId":@0
                                         };
        configObject.requestMethod = YTKRequestMethodGET;
    } withSuccess:^(NSString * _Nonnull succMessage, id  _Nonnull responseObject, NSInteger succCode) {
        
        NSArray * listArray = responseObject[@"data"][@"list"];
        [listArray enumerateObjectsUsingBlock:^(NSDictionary*  _Nonnull objDic, NSUInteger idx, BOOL * _Nonnull stop) {
//            同一个数据源里面 有多个模型组合
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
            [self.dataArray addObject:dataModle];
        }];
        
        
//        NSMutableArray<PointTreeTypeOne *> *dataArrM = [PointTreeTypeOne mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
//        [dataArrM enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            CompositePointTreeModel *dataModle = [CompositePointTreeModel  new];
//            dataModle.showTitle = [obj showTitle];
//            [self.dataArray addObject:dataModle];
//
//        }];
 
    } andFailure:^(NSString * _Nonnull errorMessage, id  _Nonnull result, NSInteger errorCode) {
        
    }];
}

@end
