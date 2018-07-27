//
//  TablePopDemoViewController.m
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/7/27.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import "TablePopDemoViewController.h"
#import "DecoratorAView.h"
@interface TablePopDemoViewController ()

@end

@implementation TablePopDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    PopTableView *popVC = [[PopTableView alloc]initWithFrame:CGRectMake(0, 100, 200, 400) dataSource:@[@[@"1"],@[@"2"]] withBGView:@""];
    DecoratorAView *alertVC = [[DecoratorAView alloc]initWithChickenBurger:popVC];
    
    [alertVC cellClicks:nil];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
