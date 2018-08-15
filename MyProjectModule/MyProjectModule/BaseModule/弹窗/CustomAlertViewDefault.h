//
//  CustomAlertViewDefault.h
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/8/15.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^AlertViewClickBlock) (NSInteger index);

@interface CustomAlertViewDefault : UIView

@property (nonatomic,copy)AlertViewClickBlock handleBlock;


@end
