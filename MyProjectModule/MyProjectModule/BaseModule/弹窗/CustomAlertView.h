//
//  CustomAlertView.h
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/6/25.
//  Copyright © 2018年 xinxin. All rights reserved.
//

//block 类型使用
#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    DefaultTransfer,
    TopTransferDown,
    DownTransferTop,
    ZoomTransfer
} POPAnimation;

// 无返回值 有参数 非匿名 block
typedef void(^ClickButtonBlock)(POPAnimation buttonType, UIButton * clickButton);


@interface CustomAlertView : UIView

//显示方式
@property (nonatomic,assign) POPAnimation transferType;

//显示在window上的

- (void)show;

//显示在view中
- (void)showInView:(UIView*)view;


-(void)showInView:(UIView *)view dely:(NSTimeInterval )time;

//隐藏
-(void)hidden;

// 自定义
- (void)showCustomView:(UIView *)customView InView:(UIView*)view;


//无返回值 有参数 匿名  block （1-异步回调  2- 无需实例对象 配置对象的参数）

-(void)showCustomView:(void(^)(UIView *customView))config completionBlock:(void (^)(NSInteger index))block;


@property (nonatomic,copy) ClickButtonBlock clickBlock;

@end
