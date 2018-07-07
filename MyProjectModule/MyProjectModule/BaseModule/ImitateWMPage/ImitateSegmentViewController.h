//
//  ImitateSegmentViewController.h
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/7/7.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import <UIKit/UIKit.h>
//Handel
@protocol SegmentSliderControllerDelegate<NSObject>

- (void)sliderViewDidChangedCurrentIndex:(NSInteger)index;

@end
//Handel
@protocol SSliderProtocol <NSObject>

@required
- (NSString *)sliderContentString;
@optional
- (UIScrollView *)stretchScrollView;

@end




@interface ImitateSegmentViewController : UIViewController

@property (nonatomic, strong) NSArray <__kindof UIViewController<SSliderProtocol> *>*childSliderControllers;

/** index changed action will called throught delegte property */
@property (nonatomic, weak) id<SegmentSliderControllerDelegate>sliderDelegate;


- (void)scrollToIndex:(NSInteger)index;


/**
 containerSView include The Heaher,SlidingBlockContent,SegmentContent
 */
@property (nonatomic, strong) UIScrollView *containerSView;

/** header Height */
@property (nonatomic, assign) CGFloat headerHeight;

- (void)reloadPages;

/** The index of current display view controller */
@property (nonatomic, assign) NSInteger currentIndex;

@end
