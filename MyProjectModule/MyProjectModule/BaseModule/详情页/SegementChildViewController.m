//
//  SegementChildViewController.m
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/6/21.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import "SegementChildViewController.h"

@interface SegementChildViewController ()

@end

@implementation SegementChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 88, 150, 44)];
    textLabel.text = [NSString stringWithFormat:@"TAG=====%ld",(long)self.categoryId];
    [self.view addSubview:textLabel];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

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
