//
//  UIImage+BaseFilter.h
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/7/25.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 UIImage(BaseFilter)中的方法定义，用户绘制图像，相当于装饰者抽象类，而UIImage则是被装饰的组件:
 */
@interface UIImage (BaseFilter)
- (CGContextRef) beginContext;
- (UIImage *) getImageFromCurrentImageContext;
- (void) endContext;
@end
