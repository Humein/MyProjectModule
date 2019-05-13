//
//  ViewController.h
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/6/11.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AbstractViewController.h"
typedef enum : NSUInteger {
    HTCommonGuideViewTypeVedio,
    HTCommonGuideViewTypeOther,
} HTCommonGuideViewType;

//  字符串枚举
//.h 文件中 -------------
//typedef NSString *KLTypeStr NS_STRING_ENUM;
//
//FOUNDATION_EXPORT KLTypeStr const KLTypeStringRed;
//FOUNDATION_EXPORT KLTypeStr const KLTypeStringGreen;
//FOUNDATION_EXPORT KLTypeStr const KLTypeStringOrange;
//
//.m 文件中 --------------
//NSString * const KLTypeStringRed = @"红色";
//NSString * const KLTypeStringGreen = @"绿色";
//NSString * const KLTypeStringOrange = @"橘色";

@interface ViewController : AbstractViewController

extern NSString * const HTCommonGuideViewType_toString[];


@end

