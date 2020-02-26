//
//  ClassClusterViewController.m
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2019/1/11.
//  Copyright © 2019 xinxin. All rights reserved.
//

#import "ClassClusterViewController.h"
#import "ClassClusterBaseTableViewCell.h"
#import "MJExtension.h"
#import "ProtoclForCMutilellViewController.h"
@interface ClassClusterViewController ()

@end

@implementation ClassClusterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initDataAndTabel];
    
    
    // TEST EXTERN  
    NSString * const HTCommonGuideViewType_toString[] =
    {
        [0] = @"HTCommonGuideViewTypeVedio",
        [1] = @"HTCommonGuideViewTypeOther"
    };
    NSLog(@"HTCommonGuideViewType_toString======%@",HTCommonGuideViewType_toString[0]);

    
    
     
}

//递归测试
-(void)recursionTest{
    
    NSLog(@"++++++++");
    
    [self recursionTest];
}



-(void)initDataAndTabel{
    self.tableFrame= CGRectMake(0, 0, SCREEN_W,SCREEN_H);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableViewStyle = UITableViewStyleGrouped;

    
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
    ClassClusterBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:model.cellReuseID];
    if (!cell) {
        // 类族模式
        cell = [ClassClusterBaseTableViewCell cellWithType:model.type];
        // 协议
//        UITableViewCell<MultiCellConfigPropotol> * cell= [tableView dequeueReusableCellWithIdentifier:cellID];

    }
    [cell setModel:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // 跳转到协议模式实现
    ProtoclForCMutilellViewController *VC = [ProtoclForCMutilellViewController new];
    [self.navigationController pushViewController:VC animated:YES];
}


#pragma mark - Net
- (void)loadData:(void (^)(void))success{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"class_cluster_data" ofType:@"json"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    for (NSDictionary *dict in dic[@"data"][@"list"]) {
        ClassClusterModel *model = [ClassClusterModel mj_objectWithKeyValues:dict];
        [self.dataArray addObject:model];
        switch (model.type) {
            case XXClassClusterTypeA:
            {
                model.cellReuseID = XXClassClusterCellAReuseID;
            }
                break;
            case XXClassClusterTypeB:
            {
                model.cellReuseID = XXClassClusterCellBReuseID;
            }
                break;
            case XXClassClusterTypeC:
            {
                model.cellReuseID = XXClassClusterCellCReuseID;
            }
                break;
        }
    }
  
}

@end
