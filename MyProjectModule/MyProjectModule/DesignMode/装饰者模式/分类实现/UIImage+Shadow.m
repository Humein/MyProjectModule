//
//  UIImage+Shadow.m
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/7/25.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import "UIImage+Shadow.h"
#import "UIImage+BaseFilter.h"
@implementation UIImage (Shadow)
- (UIImage *) imageWithDropShadow
{
    CGContextRef context = [self beginContext];
    
    // set up shadow
    CGSize offset = CGSizeMake (-25,  15);
    CGContextSetShadow(context, offset, 20.0);
    
    // Draw the original image to the context
    UIImage * imageOut = [self getImageFromCurrentImageContext];
    
    [self endContext];
    
    return imageOut;
}
@end
