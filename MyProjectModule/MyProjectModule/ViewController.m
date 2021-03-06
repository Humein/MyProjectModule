//
//  ViewController.m
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/6/11.
//  Copyright © 2018年 xinxin. All rights reserved.
//


#define WEAKSELF typeof(self) __weak weakSelf = self;

#define STRONGSELF typeof(weakSelf) __strong strongSelf = weakSelf;


#import "ViewController.h"
#import "PopTableView.h"
#import "AlertTableView.h"
#import "CellModel.h"
#import "AbstractTableViewCell.h"
#import "HitEventStrikeView.h"
#import "BlockObject.h"
//#import <Flutter/Flutter.h>
#import "FlutterSubViewController.h"
#import "YYFPSLabel.h"
#import "MyProjectModule-Swift.h"
#include <execinfo.h>
#import "TimeProfiler.h"
#import "DoraemonTimeProfiler.h"

void UncaughtExceptionHandler(NSException *exception) {
    NSArray *exceptionArray = [exception callStackSymbols]; //得到当前调用栈信息
    NSString *exceptionReason = [exception reason];       //非常重要，就是崩溃的原因
    NSString *exceptionName = [exception name];           //异常类型
}

@interface ViewController ()<AlertTableViewDelegate> {
    NSString *_name;
}
@property (nonatomic,strong)AlertTableView *tableView;
@property (nonatomic,strong)NSMutableArray *itemList;
@property (nonatomic,weak)AlertTableView *weakTableView;
@property (nonatomic,weak)NSArray *weakArray;
@property (nonatomic,strong) YYFPSLabel *fpsLabel;


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
    
//    NSMutableDictionary *test = [NSMutableDictionary dictionaryWithDictionary:@{@"testInteger":@"1"}];
//    NSObject *obj = [NSObject new];
//    [obj setValue:nil forKey:@"testInteger"];
//    [test setValue:nil forKey:@"testInteger"];
//
    WEAKSELF
    _fpsLabel = [[YYFPSLabel alloc]initWithFrame:CGRectMake(40, 40, 55, 20)];
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:_fpsLabel];
    NSClassFromString(@"TtC19ClassWrittenInSwift11AppDelegate");
    self.rightBarItem(@"FlutterDemo", CGRectMake(-0, 0, 100, 40), NO);
    self.rightBarItemClickBlock = ^(UIButton *button, NSInteger index) {
//        [weakSelf pushFlutterViewController_MethodChannel];
    };
    NSNull *nul = [NSNull new];
    NSArray *arr = @[nul,@"1",@"2"];
//    NSUInteger l = ((NSString *)arr.firstObject).length;
    
    
    self.itemList = [NSMutableArray array];
    NSArray *list = [NSArray arrayWithObjects:@"XXRuntimeUagesViewController",@"APMIndexListViewController",@"AvoidCrashViewController",@"UISampleExampleVC",@"AVViewController",@"TestOnewCollecionViewController",@"SubTwoSwiftDemosViewController",@"SubOneSwiftDemosViewController",@"RenderImageViewController",@"RotationImageViewController",@"TransitionsAnimationDemos",@"ThreadSafeContainer",@"TestBlockModelViewController",@"BookmarkViewDemo",@"VTBEncDecViewController",@"VTBEncodeViewController",@"SwiftDemosViewController", @"DownListViewController", @"colloctionViewController",@"DrawViewController",@"CollectionSectionViewController",@"PlayerViewController", @"RChainDemoViewController",@"DecoratorViewController",@"ThreadViewController",@"TablePopDemoViewController",@"CustomKVO",@"FBKVOViewController",@"LiveCommentDemoViewController",@"NSInvocationForStrategyViewController",@"BlockViewController",@"RunLoopDemoViewController",@"RunTimeTestViewController",@"ClassClusterViewController",@"Multi-CellTree-TableViewController",@"PointTreeOneModelViewController",@"DesignModeViewController",nil];

    [list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) { 
        CellModel *model =  [CellModel new];
        model.itemHeight = [model titleHeight];
        model.title = (NSString*)obj;
        model.timeCount = arc4random() % 30;
        [self.itemList addObject:model];
    }];

    [self.tableView registCell:[AbstractTableViewCell class] forItem:[CellModel class]];
 
    
    
    
    
    id a = nil;
    NSString *b = @"1";
    a = b;
    NSLog(@"%@",a);
    
    
//    self.weakTableView = [AlertTableView new];
    AlertTableView *weakView = [AlertTableView new];
    self.weakTableView = weakView;
    self.weakArray = [NSArray array];

}





