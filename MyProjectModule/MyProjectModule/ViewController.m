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



#import "ViewController.h"
#import "PopTableView.h"

@interface ViewController ()<MatchesSwitchMdoelCellDelegate>

@end

@implementation ViewController

#pragma mark --- lifeCycle
-(void)viewDidLoad{
    [super viewDidLoad];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self popOver];
}

#pragma mark ---NetWorkRequest

#pragma mark ----Delegate
#pragma mark ----popOverDelegate

-(void)cellClick:(MatchesSwitchMdoel *)viewModel{
    
    NSString *stTmp = [NSString stringWithFormat:@"%@",viewModel];
    NSInteger state = [stTmp integerValue];
    switch (state) {
        case 1:
            break;
        case 2:
            break;
        case 3:
            break;
                    default:
            break;
    }
    
}
#pragma mark --- PrivateMethod
-(void)popOver{
    NSArray *arr = @[@"colloctionView",@"2",@"3",@"1",@"2",@"3"];
    PopTableView *pooView = [[PopTableView alloc]initWithFrame:CGRectMake(0,100, 258*0.5, arr.count * 30 + 20) dataSource:arr withBGView:@"弹窗"];
    pooView.delegate = self;
    
    [pooView show];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(30 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [pooView dismiss];
    });
}
#pragma mark --- PublicMethod

#pragma mark --- LazyLoad

@end
