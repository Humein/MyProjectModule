//
//  UIButton+ButtonBlockCategory.h
//  RuntimeAndRunloop
//
//  Created by 鑫鑫 on 2018/4/18.
//  Copyright © 2018年 xinxin. All rights reserved.
//
#import <UIKit/UIKit.h>
typedef void (^ActionBlock)(UIButton *button);
#warning 1-添加属性
@interface UIButton (ButtonBlockCategory)
@property (nonatomic,copy) ActionBlock actionBlock;

/**
 通过block对Button的点击事件进行封装
 
 @param frame frame大小
 @param title 内容
 @param titleColor 内容颜色
 @param bgImgName 背景图片
 @param completion 点击事件
 @return Button
 */
+ (UIButton *)createButtonWithFrame:(CGRect)frame
                              title:(NSString *)title
                         titleColor:(UIColor *)titleColor
                        bgImageName:(NSString *)bgImgName
                        actionBlock:(void(^)(UIButton *sender))completion;


/**
 通过block对Button的点击事件进行封装
 
 @return 返回初始化后的button
 */
+ (UIButton *)button;

@end
