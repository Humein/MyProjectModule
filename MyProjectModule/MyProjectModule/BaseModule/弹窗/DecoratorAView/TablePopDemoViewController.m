//
//  TablePopDemoViewController.m
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/7/27.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import "TablePopDemoViewController.h"
#import "DecoratorAView.h"
#import "CustomAlertManagerView.h"
#import "CustomAlertViewDefault.h"

@interface TablePopDemoViewController (){
    BOOL _b;
}
@property (nonatomic,assign)int a;
@end

@implementation TablePopDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    PopTableView *popVC = [[PopTableView alloc]initWithFrame:CGRectMake(0, 100, 200, 400) dataSource:@[@[@"1"],@[@"2"]] withBGView:@""];
//    DecoratorAView *alertVC = [[DecoratorAView alloc]initWithChickenBurger:popVC];
//    
//    [alertVC cellClicks:nil];
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    

    CustomAlertViewDefault *defaultView = [[CustomAlertViewDefault alloc]initWithFrame:CGRectMake(0, 0, 200, 100)];

    CustomAlertManagerView *VC = [CustomAlertManagerView new];
    VC.transferType = TopTransferDown;
    
    [VC showCustomViews:defaultView InView:self.view completionBlock:^(NSInteger index) {
        
    }];
    
    
//    [VC showCustomView:defaultView InView:self.view];
    
//    defaultView.handleBlock = ^(NSInteger index) {
//        [VC hidden];
//    };

    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
