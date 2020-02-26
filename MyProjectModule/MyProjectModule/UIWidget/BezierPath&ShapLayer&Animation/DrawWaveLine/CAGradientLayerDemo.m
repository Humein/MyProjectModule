//
//  CAGradientLayer.m
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/7/5.
//  Copyright © 2018年 xinxin. All rights reserved.
//
#define VRadians(x) (M_PI*(x)/180.0) //把角度转换成PI的方式
#define kLineW 8 //弧线的宽度
#define labelW self.frame.size.width - 200 * 2
#define labelH self.frame.size.height - 44 * 2
#define kViewW self.frame.size.width
#define kViewH self.frame.size.height
#import "CAGradientLayerDemo.h"

@interface CAGradientLayerDemo(){
    UILabel *label;

}
@property (nonatomic, strong)CAShapeLayer *shapeLayer;

@end

@implementation CAGradientLayerDemo
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, labelW, labelH)];
        label.center = self.center;
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor blueColor];
        label.font = [UIFont systemFontOfSize:20];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    
    //设置路径
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width / 2.0, self.frame.size.height / 2.0) radius:self.frame.size.width / 2.0 - labelW startAngle:VRadians(-210) endAngle:VRadians(30) clockwise:YES];
    path.lineWidth = 200;
    path.lineJoinStyle = kCGLineJoinRound;
    path.lineCapStyle = kCGLineCapRound;
    [[UIColor colorWithWhite:0.667 alpha:0.343] set];
    [path stroke];
    
    self.shapeLayer = [CAShapeLayer layer];
    self.shapeLayer.frame = self.bounds;
    
    self.shapeLayer.fillColor = [UIColor clearColor].CGColor;
    self.shapeLayer.strokeColor = [UIColor redColor].CGColor;
    
    self.shapeLayer.lineJoin = kCALineCapRound;
    self.shapeLayer.lineCap = kCALineCapRound;
    self.shapeLayer.lineWidth = labelW;
    self.shapeLayer.path = path.CGPath;
    
    CALayer *gradientLayer = [CALayer layer];
    CAGradientLayer *gradientLayer1 =  [CAGradientLayer layer];
    gradientLayer1.frame = CGRectMake(0, 0, self.frame.size.width/2, self.frame.size.height);
    gradientLayer1.colors = @[
                              (id)[UIColor redColor].CGColor,
                              (id)[UIColor greenColor].CGColor,
                              ];
    
    [gradientLayer1 setStartPoint:CGPointMake(0.5, 1)];
    [gradientLayer1 setEndPoint:CGPointMake(0.5, 0)];
    [gradientLayer addSublayer:gradientLayer1];
    
    CAGradientLayer *gradientLayer2 =  [CAGradientLayer layer];
    gradientLayer2.frame = CGRectMake(self.frame.size.width/2, 0, self.frame.size.width/2, self.frame.size.height);
    gradientLayer2.colors = @[
                              (id)[UIColor greenColor].CGColor,
                              (id)[UIColor redColor].CGColor
                              ];
    [gradientLayer2 setStartPoint:CGPointMake(0.5, 0)];
    [gradientLayer2 setEndPoint:CGPointMake(0.5, 1)];
    [gradientLayer addSublayer:gradientLayer2];
    [self.layer addSublayer:gradientLayer];
    
    gradientLayer.mask = self.shapeLayer;
    
    self.shapeLayer.strokeEnd = 0;
    
    
}
- (void)setPercent:(NSInteger)percent animated:(BOOL)animated {
    [CATransaction begin];
    [CATransaction setDisableActions:!animated];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [CATransaction setAnimationDuration:0.1];
    self.shapeLayer.strokeEnd = percent/100.0;
    [CATransaction commit];
    
    self.percent = percent;
}

- (void)setPercent:(NSInteger)percent {
    
    NSString *progress = [NSString stringWithFormat:@"%ld%%", percent];
    label.text = progress;
}


@end
