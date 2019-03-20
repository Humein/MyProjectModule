//
//  AbstractAlertView.h
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2019/3/19.
//  Copyright © 2019 xinxin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^AlertViewClickBlock)(NSInteger index);
@interface AbstractAlertView : UIView
@property (nonatomic, copy) AlertViewClickBlock handleBlock;

@end

NS_ASSUME_NONNULL_END
