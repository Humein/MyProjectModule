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
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [RequestMediatorBaseBusniess requestConfig:^(RequestMediatorBaseBusniess * _Nullable configObject) {
        configObject.requestUrl = @"http://123.103.86.52/k/v1/points/collectionsByNode";
        configObject.requestArgument = @{@"parentId":@"0"};
        configObject.requestMethod = YTKRequestMethodGET;
    } withSuccess:^(NSString * _Nonnull succMessage, id  _Nonnull responseObject, NSInteger succCode) {
        NSMutableArray<PointTreeOnlyOneModel *> *dataArrM = [PointTreeOnlyOneModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        self.dataArray = dataArrM;
    
    } andFailure:^(NSString * _Nonnull errorMessage, id  _Nonnull result, NSInteger errorCode) {
        
        
    }];
    
}

//MARK: - tableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}












@end
