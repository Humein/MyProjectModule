//
//  RAC_ViewModel.h
//  MyProjectModule
//
//  Created by zhangxinxin on 2020/11/17.
//  Copyright © 2020 xinxin. All rights reserved.
//
/*===================================================
        * 文件描述 ：<#文件功能描述必写#> *
=====================================================*/
#import <UIKit/UIKit.h>
#import "ReactiveObjC.h"

NS_ASSUME_NONNULL_BEGIN

@interface RAC_ViewModel : UIView
/// 授课、批改、学情 选择
@property (nonatomic, strong, readonly) RACSubject *pageSelectSubject;
@end

NS_ASSUME_NONNULL_END
