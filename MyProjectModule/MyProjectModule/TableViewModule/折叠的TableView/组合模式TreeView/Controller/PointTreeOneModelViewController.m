//
//  PointTreeOneModelViewController.m
//  MyProjectModule
//
//  Created by 鑫鑫 on 2019/1/2.
//  Copyright © 2019 xinxin. All rights reserved.
//

#import "PointTreeOneModelViewController.h"

@interface PointTreeOneModelViewController ()

@property (nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation PointTreeOneModelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

//MARK: - tableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

@end
