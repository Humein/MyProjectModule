//
//  UIControlFactory.h
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/6/25.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
    统一处理控件属性
 */
@interface UIControlFactory : NSObject
+ (UIView *)view;

+ (UIButton*)button;

+ (UILabel*)lable;

+ (UIImageView*)imageView;

+ (UITextView*)textView;

+ (UITextField*)textField;

+ (UIScrollView*)scrollView;

+ (UIWebView*)webView;

+ (UIPageControl*)pageControl;

+ (UISlider*)slider;

+ (UISwitch*)switchView;
@end
