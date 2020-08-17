//
//  SimplePopUpHelper.m
//  MyProjectModule
//
//  Created by zhangxinxin on 2020/8/10.
//  Copyright © 2020 xinxin. All rights reserved.
//

#import "SimplePopUpHelper.h"

@implementation SimplePopUpHelper
-(void)dealloc{
    NSLog(@"%@======销毁",NSStringFromClass(self.class));
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    [self initView];
    return self;
}

#pragma mark - PrivateM
-(void)initView{
    // XXTODO 模版
}
#pragma mark - PublicM
- (void)showInView:(UIView *)customView{
    [self showCustomView:customView InView:[UIApplication sharedApplication].keyWindow];
}

- (void)showCustomView:(UIView *)customView InView:(UIView*)view{
    self.frame= view.bounds;
    [self addSubview:customView];
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    // XXTODO 动画
    [customView setFrame:CGRectMake(self.FromPoint.x,self.FromPoint.y, customView.frame.size.width, customView.frame.size.height)];
    [self removeFromSuperview];
    [view addSubview:self];
}

- (void)hidden{
    self.popUpCallBack ? self.popUpCallBack() : nil;
    for (CALayer *layer in self.layer.sublayers) {
        [layer removeAllAnimations];
    }
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    [self removeFromSuperview];
}

//点击事件
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    if([NSStringFromClass([touch.view class]) isEqualToString:NSStringFromClass([self class])]){
        [self hidden];
    }
}

#pragma mark - Set/Get
- (CGFloat)backgroundGalpha{
    if (_backgroundGalpha != 0.2) {
        return _backgroundGalpha;
    }else{
        return 0.2;
    }
}

@end
