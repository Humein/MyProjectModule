//
//  DrawLine.h
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/6/22.
//  Copyright © 2018年 xinxin. All rights reserved.
//


// 进度动画

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface DrawLine : UIView

//自定义图形
@property (nonatomic,strong) UIBezierPath * customizePath;
//大小 默认50
@property (nonatomic,assign)CGSize cycleSize;
//进度颜色 默认red
@property (nonatomic,strong) UIColor *lineForegroundColor;
//进度背景 默认black
@property (nonatomic,strong) UIColor *lineBackgroundColor;
//数字颜色 默认black
@property (nonatomic,strong) UIColor *numberColor;
//数字字体 默认8
@property (nonatomic,assign) CGFloat numberFont;
//线宽度 默认3
@property (nonatomic,assign) CGFloat lineWidht;
//动画系数 默认0
@property (nonatomic,assign) NSTimeInterval duration;



/**
 setStrokeEnd

 @param strokeEnd 0~1
 @param numberValue 0~max
 @param animated animated
 */
- (void)setStrokeEnd:(CGFloat)strokeEnd AndNumberValue:(CGFloat )numberValue animated:(BOOL)animated;

@end