#pragma mark ---NetWorkRequest


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    // 开始记录 摇一摇出现函数耗时记录
    [[TimeProfiler shareInstance] TPStartTrace:"touchesBegan函数"];
    //默认3；不调用的话，默认是3
    [[TimeProfiler shareInstance] TPSetMaxDepth:3];
    //单位为us，1ms = 1000us；不调用的话，默认是1000us
    [[TimeProfiler shareInstance] TPSetCostMinTime:1000];
    //需要过滤的类，不调用此方法，默认为TimeProfilerVC、TPRecordHierarchyModel、 TPRecordCell、TPRecordModel等TimeProfiler本身类（不统计过滤的类
//    [[TimeProfiler shareInstance] TPSetFilterClass:nil];
//    [DoraemonTimeProfiler startRecord];
    
    [self aleartView];
    
    __block int i = 10;
    dispatch_async(dispatch_get_main_queue(), ^{
        // 注意 i 被block持有 同一个对象
        i = 100;
    });
    NSLog(@"====%@",  @(i)); // 10
    
    

    int b = 1;
    dispatch_async(dispatch_get_main_queue(), ^{
     NSLog(@"====%i",b); // 正常为 1  加 __block 后 100
    });
    b = 100;

    void(^Block)(void) = ^{

        self->_name =@"the name";

    };
    Block();

//  block 野指针 crash
    __block BlockObject *testObj = [BlockObject new];
    __block __weak BlockObject *weakTestObj = testObj; //弱引用不会导致Block捕获对象的引用计数增加

    testObj.popBlock = ^{
//        testObj = nil;// 会触发delloc 然后崩溃
        weakTestObj = nil; // 这么处理不会崩溃
//        { // 这样 也不会，放在子线程置nil; 这样delloc会在popBlock作用域之后指向；这时 self 都是 纯在的
//        dispatch_queue_t quene = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//        dispatch_async(quene, ^{
//            testObj = nil; // 会触发delloc
//        });
//        }
    };
    [testObj testMethod];
    
    // strongSelf 作用
    typeof(self) __weak weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        typeof(weakSelf) __strong strongSelf = weakSelf;
        // 1. 不引入 strongSelf，这个页面POP后，直接执行delloc. 同时3秒后block内部再访问weakSelf是nil
        // 2. 引入 strongSelf, 这个页面POP后， 不执行delloc. 同时3秒后block内部再访问strongSelf是有值的，block执行完成后，再执行delloc。
        // 3. weakSelf 造成的问题是，如果将这个对象插入字典时候，可能会造成崩溃。
        
    });

//    [DoraemonTimeProfiler stopRecord];
    // 结束记录
    [[TimeProfiler shareInstance] TPStopTrace];
}


#pragma mark - 测试代码


