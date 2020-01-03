//
//  UIImage+Transform.m
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/7/25.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import "UIImage+Transform.h"
#import "UIImage+BaseFilter.h"

@implementation UIImage (Transform)
- (UIImage *) imageWithTransform:(CGAffineTransform)transform
{
    CGContextRef context = [self beginContext];
    
    // setup transformation
    CGContextConcatCTM(context, transform);
    
    // Draw the original image to the context
    UIImage *imageOut = [self getImageFromCurrentImageContext];
    
    [self endContext];
    
    return imageOut;
}
@end
