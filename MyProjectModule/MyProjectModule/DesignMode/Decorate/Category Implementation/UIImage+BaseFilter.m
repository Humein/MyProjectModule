//
//  UIImage+BaseFilter.m
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/7/25.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import "UIImage+BaseFilter.h"

@implementation UIImage (BaseFilter)
- (CGContextRef) beginContext
{
    
    CGSize size = [self size];
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    return context;
}

- (UIImage *) getImageFromCurrentImageContext
{
    [self drawAtPoint:CGPointZero];
    
    // Retrieve the UIImage from the current context
    UIImage *imageOut = UIGraphicsGetImageFromCurrentImageContext();
    
    return imageOut;
}

- (void) endContext
{
    UIGraphicsEndImageContext();
}
@end
