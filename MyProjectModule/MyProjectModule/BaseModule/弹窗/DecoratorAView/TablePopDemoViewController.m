//
//  TablePopDemoViewController.m
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/7/27.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import "TablePopDemoViewController.h"
#import "DecoratorAView.h"
#import "CustomAlertView.h"
#import "CustomAlertViewDefault.h"

@interface TablePopDemoViewController ()

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
    
//    自定义弹窗
    CustomAlertViewDefault *defaultVC = [[CustomAlertViewDefault alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];

    defaultVC.backgroundColor = [UIColor blueColor];

    
    
    CustomAlertView *VC = [[CustomAlertView alloc] init];
    [VC showCustomView:defaultVC InView:self.view];
//    [VC showInView:self.view dely:3];
    
    
    __weak typeof(self) WeakSelf = self;
    
    defaultVC.handleBlock = ^(NSInteger index) {
        [VC hidden];
        
    };

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
