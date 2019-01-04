//
//  TreeDiffModelViewController.m
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2019/1/4.
//  Copyright © 2019 xinxin. All rights reserved.
//

#import "TreeDiffModelViewController.h"
#import "RequestMediatorBaseBusniess.h"
#import "CompositePointTreeModel.h"
#import "MJExtension.h"


@interface TreeDiffModelViewController ()

@end

@implementation TreeDiffModelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [RequestMediatorBaseBusniess requestConfig:^(RequestMediatorBaseBusniess * _Nullable configObject) {
        configObject.requestUrl = @"https://ns.huatu.com/c/v5/courses/70969/classSyllabus";
        configObject.requestArgument = @{
                                         @"page":@1,
                                         @"pageSize":@20,
                                         @"parentId":@0
                                         };
        configObject.requestMethod = YTKRequestMethodGET;
    } withSuccess:^(NSString * _Nonnull succMessage, id  _Nonnull responseObject, NSInteger succCode) {
        NSMutableArray<CompositePointTreeModel<ModelProtocol> *> *dataArrM = [CompositePointTreeModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        self.dataArray = dataArrM;
        
    } andFailure:^(NSString * _Nonnull errorMessage, id  _Nonnull result, NSInteger errorCode) {
        
    }];
}

@end