#pragma mark --- PrivateMetho
-(void)aleartView{
    
    //  AlertTableView
    self.view.backgroundColor = [UIColor redColor];
    self.tableView.FromPoint = CGPointMake(0, 80);
    self.tableView.isSelectIndexToHidden= YES;
    self.tableView.tableViewFrame= CGRectMake(0, 0 , self.view.frame.size.width, 20 * self.itemList.count);
    self.tableView.tableView.layer.cornerRadius= 4;
    self.tableView.tableView.contentInset=UIEdgeInsetsMake(0, 0, 0, 0);
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(30 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [NSObject performSelector:@selector(oo)];
//    });

    
    
    [self.tableView showInView:self.view];
    [self.tableView reloadData];
    // scrollView 偏移量
    //    NSIndexPath * IndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    //    [self.tableView scrollToRowAtIndexPath:IndexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
    
//    [self.tableView.tableView scrollRectToVisible:CGRectMake(0, 0, 10000, 10000) animated:YES];
    
    // scrollToRowAtIndexPath cell 过多会造成卡顿
//    [self.tableView.tableView setContentOffset:CGPointMake(0, CGFLOAT_MAX)];

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
    if ([item.title isEqualToString:@"TestOnewCollecionViewController"]) {
        TestOnewCollecionViewController *userSetSwift = [[TestOnewCollecionViewController alloc] init];
        userSetSwift.hidesBottomBarWhenPushed= YES;
        [self.navigationController pushViewController:userSetSwift animated:YES];
        return;
    }
    if ([item.title isEqualToString:@"TestBlockModelViewController"]) {
        TestBlockModelViewController *userSetSwift = [[TestBlockModelViewController alloc] init];
        userSetSwift.hidesBottomBarWhenPushed= YES;
        [self.navigationController pushViewController:userSetSwift animated:YES];
        return;
    }
    if ([item.title isEqualToString:@"TransitionsAnimationDemos"]) {
        TransitionsAnimationDemos *userSetSwift = [[TransitionsAnimationDemos alloc] init];
        userSetSwift.hidesBottomBarWhenPushed= YES;
        [self.navigationController pushViewController:userSetSwift animated:YES];
        return;
    }
    
    if ([item.title isEqualToString:@"SubOneSwiftDemosViewController"]) {
        SubOneSwiftDemosViewController *userSetSwift = [[SubOneSwiftDemosViewController alloc] init];
        userSetSwift.hidesBottomBarWhenPushed= YES;
        [self.navigationController pushViewController:userSetSwift animated:YES];
        return;
    }
    
    if ([item.title isEqualToString:@"SubTwoSwiftDemosViewController"]) {
        SubTwoSwiftDemosViewController *userSetSwift = [[SubTwoSwiftDemosViewController alloc] init];
        userSetSwift.hidesBottomBarWhenPushed= YES;
        [self.navigationController pushViewController:userSetSwift animated:YES];
        return;
    }
    
    if ([item.title isEqualToString:@"UISampleExampleVC"]) {
        UISampleExampleVC *userSetSwift = [[UISampleExampleVC alloc] init];
        userSetSwift.hidesBottomBarWhenPushed= YES;
        [self.navigationController pushViewController:userSetSwift animated:YES];
        return;
    }
    
    
    
    if (VC == nil) {
        SwiftDemosViewController *userSetSwift = [[SwiftDemosViewController alloc] init];
        userSetSwift.hidesBottomBarWhenPushed= YES;
        [self.navigationController pushViewController:userSetSwift animated:YES];
    }
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


#pragma mark - Flutter
//- (void)pushFlutterViewController_MethodChannel {
//    FlutterViewController* flutterViewController = [[FlutterViewController alloc] initWithProject:nil nibName:nil bundle:nil];
//    flutterViewController.hidesBottomBarWhenPushed = YES;
//    flutterViewController.navigationItem.title = @"MethodChannel Demo";
//    __weak __typeof(self) weakSelf = self;
//
//    // 要与main.dart中一致
//    NSString *channelName = @"com.pages.your/native_get";
//
//    FlutterMethodChannel *messageChannel = [FlutterMethodChannel methodChannelWithName:channelName binaryMessenger:flutterViewController];
//
//    [messageChannel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
//        // call.method 获取 flutter 给回到的方法名，要匹配到 channelName 对应的多个 发送方法名，一般需要判断区分
//        // call.arguments 获取到 flutter 给到的参数，（比如跳转到另一个页面所需要参数）
//        // result 是给flutter的回调 , 只能回调一次
//        NSLog(@"flutter 给到我：\nmethod=%@ \narguments = %@",call.method,call.arguments);
//
//        if ([call.method isEqualToString:@"toNativeSomething"]) {
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"flutter回调" message:[NSString stringWithFormat:@"%@",call.arguments] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
//            [alertView show];
//
//            // 回调给flutter
//            if (result) {
//                result(@1000);
//            }
//        } else if ([call.method isEqualToString:@"toNativePush"]) {
//            [weakSelf pushFlutterViewController_EventChannel];
//        } else if ([call.method isEqualToString:@"toNativePop"]) {
//            [weakSelf.navigationController popViewControllerAnimated:YES];
//        }
//    }];
//
//    [self.navigationController pushViewController:flutterViewController animated:YES];
//}

- (void)pushFlutterViewController_EventChannel {
//    FlutterViewController* flutterViewController = [[FlutterViewController alloc] initWithProject:nil nibName:nil bundle:nil];
//    flutterViewController.navigationItem.title = @"EventChannel Demo";
//    // 要与main.dart中一致
//    NSString *channelName = @"com.pages.your/native_post";
//
//    FlutterEventChannel *evenChannal = [FlutterEventChannel eventChannelWithName:channelName binaryMessenger:flutterViewController];
//    // 代理
//    [evenChannal setStreamHandler:self];
//
//    [self.navigationController pushViewController:flutterViewController animated:YES];
}

#pragma mark - <FlutterStreamHandler>
// // 这个onListen是Flutter端开始监听这个channel时的回调，第二个参数 EventSink是用来传数据的载体。
//- (FlutterError* _Nullable)onListenWithArguments:(id _Nullable)arguments
//                                       eventSink:(FlutterEventSink)events {
//
//    // arguments flutter给native的参数
//    // 回调给flutter, 建议使用实例指向，因为该block可以使用多次
//    if (events) {
//        events(@"我是标题");
//    }
//    return nil;
//}
//
///// flutter不再接收
//- (FlutterError* _Nullable)onCancelWithArguments:(id _Nullable)arguments {
//    // arguments flutter给native的参数
//    return nil;
//}



#pragma mark -popOverDelegate

#pragma mark - PrivateMethod



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
#pragma mark - PublicMethod

#pragma mark - LazyLoad
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
