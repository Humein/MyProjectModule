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

    _cycleSize.width = _cycleSize.width?:50;
    _cycleSize.height = _cycleSize.height?:50;
    CGRect rect = CGRectMake(0, 0, _cycleSize.width, _cycleSize.height);
    self.label.textColor = _numberColor ?: [UIColor blackColor];
    self.label.font = [UIFont systemFontOfSize:_numberFont?:8];

// UIBezierPath
    if (!_customizePath) {
        _customizePath =  [UIBezierPath bezierPath];
        _customizePath.lineWidth = 10;
        
        if (1) {
            _customizePath = [UIBezierPath bezierPathWithRoundedRect:rect
                                                        cornerRadius:_cycleSize.width];
            _customizePath = [UIBezierPath bezierPathWithRoundedRect:rect
                                                        cornerRadius:_cycleSize.width];
            [self.label setFrame:rect];
            [self addSubview:self.label];
            
        }else{
            [_customizePath moveToPoint:CGPointMake(0, 0)];
            [_customizePath addLineToPoint:CGPointMake(_cycleSize.width, 0)];
            [self.label setFrame:rect];
            [self addSubview:self.label];
        }
    }

    self.circleLayer.path = _customizePath.CGPath;
    self.circleBGLayer.path = _customizePath.CGPath;
    
    
// CAShapeLayer
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
    

    [self.layer addSublayer:self.circleBGLayer];
    [self.layer addSublayer:self.circleLayer];
    self.circleLayer.hidden = YES;
}



#pragma mark - pop Delegate
- (void)POPNumberAnimation:(POPNumberAnimation *)numberAnimation currentValue:(CGFloat)currentValue {
        [self textString:currentValue];
}

-(void)textString:(CGFloat )currentValue{
    NSString *numberString = [NSString stringWithFormat:@"%.0f%@", currentValue,@"%"];
    self.label.text = numberString;
//    _label.textColor = [self numColorWithValue:currentValue / 100.f];

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
    self.circleLayer.hidden = NO;
    POPBasicAnimation *strokeAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPShapeLayerStrokeEnd];
    strokeAnimation.fromValue = @(0.0f);
    strokeAnimation.toValue = @(strokeEnd);
    strokeAnimation.duration = _duration && animated?:0.0f;
    strokeAnimation.removedOnCompletion = YES;
    [self.circleLayer pop_addAnimation:strokeAnimation forKey:@"layerStrokeAnimation"];

}
- (UIColor *)numColorWithValue:(CGFloat)value {
    
    return [UIColor colorWithRed:value green:0 blue:0 alpha:1.f];
}
-(void)dealloc{
    [self pop_removeAllAnimations];
}
@end
