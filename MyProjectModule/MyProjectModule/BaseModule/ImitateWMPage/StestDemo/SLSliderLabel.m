//
//  SLSliderLabel.m
//  SLSliderControl
//
//  Created by iforvert on 2017/11/29.
//  Copyright © 2017年 iforvert. All rights reserved.
//

#import "SLSliderLabel.h"

@implementation SLSliderLabel

+ (instancetype)sliderLabelWithTitle:(NSString *)title
{
    SLSliderLabel *label = [[self alloc] init];
    label.text = title;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:14];
    [label sizeToFit];
    label.userInteractionEnabled = YES;
    return label;
}

- (CGFloat)textWidth
{
    return [self.text sizeWithAttributes:@{NSFontAttributeName:self.font}].width + 8; 
}

- (void)setScale:(CGFloat)scale
{
    _scale = scale;
    self.textColor = [UIColor colorWithRed:_scale*233/255.f green:_scale*48/255.f blue:_scale * 78/255.f alpha:1];
}

@end
