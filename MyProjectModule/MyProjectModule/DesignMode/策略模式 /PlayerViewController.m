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
#import "FullScreenViewController.h"
#import "Masonry.h"
#import "InterfacePlayerView.h"
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





-(void)play{
    NSLog(@"%@",_player ? [_player abs_play] : @"空"  );
    

//    TODO 旋转屏
    UIViewController* ctrl = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (ctrl.presentedViewController && !ctrl.presentedViewController.isBeingDismissed) {
        ctrl = ctrl.presentedViewController;
    }
    
    
    self.videoPlayer = [InterfacePlayerView new];
    
    self.videoPlayer.backgroundColor = [UIColor redColor];
    
    [self.videoPlayer exchangePlayItem:nil];
    
    FullScreenViewController *vc = [[FullScreenViewController alloc] init];
    [vc.view addSubview:self.videoPlayer];
    [self.videoPlayer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0.f);
    }];
    
    [ctrl presentViewController:vc animated:NO completion:nil];
    
}

-(void)pause{
    NSLog(@"%@",_player ? [_player abs_pause] : @"空"  );

}

-(void)stop{
    NSLog(@"%@",_player ? [_player abs_stop] : @"空"  );

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
