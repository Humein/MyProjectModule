//
//  APMIndexListViewController.m
//  MyProjectModule
//
//  Created by zhangxinxin on 2021/5/11.
//  Copyright © 2021 xinxin. All rights reserved.
//

#import "APMIndexListViewController.h"
#import "AlertTableView.h"
#import "AbstractTableViewCell.h"
#import "CellModel.h"
@interface APMIndexListViewController ()<AlertTableViewDelegate>
@property (nonatomic,strong)AlertTableView *tableView;
@property (nonatomic,strong)NSMutableArray *itemList;
@end

@implementation APMIndexListViewController
// TODO: 标示处有功能代码待编写
// FIXME: 标示处代码需要修正
// !!!: 标示处代码需要注意
// ???: 标示处代码有疑问

// MARK: - LifeCycle
-(void)dealloc {
    NSLog(@"%@销毁啦。。。。。。",NSStringFromClass(self.class));
}

-(void)viewDidLoad {
    [super viewDidLoad];
    [self configVC];
    [self configSubview];
}

// MARK: - View config
-(void)configVC {
    self.itemList = [NSMutableArray array];
    NSArray *list = [NSArray arrayWithObjects:@"XXMemoryMonitorMananger",nil];

    [list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CellModel *model =  [CellModel new];
        model.itemHeight = [model titleHeight];
        model.title = (NSString*)obj;
        [self.itemList addObject:model];
    }];
    [self.tableView registCell:[AbstractTableViewCell class] forItem:[CellModel class]];

}

-(void)configSubview {
    
}
// MARK: - Make Data

// MARK: - Private Method

// MARK: - Target Methods
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.tableView.FromPoint = CGPointMake(0, 180);
    self.tableView.isSelectIndexToHidden= YES;
    self.tableView.tableViewFrame= CGRectMake(0, 0 , self.view.frame.size.width, 44 * self.itemList.count);
    [self.tableView showInView:self.view];
    [self.tableView reloadData];
}
// MARK: - Delegate
#pragma mark- tableview的代理
- (NSMutableArray*)alertTableVieItemList
{
    return self.itemList;
}

- (void)alertTableViewCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    CellModel *item = [self.itemList objectAtIndex:indexPath.row];
    AbstractTableViewCell *tmpCell =(AbstractTableViewCell*)cell;
    [tmpCell updateByItem:item];
}

- (void)alertTableView:(AlertTableView *)TableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CellModel *item = [self.itemList objectAtIndex:indexPath.row];

    Class class = NSClassFromString(item.title);
    UIViewController *VC = [[class alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}


- (CGFloat)alertTableView:(AlertTableView *)alertTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

// MARK: - Getter / Setter
- (AlertTableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[AlertTableView alloc] initWithFrame:CGRectZero];
        _tableView.tableView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.8f];
        _tableView.delegate= self;
    }
    return _tableView;
}
- (NSMutableArray*)itemList
{
    if (_itemList==nil) {
        _itemList = [NSMutableArray new];
    }
    return _itemList;
}

@end
