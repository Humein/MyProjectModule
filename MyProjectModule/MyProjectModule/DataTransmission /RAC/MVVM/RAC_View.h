//
//  RAC_View.h
//  MyProjectModule
//
//  Created by zhangxinxin on 2020/11/17.
//  Copyright © 2020 xinxin. All rights reserved.
//
/*===================================================
        * 文件描述 ：<#文件功能描述必写#> *
=====================================================*/
#import <UIKit/UIKit.h>
@class RAC_ViewModel;
NS_ASSUME_NONNULL_BEGIN

@interface RAC_View : UIView
/// 绑定座位席vm
/// @param viewModel 座位席vm
- (void)bindUserSeatViewModel:(RAC_ViewModel *)viewModel;
@end

NS_ASSUME_NONNULL_END
