//
//  DesignModeViewController.m
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2020/1/15.
//  Copyright © 2020 xinxin. All rights reserved.
//

#import "DesignModeViewController.h"
#import "Produce_Consume.h"
@interface DesignModeViewController ()

@end

@implementation DesignModeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    Produce_Consume *pc = [Produce_Consume new];
    [pc load];
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
