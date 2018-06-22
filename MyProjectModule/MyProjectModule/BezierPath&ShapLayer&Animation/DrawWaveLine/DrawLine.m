//
//  DrawLine.m
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/6/22.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import "DrawLine.h"
#import "POPNumberAnimation.h"
#import "POP.h"
@interface DrawLine()<POPNumberAnimationDelegate>
@property (nonatomic, strong) POPNumberAnimation *numberAnimation;
@property (nonatomic, strong) UILabel            *label;
@property(nonatomic, strong) CAShapeLayer *circleLayer;
@property(nonatomic, strong) CAShapeLayer *circleBGLayer;
@end
@implementation DrawLine
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addCircleLayer:frame];

    }
    return self;
}


- (void)addCircleLayer:(CGRect)frame{

    self.circleLayer = [CAShapeLayer layer];
    self.circleBGLayer = [CAShapeLayer layer];
    self.label               = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.text = @"0%";

    self.numberAnimation          = [[POPNumberAnimation alloc] init];
    self.numberAnimation.delegate = self;
    [self.numberAnimation stopAnimation];
    


}

-(void)layoutSubviews{
    [self finishConfigLine];
}

-(void)finishConfigLine{
    UIBezierPath * path = [UIBezierPath bezierPath];
    path.lineWidth = 4;
    CGFloat radius = CGRectGetWidth(self.bounds);
    CGRect rect = CGRectMake(0, 0, radius, radius);
    self.label.textColor = _numberColor ?: [UIColor blackColor];
    self.label.font = [UIFont systemFontOfSize:_numberFont?:8];

    self.circleLayer.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 0, 0)
                                                       cornerRadius:radius].CGPath;
    self.circleBGLayer.path = [UIBezierPath bezierPathWithRoundedRect:rect
                                                         cornerRadius:radius].CGPath;
    
    self.circleLayer.strokeColor = _lineForegroundColor.CGColor ?:[UIColor redColor].CGColor;
    self.circleLayer.fillColor = nil;
    self.circleLayer.lineWidth= _lineWidht?:3;
    self.circleLayer.lineCap = kCALineCapRound;
    self.circleLayer.lineJoin = kCALineJoinRound;
    
    self.circleBGLayer.strokeColor = _lineBackgroundColor.CGColor ?: [UIColor blackColor].CGColor;
    self.circleBGLayer.fillColor = nil;
    self.circleBGLayer.lineWidth= _lineWidht?:3;
    self.circleBGLayer.lineCap = kCALineCapRound;
    self.circleBGLayer.lineJoin = kCALineJoinRound;
    
    
    [self addSubview:self.label];
    [self.layer addSublayer:self.circleBGLayer];
    [self.layer addSublayer:self.circleLayer];

}



#pragma mark - pop Delegate
- (void)POPNumberAnimation:(POPNumberAnimation *)numberAnimation currentValue:(CGFloat)currentValue {
        [self textString:currentValue];
}

-(void)textString:(CGFloat )currentValue{
    NSString *numberString = [NSString stringWithFormat:@"%.0f%@", currentValue,@"%"];
    self.label.text = numberString;
}

- (void)setStrokeEnd:(CGFloat)strokeEnd AndNumberValue:(CGFloat )numberValue animated:(BOOL)animated
{

// numberAnimation
    self.numberAnimation.fromValue      = 0.0f;
    self.numberAnimation.toValue        = numberValue;
    self.numberAnimation.duration       = _duration && animated ?:0.0f;
    self.numberAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.69 :0.11 :0.32 :0.88];
    [self.numberAnimation saveValues];
    animated ? [self.numberAnimation startAnimation]: [self textString:numberValue];
//  ShapeLayerAnimation
    POPBasicAnimation *strokeAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPShapeLayerStrokeEnd];
    strokeAnimation.fromValue = @(0.0f);
    strokeAnimation.toValue = @(strokeEnd);
    strokeAnimation.duration = _duration && animated?:0.0f;
    strokeAnimation.removedOnCompletion = YES;
    [self.circleLayer pop_addAnimation:strokeAnimation forKey:@"layerStrokeAnimation"];

}
-(void)dealloc{
    [self pop_removeAllAnimations];
}
@end
