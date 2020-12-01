//
//  UIImage+DrawCornerTools.m
//  MyProjectModule
//
//  Created by zhangxinxin on 2020/11/27.
//  Copyright © 2020 xinxin. All rights reserved.
//

#import "UIImage+DrawCornerTools.h"

@implementation UIImage (DrawCornerTools)
- (instancetype)roundCornerImageWithCorner:(UIRectCorner)corner radius:(CGFloat)radius{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(context, 1, -1);
    CGContextTranslateCTM(context, 0, -self.size.height);
    CGRect rect = CGRectMake(0, 0, self.size.width,self.size.height);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corner cornerRadii:CGSizeMake(radius, radius)];
    [path closePath];
    CGContextSaveGState(context) ;
    [path addClip];
    CGContextDrawImage (context, rect, self.CGImage) ;
    CGContextRestoreGState (context) ;
    /*
     避免使用drawInRect，内存过大且不会自动释放，就算用autorelease也不行  解决方法：将UIImage对象本地缓存成图片，然后正常释放对象 UIGraphicsEndImageContext();  接着传递出去缓存Ullmage的路径进行读取。这样内存释放问题就处理了，多次调用这个方法也不会出现内存无法回收的问题
     */
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/**
 根据贝塞尔画image

 @param backColor 背景颜色
 @param radiiSize 上左下右的圆角
 @return image
 */
+ (UIImage *)xesApp_genSendBubbleImageWithColor:(UIColor *)backColor andRadii:(CGSize)radiiSize{
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 36)];
    v.backgroundColor = backColor;
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:v.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerTopLeft cornerRadii:radiiSize];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = v.bounds;
    maskLayer.path = maskPath.CGPath;
    v.layer.mask = maskLayer;
    
    UIGraphicsBeginImageContext(v.bounds.size);
    [v.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
