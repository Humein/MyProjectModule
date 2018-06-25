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
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    [self initView];
    
    return self;
}

-(void)initView{
    _alertView = [UIView new];
    _alertView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_alertView];
    [_alertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(20);
        make.right.equalTo(self).offset(-20);
        make.height.equalTo(@200);
    }];
    _alertBtn = [UIButton new];
    _alertBtn.backgroundColor = [UIColor redColor];
    [_alertBtn addTarget:self action:@selector(popTabel) forControlEvents:UIControlEventTouchDown];
    [_alertView addSubview:_alertBtn];
    [_alertBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.alertView);
        make.left.equalTo(self.alertView).offset(20);
        make.right.equalTo(self.alertView).offset(-20);
        make.height.equalTo(@100);
    }];
    
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

- (void)hidden
{
    [self removeFromSuperview];
}

//点击事件
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    背景 alertView button  各自的响应处理
    UITouch *touch = [touches anyObject];
    NSLog(@"touch>>>>>>>%@",NSStringFromClass([touch.view class]));
    if([NSStringFromClass([touch.view class]) isEqualToString:@"CustomAlertView"]){
        [self hidden];
    }
}


@end
