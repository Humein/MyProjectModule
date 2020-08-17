//
//  CustomAlertView.h
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/6/25.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AbstractAlertView.h"
typedef enum : NSUInteger {
    DefaultTransfer,
    TopTransferDown,
    DownTransferTop,
    ZoomTransfer
} XXPOPAnimation;

typedef void(^CustomBackView)(void);

@interface CustomAlertManagerView : UIView

@property (nonatomic,assign)CGPoint FromPoint; //从哪里开始展示

//显示方式
@property (nonatomic,assign) XXPOPAnimation transferType;

//显示在window上的
- (void)show;

//显示在view中
- (void)showInView:(UIView*)view;

//延迟
-(void)showInView:(UIView *)view dely:(NSTimeInterval )time;

//隐藏
-(void)hidden;

// 自定义
- (void)showCustomView:(UIView *)customView InView:(UIView*)view;

@property (nonatomic,copy) CustomBackView customCallBack;


//

/**
  需要继承 AbstractAlertView

 @param customView <#customView description#>
 @param view <#view description#>
 @param block <#block description#>
 */
-(void)showCustomViews:(AbstractAlertView *)customView InView:(UIView*)view completionBlock:(void (^)(NSInteger index))block;

/**
 传入自定义View

 @param config 实例化的view
 @param block viewBlock
 */
-(void)showCustomView:(void(^)(AbstractAlertView *customView))config completionBlock:(void (^)(NSInteger index))block;



@end
