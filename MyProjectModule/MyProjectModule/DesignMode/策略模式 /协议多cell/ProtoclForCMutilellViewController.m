//
//  ProtoclForCMutilellViewController.m
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2019/4/8.
//  Copyright © 2019 xinxin. All rights reserved.
//

#import "ProtoclForCMutilellViewController.h"
#import "MultiCellProtocol.h"
#import "ClassClusterModel.h"
#import "MJExtension.h"

@interface ProtoclForCMutilellViewController ()

@end

@implementation ProtoclForCMutilellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDataAndTabel];
    
}


-(void)initDataAndTabel{
    self.tableFrame= CGRectMake(0, 0, SCREEN_W,SCREEN_H);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableViewStyle = UITableViewStyleGrouped;
    
    
    // 注册CELL
    for (int i = 0; i < 3; i++) {
        NSString *tmp = @"";
        switch (i) {
            case 0:
                tmp = @"A";
                break;
            case 1:
                tmp = @"B";
                break;
            case 2:
                tmp = @"C";
                break;
            default:
                break;
        }
        
        NSString *cellID = [NSString stringWithFormat:@"cellID_%d",i];
        NSString *cellClass = [NSString stringWithFormat:@"ClassClusterTableViewCell%@",tmp];
        [self.tableView registerClass:NSClassFromString(cellClass) forCellReuseIdentifier:cellID];

    }

    
    WEAKSELF;
    [self loadData:^{
        
        [weakSelf.tableView reloadData];
    }];
}



#pragma mark - TabelDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ClassClusterModel *model = self.dataArray[indexPath.row];
 
    NSString * cellID = model.cellReuseID;
    
    UITableViewCell<MultiCellConfigPropotol> * cell= [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if ([cell respondsToSelector:@selector(configCellWithModel:)]) {
        
        [cell configCellWithModel:model];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ClassClusterModel *model = self.dataArray[indexPath.row];

}


#pragma mark - Net
- (void)loadData:(void (^)(void))success{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"class_cluster_data" ofType:@"json"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    for (NSDictionary *dict in dic[@"data"][@"list"]) {
        ClassClusterModel *model = [ClassClusterModel mj_objectWithKeyValues:dict];
        
        
        {
            // 数据回来区分不同CELL
        int x = arc4random() % (3 - 0 + 0) + 0;

        NSString *cellID = [NSString stringWithFormat:@"cellID_%d",x];

        model.cellReuseID = cellID;
            
        }
        
        [self.dataArray addObject:model];

    }
    
}


@end
