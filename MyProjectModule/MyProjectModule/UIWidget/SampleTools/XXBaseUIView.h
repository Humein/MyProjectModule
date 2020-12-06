//
//  XXBaseUIView.h
//  MyProjectModule
//
//  Created by zhangxinxin on 2020/8/25.
//  Copyright © 2020 xinxin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XXBaseUIView : UIView
// 子类去实现
- (void)configSubview;

- (void)layout;

@end

NS_ASSUME_NONNULL_END
