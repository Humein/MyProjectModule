//
//  CustomAlertView.m
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/6/25.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import "CustomAlertView.h"
#import <Masonry/Masonry.h>
@interface CustomAlertView(){
    UIButton *_alertBtn;
}
@property(nonatomic,strong) UIView *alertView;
@end
@implementation CustomAlertView
-(void)dealloc{
    NSLog(@"%@======销毁",NSStringFromClass(self.class));
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    [self initView];
    
    return self;
}

-(void)initView{
    
    //     TODO 默认
    //    _alertView = [UIButton new];
    //    _alertView.backgroundColor = [UIColor grayColor];
    //    [self addSubview:_alertView];
    //
    ////
    //    [_alertView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.centerY.equalTo(self);
    //        make.left.equalTo(self).offset(20);
    //        make.right.equalTo(self).offset(-20);
    //        make.height.equalTo(@347);
    //    }];
    //
    
}

#pragma mark --PrivateM
-(void)popTabel{
    
    [self hidden];
}

#pragma mark --- PublicMethod
- (void)show
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [self showInView:keyWindow];
}
- (void)showInView:(UIView*)view
{
    self.frame= view.bounds;
    [view addSubview:self];
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    
}

-(void)showInView:(UIView *)view dely:(NSTimeInterval )time{
    self.frame= view.bounds;
    [view addSubview:self];
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    NSTimer *timer = [NSTimer timerWithTimeInterval:(time) target:self selector:@selector(hidden) userInfo:nil repeats:NO];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}


- (void)showCustomView:(UIView *)customView InView:(UIView*)view{
    self.frame= view.bounds;
    [self addSubview:customView];
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.0];

    /*
     上-下
    [customView setFrame:CGRectMake((view.frame.size.width-customView.frame.size.width) / 2, -customView.frame.size.height, customView.frame.size.width, customView.frame.size.height)];
    
    [UIView animateWithDuration:1.0 animations:^{
        [customView setFrame:CGRectMake((view.frame.size.width-customView.frame.size.width) / 2, (view.frame.size.height-customView.frame.size.height) / 2, customView.frame.size.width, customView.frame.size.height)];

    }];
    */
    
//    下 - 上
    [customView setFrame:CGRectMake((view.frame.size.width-customView.frame.size.width) / 2, view.frame.size.height + customView.frame.size.height, customView.frame.size.width, customView.frame.size.height)];

    [UIView animateWithDuration:0.4 animations:^{
        [customView setFrame:CGRectMake((view.frame.size.width-customView.frame.size.width) / 2, (view.frame.size.height-customView.frame.size.height)-1, customView.frame.size.width, customView.frame.size.height)];
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];

    }];

    

    
    [view addSubview:self];
}


- (void)hidden
{
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    [self removeFromSuperview];
}

//点击事件
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //    背景 alertView button  各自的响应处理
    UITouch *touch = [touches anyObject];
    NSLog(@"touch>>>>>>>%@",NSStringFromClass([touch.view class]));
    if([NSStringFromClass([touch.view class]) isEqualToString:NSStringFromClass([self class])]){
        [self hidden];
    }
}

@end
