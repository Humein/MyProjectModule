//
//  ResponderPlayerView.m
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2018/11/9.
//  Copyright © 2018 xinxin. All rights reserved.
//

#import "ResponderPlayerView.h"
#import "AbstractPlayerHelperManager.h"

@interface ResponderPlayerView()

@property (nonatomic, strong) AbstractPlayerHelperManager *videoPlayer;

@end

@implementation ResponderPlayerView

- (id)initWithFrame:(CGRect)frame
{
    if (self= [super initWithFrame:frame]) {
        
//       视频 链条绑定
        [self addSubview:self.videoPlayer];
        
         self.nextView(self.videoPlayer);
    }
    return self;
}





// 播放器事件入口
- (void)responseEvent:(NSInteger)eventType playItem:(id )playItem{
    
    NSLog(@"%@======%ld",NSStringFromClass([self class]),(long)eventType);
    
    [super responseEvent:eventType playItem:playItem];

    switch (eventType) {
        case HTVideoPlayEvent:


            break;
            
        default:
            break;
    }
    
    
    
}





-(AbstractPlayerHelperManager *)videoPlayer{
    
    if (_videoPlayer == nil) {
        
        _videoPlayer = [[AbstractPlayerHelperManager alloc] initWithFrame:self.bounds];
        
    }
    
    return _videoPlayer;
}

@end
