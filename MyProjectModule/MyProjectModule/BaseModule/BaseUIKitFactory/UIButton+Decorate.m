//
//  UIButton+Decorate.m
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/6/25.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import "UIButton+Decorate.h"

@implementation UIButton (Decorate)
//如果在类别里面增加属性
- (UIButton * (^)(CGRect frame))buttonFrame
{
    
    UIButton* (^buttonBlock)(CGRect frame) = ^(CGRect frame) {
        
        self.frame= frame;
        
        return self;
    };
    
    return buttonBlock;
}


- (UIButton* (^)(NSString *text))buttonText
{
    
    UIButton* (^buttonBlock)(NSString *text) = ^(NSString *text) {
        
        
        [self setTitle:text forState:UIControlStateNormal];
        
        return self;
    };
    
    return buttonBlock;
}



- (UIButton * (^)(UIFont *textFont))buttonFont
{
    UIButton* (^buttonBlock)(UIFont *textFont) = ^(UIFont *textFont) {
        
        
        self.titleLabel.font= textFont;
        
        return self;
    };
    
    return buttonBlock;
    
}

- (UIButton * (^)(UIColor *color))buttonBackgroundColor{
    
    UIButton * (^buttonBlock)(UIColor *color) = ^(UIColor *color){
        
        self.backgroundColor = color;
        return self;
    };
    
    return buttonBlock;
}


- (UIButton * (^)(NSString *imageName))buttonBGimage{
    UIButton* (^buttonBlock)(NSString *imageName) = ^(NSString *imageName) {
        
        [self setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        
        return self;
    };
    
    return buttonBlock;
}


- (UIButton * (^)(NSString *normalImageName))normalImageName{
    /** UIButton中调整图片大小，使其缩放
    1. SetImaged方式
        設定imageEdgeInsets可以縮小Image 但不能扩大
              [button setImage:[UIImage imageNamed:@"buttonImage"] forState:UIControlStateNormal];
              button.imageEdgeInsets = UIEdgeInsetsMake(5, 15 - 8, 5, 15 + 8);
                         
        2.  setBackgroundImage 妈的 能用换图片解决就别用代码了。。。 获取正确的图片。然后获取图片的size，最后设置给Button就可以了。
                    
             imageEdgeInsets 和 titleEdgeInsets 分别控制图片和文本的位置
                       
          
     */
    UIButton* (^buttonBlock)(NSString *normalImageName) = ^(NSString *normalImageName) {
        
        [self setImage:[UIImage imageNamed:normalImageName] forState:UIControlStateNormal];
        
        return self;
    };
    
    return buttonBlock;
}

- (UIButton * (^)(NSString *highlightImageName))highlightImageName
{
    UIButton* (^buttonBlock)(NSString *highlightImageName) = ^(NSString *highlightImageName) {
        
        [self setImage:[UIImage imageNamed:highlightImageName] forState:UIControlStateNormal];
        
        return self;
    };
    
    return buttonBlock;
}

- (UIButton * (^)(NSString *selectImageName))selectImageName
{
    UIButton* (^buttonBlock)(NSString *selectImageName) = ^(NSString *selectImageName) {
        
        [self setImage:[UIImage imageNamed:selectImageName] forState:UIControlStateSelected];
        
        return self;
    };
    
    return buttonBlock;
    
}

- (UIButton * (^)(UIColor *normalTitleColor))normalTitleColor
{
    UIButton* (^buttonBlock)(UIColor *normalTitleColor) = ^(UIColor *normalTitleColor) {
        
        [self setTitleColor:normalTitleColor forState:UIControlStateNormal];
        
        return self;
    };
    
    return buttonBlock;
    
}

- (UIButton * (^)(UIColor *selectTitleColor))selectTitleColor{
    
    UIButton* (^buttonBlock)(UIColor *selectTitleColor) = ^(UIColor *selectTitleColor) {
        
        [self setTitleColor:selectTitleColor forState:UIControlStateSelected];
        
        return self;
    };
    
    return buttonBlock;
}



- (UIButton * (^)(id target,SEL sel))targetAction
{
    UIButton* (^buttonBlock)(id target,SEL sel) = ^(id target,SEL sel) {
        
        [self addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
        
        return self;
    };
    
    return buttonBlock;
}



- (UIButton * (^)(NSString *buttonID))buttonAction:(void (^)(UIButton *button))block{
    
    UIButton * (^buttonBlock)(NSString *buttonID) = ^(NSString *buttonID){
        
        block(self);
        
        return self;
    };
    
    return buttonBlock;
}


- (UIButton * (^)(CGFloat radius))buttonCornerRadius{
    
    UIButton * (^buttonBlock)(CGFloat radius) = ^(CGFloat radius){
        
        self.layer.cornerRadius = radius;
        self.clipsToBounds = YES;
        return self;
    };
    return buttonBlock;
}


// 设置圆角边线的颜色
- (UIButton * (^)(UIColor *color))buttonCornerColor{
    
    UIButton * (^buttonBlock)(UIColor *color) = ^(UIColor *color){
        
        self.layer.borderColor = color.CGColor;
        return self;
    };
    return buttonBlock;
    
}

// 设置圆角边线的宽度
- (UIButton * (^)(CGFloat width))buttonCornerWidth{
    
    UIButton * (^buttonBlock)(CGFloat width) = ^(CGFloat width){
        
        self.layer.borderWidth = width;
        return self;
    };
    return buttonBlock;
}


@end
