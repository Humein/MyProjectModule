//
//  SegmentSliderView.h
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/7/7.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SegmentSliderView : UILabel
@property (nonatomic, assign) CGFloat scale;
@property (nonatomic, assign) CGFloat textWidth;

+ (instancetype)sliderLabelWithTitle:(NSString *)title;
@end
