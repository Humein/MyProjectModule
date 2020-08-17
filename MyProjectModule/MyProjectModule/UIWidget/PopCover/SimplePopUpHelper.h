//
//  SimplePopUpHelper.h
//  MyProjectModule
//
//  Created by zhangxinxin on 2020/8/10.
//  Copyright © 2020 xinxin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^PopUpCustomBlock)(void);

@interface SimplePopUpHelper : UIView
/// 蒙板消失回掉
@property(nonatomic,copy) PopUpCustomBlock popUpCallBack;
/// 显示的位置
@property(nonatomic,assign)CGPoint FromPoint;
/// 透明度默认0.2
@property(nonatomic,assign)CGFloat backgroundGalpha;
/// 显示在window上
/// @param customView customView
- (void)showInView:(UIView *)customView;
/// 显示在你的view上
/// @param customView customView
/// @param view view
- (void)showCustomView:(UIView *)customView InView:(UIView *)view;
/// 隐藏
- (void)hidden;
@end

NS_ASSUME_NONNULL_END
