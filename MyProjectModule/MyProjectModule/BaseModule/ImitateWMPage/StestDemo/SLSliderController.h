//
//  SLSliderController.h
//  SLSliderControl
//
//  Created by iforvert on 2017/11/29.
//  Copyright © 2017年 iforvert. All rights reserved.
//

#import <UIKit/UIKit.h>
#define UIColorFromRGBA(rgbValue, alphaValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:alphaValue]

@protocol SLSliderControllerDelegate<NSObject>

- (void)sliderViewDidChangedCurrentIndex:(NSInteger)index;

@end

@protocol SLSliderProtocol <NSObject>

@required
- (NSString *)sliderContentString;
@optional
- (UIScrollView *)stretchScrollView;

@end


@interface SLSliderController : UIViewController

@property (nonatomic, strong) NSArray <__kindof UIViewController<SLSliderProtocol> *>*childSliderControllers;
@property (nonatomic, strong) UIScrollView *containerSView;

- (void)reloadPages;

/** Slider Bar Controller bottom bar show or not. Default is NO */
@property (nonatomic, assign) BOOL showTabBar;
/** The index of current display view controller */
@property (nonatomic, assign) NSInteger currentIndex;
/** index changed action will called throught delegte property */
@property (nonatomic, weak) id<SLSliderControllerDelegate>sliderDelegate;
/** header高度 */
@property (nonatomic, assign) CGFloat headerHeight;

- (void)scrollToIndex:(NSInteger)index;

@end
