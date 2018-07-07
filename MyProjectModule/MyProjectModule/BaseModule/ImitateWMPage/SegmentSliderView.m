//
//  SegmentSliderView.m
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/7/7.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import "SegmentSliderView.h"

@implementation SegmentSliderView

+ (instancetype)sliderLabelWithTitle:(NSString *)title
{
    SegmentSliderView *label = [[self alloc] init];
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
