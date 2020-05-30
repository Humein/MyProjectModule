//
//  AVViewController.m
//  MyProjectModule
//
//  Created by XinXin on 2020/5/24.
//  Copyright © 2020 xinxin. All rights reserved.
//

#import "AVViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface AVViewController ()
@property (nonatomic,strong) AVPlayer *player;//视频播放
@property (nonatomic,strong) AVPlayerLayer *playerLayer;
@end

@implementation AVViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL *sourceMovieURL = [NSURL URLWithString:@"https://stream7.iqilu.com/10339/upload_transcode/202002/18/20200218114723HDu3hhxqIT.mp4"];
    AVAsset *movieAsset    = [AVURLAsset URLAssetWithURL:sourceMovieURL options:nil];
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:movieAsset];
    _player = [AVPlayer playerWithPlayerItem:playerItem];
    _playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
    _playerLayer.frame = CGRectMake(180, 40, 100, 80);
    _playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    _playerLayer.backgroundColor  = [UIColor blackColor].CGColor;
    [self.view.layer addSublayer:_playerLayer];
    [_player play];

    [self testUrl];
    
    
    // Do any additional setup after loading the view.
}

- (void)testUrl{
NSString *path = @"https://www.baidu.com/";
NSString *path2 = @"http://fanyi.baidu.com/translate?query=#auto/zh/";
NSString *path3 = @"http://fanyi.baidu.com/translate?query=#zh/en/测试";

NSURL *url = [NSURL URLWithString:path];

NSURL *url2 = [NSURL URLWithString:path2];

NSURL *url3 = [NSURL URLWithString:path3];

NSLog(@"%@", url);
 
NSLog(@"%@", url2);

NSLog(@"%@", url3);
    
}

-(void)dealloc {
    
}
@end
