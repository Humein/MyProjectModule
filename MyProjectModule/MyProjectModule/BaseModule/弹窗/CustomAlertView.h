//
//  CustomAlertView.h
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/6/25.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomAlertView : UIView

//显示在window上的

- (void)show;

//显示在view中
- (void)showInView:(UIView*)view;

-(void)showInView:(UIView *)view dely:(NSTimeInterval )time;

//隐藏
-(void)hidden;

// 自定义
- (void)showCustomView:(UIView *)customView InView:(UIView*)view;

@end
