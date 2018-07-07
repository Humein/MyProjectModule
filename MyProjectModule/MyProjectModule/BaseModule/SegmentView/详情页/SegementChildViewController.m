//
//  SegementChildViewController.m
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/6/21.
//  Copyright © 2018年 xinxin. All rights reserved.
//


#import "SegementChildViewController.h"
#import "SectionModel.h"

@interface SegementChildViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray<NSArray *> *dataSources;

@end

@implementation SegementChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    

    


    
    UIView *tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 88)];
    tableHeaderView.backgroundColor = [UIColor whiteColor];
    UIView *tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    tableFooterView.backgroundColor = [UIColor brownColor];
    self.tableView.tableHeaderView = tableHeaderView;
    self.tableView.tableFooterView = tableFooterView;
    [self.view addSubview:self.tableView];

    
//    PackAge Data
    
    SectionModel *reportDetail = [[SectionModel alloc]initWithPushControllerClassString:@"ZTKHomeReportDetailViewController" titleImage:@"ZTKHomeReportDetailViewController" title:@"ZTKHomeReportDetailViewController" arrowImage:@"ZTKHomeReportDetailViewController"];
    SectionModel *arenaCentre = [[SectionModel alloc]initWithPushControllerClassString:@"ZTKArenaCentreViewController" titleImage:@"ZTKArenaCentreViewController" title:@"ZTKArenaCentreViewController" arrowImage:@"ZTKArenaCentreViewController"];
    SectionModel *paperReal = [[SectionModel alloc]initWithPushControllerClassString:@"PaperAreaViewController" titleImage:@"PaperAreaViewController" title:@"PaperAreaViewController" arrowImage:@"PaperAreaViewController"];
    SectionModel *proModele = [[SectionModel alloc]initWithPushControllerClassString:@"ModeleTableViewController" titleImage:@"ModeleTableViewController" title:@"ModeleTableViewController" arrowImage:@"ModeleTableViewController"];
    SectionModel *estimation= [[SectionModel alloc]initWithPushControllerClassString:@"PaperTestTableViewController" titleImage:@"PaperTestTableViewController" title:@"PaperTestTableViewController" arrowImage:@"PaperTestTableViewController"];

    NSArray *firstArr = @[];
    NSMutableArray *secondArr = [NSMutableArray arrayWithArray:@[arenaCentre, paperReal]];
    NSArray *thirdArr = @[proModele, estimation];
    
    
    
    self.dataSources = [NSMutableArray arrayWithArray:@[firstArr,
                                                        secondArr.copy,
                                                        ]];
    
}



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

}


#pragma mark ----- UITableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSources.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSources[section].count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
     return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"ZTKMineHomeCommomTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    SectionModel *viewModel = self.dataSources[indexPath.section][indexPath.row];

    cell.textLabel.text = [NSString stringWithFormat:@"%@%ld",viewModel.title,(long)self.categoryId];
    
    return cell;
    
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    __weak typeof(self) weakSelf = self;
//    HTStandardAnswerHeaderView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([HTStandardAnswerHeaderView class])];
//    view.model = self.model.answerList[section];
//    [view setButtonClick:^(HTTopicStandardAnswerModel *model, BOOL open) {
//        [weakSelf.tableView reloadData];
//    }];
//    return view;
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 2)];
    view.backgroundColor = [UIColor redColor];
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 2)];
    view.backgroundColor = [UIColor yellowColor];
    return view;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  YES;
}




- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除"handler:^(UITableViewRowAction *action,NSIndexPath *indexPath) {
        
        NSLog(@"点击了删除");
    }];
    
    UITableViewRowAction *hasReadAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"标为已读"handler:^(UITableViewRowAction *action,NSIndexPath *indexPath) {
        
        NSLog(@"点击了标为已读");
    }];
    hasReadAction.backgroundColor = [UIColor orangeColor];
    
    UITableViewRowAction *moreRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"更多"handler:^(UITableViewRowAction *action,NSIndexPath *indexPath) {
        
        NSLog(@"点击了更多");
    }];
    moreRowAction.backgroundEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    
    return @[deleteRowAction, hasReadAction, moreRowAction];
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SectionModel *viewModel = self.dataSources[indexPath.section][indexPath.row];
    Class class = NSClassFromString(viewModel.pushControllerClassString);
    UIViewController *viewController = (UIViewController *)[[class alloc] init];
    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:YES];
    
}




#pragma mark ---- get&&set
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        
        
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
