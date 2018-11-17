//
//  ViewController.m
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/6/11.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#pragma mark --- lifeCycle

#pragma mark ---NetWorkRequest

#pragma mark ----Delegate

#pragma mark --- PrivateMethod

#pragma mark --- PublicMethod

#pragma mark --- LazyLoad



#define WEAKSELF typeof(self) __weak weakSelf = self;

#define STRONGSELF typeof(weakSelf) __strong strongSelf = weakSelf;


#import "ViewController.h"
#import "PopTableView.h"
#import "AlertTableView.h"
#import "CellModel.h"
#import "AbstractTableViewCell.h"
#import "HitEventStrikeView.h"
@interface ViewController ()<AlertTableViewDelegate>
@property (nonatomic,strong)AlertTableView *tableView;
@property (nonatomic,strong)NSMutableArray *itemList;
@end

@implementation ViewController

#pragma mark --- lifeCycle

- (void)loadView {
    //    AlertTableView事件穿透
    WEAKSELF;
    self.view = [HitEventStrikeView viewWithFrame:[UIScreen mainScreen].bounds hitTestBlock:^UIView * _Nullable(UIView * _Nullable hitView, CGPoint point, UIEvent * _Nullable event) {
        STRONGSELF;
        if ([hitView isKindOfClass:[AlertTableView class]]) {
            return strongSelf.view;
        }
        return hitView;
    }];
}


-(void)viewDidLoad{
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor grayColor];
    self.itemList = [NSMutableArray array];
    NSArray *list = [NSArray arrayWithObjects: @"colloctionViewController",@"DrawViewController",@"SegementDemoViewController",@"SegementPersonDemoViewController",@"SegementChildViewController",@"CollectionSectionViewController",@"PaternalViewController",@"PaternalSViewController",@"PlayerViewController", @"RChainDemoViewController",@"DecoratorViewController",@"ThreadViewController",@"TablePopDemoViewController",@"CustomKVO",@"FBKVOViewController",@"LiveCommentDemoViewController",@"NSInvocationForStrategyViewController",@"BlockViewController",@"RunLoopDemoViewController",nil];
    [list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) { 
        CellModel *model =  [CellModel new];
        model.itemHeight = [model titleHeight];
        model.title = (NSString*)obj;
        [self.itemList addObject:model];
    }];

    [self.tableView registCell:[AbstractTableViewCell class] forItem:[CellModel class]];
    
    
//    [self aleartView];


}


#pragma mark ---NetWorkRequest


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self aleartView];

}


#pragma mark --- PrivateMetho
-(void)aleartView{
    //  AlertTableView
    self.view.backgroundColor = [UIColor redColor];
    self.tableView.FromPoint = CGPointMake(0, 80);
    self.tableView.isSelectIndexToHidden= YES;
    self.tableView.tableViewFrame= CGRectMake(0, 0 , self.view.frame.size.width, 30 * self.itemList.count);
    self.tableView.tableView.layer.cornerRadius= 4;
    self.tableView.tableView.contentInset=UIEdgeInsetsMake(0, 0, 0, 0);
    
    
    
    
    [self.tableView showInView:self.view];
    [self.tableView reloadData];
    // scrollView 偏移量
    //    NSIndexPath * IndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    //    [self.tableView scrollToRowAtIndexPath:IndexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
    
    [self.tableView.tableView scrollRectToVisible:CGRectMake(0, 0, 10000, 10000) animated:YES];
}

#pragma mark ----Delegate

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
    VC.hidesBottomBarWhenPushed= YES;
    [self.navigationController pushViewController:VC animated:YES];
}


- (CGFloat)alertTableView:(AlertTableView *)alertTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CellModel *item = [self.itemList objectAtIndex:indexPath.row];
    
    if (0) {
        return 60.0f;
    }else if (0){
        return UITableViewAutomaticDimension;
    }
    return item.itemHeight;
}



#pragma mark ----popOverDelegate

#pragma mark --- PrivateMethod
//-(void)popOver{
//    NSArray *arr = @[@"colloctionView",@"2",@"3",@"1",@"2",@"3"];
//    PopTableView *pooView = [[PopTableView alloc]initWithFrame:CGRectMake(0,100, 258*0.5, arr.count * 30 + 20) dataSource:arr withBGView:@"弹窗"];
//    pooView.delegate = self;
//
//    [pooView show];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(30 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [pooView dismiss];
//    });
//}
#pragma mark --- PublicMethod

#pragma mark --- LazyLoad
- (AlertTableView *)tableView
{
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
