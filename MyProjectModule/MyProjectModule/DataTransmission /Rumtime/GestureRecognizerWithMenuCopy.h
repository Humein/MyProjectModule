//
//  GestureRecognizerWithMenuCopy.h
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2020/1/7.
//  Copyright © 2020 xinxin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/// 要关联的对象的键值，一般设置成静态的，用于获取关联对象的值
static char kAssociatedUITouchKey;

@interface GestureRecognizerWithMenuCopy : UILabel
/**
 是否支持选择复制，默认NO
 */
@property (readwrite, nonatomic, assign) BOOL enableCopy;
@end

NS_ASSUME_NONNULL_END
