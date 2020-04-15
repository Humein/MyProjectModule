//
//  PlayerViewController.m
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/7/10.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import "PlayerViewController.h"
#import "UIButton+ButtonBlockCategory.h"
#import "AbstractPlayerHelperManager.h"
#import "APPPayTool.h"
#import "Masonry.h"
#import "InterfacePlayerView.h"
#import "BKDeviceOrientation.h"
#define ScreenSize [UIScreen mainScreen].bounds.size
@interface PlayerViewController (){
    AbstractPlayerHelperManager *_player;

    
}
@property (nonatomic,strong) InterfacePlayerView *videoPlayer;

@end

@implementation PlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    __weak typeof (self) weakSelf = self;
//    [self initPlayerWithType:EPlayerType_ZSPlayer];

    UIButton *P1 = [UIButton createButtonWithFrame:CGRectMake(20, 150, 44, 44) title:@"ZS" titleColor:[UIColor blueColor] bgImageName:@"" actionBlock:^(UIButton *button) {
        
//        [weakSelf initPlayerWithType:EPlayerType_ZSPlayer];
    }];
    [self.view addSubview:P1];
    
    UIButton *P2 = [UIButton createButtonWithFrame:CGRectMake(64, 150, 44, 44) title:@"BJ" titleColor:[UIColor blueColor] bgImageName:@"" actionBlock:^(UIButton *button) {
        
//        [weakSelf initPlayerWithType:EPlayerType_BJPlayer];

    }];
    [self.view addSubview:P2];
    
    UIButton *start = [UIButton createButtonWithFrame:CGRectMake(20, 100, 44, 44) title:@"开始" titleColor:[UIColor blueColor] bgImageName:@"" actionBlock:^(UIButton *button) {
        [weakSelf play];
        
    }];
    [self.view addSubview:start];
    
    UIButton *pause = [UIButton createButtonWithFrame:CGRectMake(64, 100, 44, 44) title:@"暂停" titleColor:[UIColor redColor] bgImageName:@"" actionBlock:^(UIButton *button) {
        
        [weakSelf pause];
    }];
    [self.view addSubview:pause];
    
    UIButton *stop = [UIButton createButtonWithFrame:CGRectMake(104, 100, 44, 44) title:@"停止" titleColor:[UIColor brownColor] bgImageName:@"" actionBlock:^(UIButton *button) {
        
        [weakSelf stop];
    }];
    [self.view addSubview:stop];
    
}

// 初始化播放器




#pragma mark - 旋转屏
// 是否支持旋转
- (BOOL)shouldAutorotate
{
    BOOL isFull = YES;
    return isFull;
}
// 支持方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscapeRight;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}



-(void)play{
    // 方式1 控制整个控制器; 前题是 项目支持横竖屏
    CGFloat duration = [UIApplication sharedApplication].statusBarOrientationAnimationDuration;
    [UIView animateWithDuration:duration animations:^{
        [[BKDeviceOrientation shareInstance] screenExChangeforOrientation:UIInterfaceOrientationLandscapeRight];
    }];
}

-(void)pause{
    CGFloat duration = [UIApplication sharedApplication].statusBarOrientationAnimationDuration;
    [UIView animateWithDuration:duration animations:^{
        [[BKDeviceOrientation shareInstance] screenExChangeforOrientation:UIInterfaceOrientationPortrait];
    }];
}

-(void)stop{
//    NSLog(@"%@",_player ? [_player abs_stop] : @"空"  );

}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [[APPPayTool sharedPayManager] payType:PayType_AliPay orderId:@"1" completionBlock:^(PayStatus payStatus, PayType type) {
        
        if (payStatus == PayStatus_Success) {
            
        
        }
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
