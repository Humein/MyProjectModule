//
//  DownLoadViewController.m
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/7/10.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import "DownLoadViewController.h"
#import "ZTKDownHelperManager.h"
#import "ZTKZTKBJDownItem.h"
#import "UIButton+ButtonBlockCategory.h"

@interface DownLoadViewController ()

@end

@implementation DownLoadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    __weak typeof (self) weakSelf = self;
    
    UIButton *button = [UIButton createButtonWithFrame:CGRectMake(20, 100, 44, 44) title:@"开始" titleColor:[UIColor redColor] bgImageName:@"" actionBlock:^(UIButton *button) {
        
        [weakSelf btn1];
        
    }];
    [self.view addSubview:button];
    
    
    UIButton *button1 = [UIButton createButtonWithFrame:CGRectMake(64, 100, 44, 44) title:@"停止" titleColor:[UIColor redColor] bgImageName:@"" actionBlock:^(UIButton *button) {
        
        [weakSelf btn3];
        
    }];
    [self.view addSubview:button1];
    
    
    UIButton *btn = [UIButton button];
    btn.frame = CGRectMake(20, 300, 200, 200);
    [btn setTitle:@"1234" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
    btn.actionBlock = ^(UIButton *button) {
        //        NSString *str = [button titleForState:UIControlStateNormal];
        //        NSLog(@"%@",str);
        [weakSelf btn2];
    };
    [self.view addSubview:btn];
}

-(void)btn1{

    ZTKZTKBJDownItem *item = [ZTKZTKBJDownItem new];
    item.itemType = 1;
    [[ZTKDownHelperManager sharedDownVideoManager] pause];
    [[ZTKDownHelperManager sharedDownVideoManager] downLoadDownItem:item];
}

-(void)btn3{
    [[ZTKDownHelperManager sharedDownVideoManager] pause];
}

-(void)btn2{
    ZTKZTKBJDownItem *item = [ZTKZTKBJDownItem new];
    item.itemType = 2;
    [[ZTKDownHelperManager sharedDownVideoManager] pause];
    [[ZTKDownHelperManager sharedDownVideoManager] downLoadDownItem:item];
}




@end
