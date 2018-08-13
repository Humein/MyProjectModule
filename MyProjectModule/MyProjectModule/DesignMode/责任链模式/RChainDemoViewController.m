//
//  RChainDemoViewController.m
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/7/17.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import "RChainDemoViewController.h"
#import "HTTopControlView.h"
#import "HTBottomControlView.h"
#import "HTMiddleControlView.h"
@interface RChainDemoViewController ()

@end

@implementation RChainDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
#warning ---TODO 通 链表的方式 将各个控制层 绑定起来
    
    HTTopControlView *top = [[HTTopControlView alloc] init];
    HTBottomControlView *bot = [[HTBottomControlView alloc] init];
    HTMiddleControlView *mid = [[HTMiddleControlView alloc] init];
    bot.superior = mid;
    mid.superior = top;
//    NSArray *responseEvent = @[@"0",@"1",@"3"];
//    for (NSString *string in responseEvent) {
//        [bot responseEvent:[string integerValue] playItem:nil];
//    }
    
     [bot responseEvent:1 playItem:nil];

    
    
    
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
