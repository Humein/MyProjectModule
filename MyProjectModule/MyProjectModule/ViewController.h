//
//  ViewController.h
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/6/11.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    HTCommonGuideViewTypeVedio,
    HTCommonGuideViewTypeOther,
} HTCommonGuideViewType;

@interface ViewController : UIViewController

extern NSString * const HTCommonGuideViewType_toString[];


@end

