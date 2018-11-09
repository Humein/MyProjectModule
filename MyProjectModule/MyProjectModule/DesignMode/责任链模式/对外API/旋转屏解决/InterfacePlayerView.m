//
//  InterfacePlayerView.m
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2018/11/4.
//  Copyright © 2018 xinxin. All rights reserved.
//

#import "InterfacePlayerView.h"
#import "AbstractPlayerHelperManager.h"//播放层
#import "ResponderControlView.h"//控制层

@interface InterfacePlayerView()

@property (nonatomic, strong) AbstractPlayerHelperManager *videoPlayer;

@property (nonatomic, strong) ResponderControlView *controlView;

@end


@implementation InterfacePlayerView


#pragma mark- 加载试图

- (id)initWithFrame:(CGRect)frame
{
    if (self= [super initWithFrame:frame]) {
        
        [self setupContentView];

    }
    return self;
}

-(void)setupContentView{
    
    
    
    [self addSubview:self.controlView];
    
    //设置链表
    self.nextView(self.controlView);
    
}



#pragma mark ---- 事件联动

- (void)attachPlayItem:(id )playItem
{
    
    [super attachPlayItem:playItem];
    
    [self logAllNextNode];
    
}

- (void)responseEvent:(NSInteger)eventType playItem:(id)playItem{
    
    self.nextNodeView ? [self.nextNodeView responseEvent:eventType playItem:playItem] : nil;
    
//  可以根据处理当前view
    

}

#pragma mark ---- 对外留的接口

- (void)exchangePlayItem:(id )playItem
{
    //做切换之后，只需要把播放器做一次替换，之后再重新关联一下数据
    [self requestEvent:HTVideoPlayerExchangeItemEvent playItem:playItem];
    
}



- (void)viewWillAppear
{

    
}


- (void)viewWilDisappear
{

    [self requestEvent:HTVideoPauseEvent playItem:nil];
    
}


#pragma mark --- lazyload

- (ResponderControlView *)controlView
{
    if (_controlView == nil) {
        _controlView= [[ResponderControlView alloc] initWithFrame:self.bounds];
    }
    return _controlView;
}


@end
