//
//  SimulationChainFucCode.h
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2018/11/15.
//  Copyright © 2018 xinxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SimulationChainFucCode : UIView

//我们现在要在VC上加四个大小相同，圆角为2的红色view,实现代码如下

// 使用构造方法 就需要在 外部 实例化对象了
+(instancetype)initWith:(void(^)(SimulationChainFucCode *view))BLOCK;

@property(nonatomic,readonly,copy)SimulationChainFucCode *(^viewFrame)(CGRect  frame);
@property(nonatomic,readonly,copy)SimulationChainFucCode * (^layerCornerRadious)(CGFloat radious);
@property(nonatomic,copy,readonly)SimulationChainFucCode *(^ColorString)(NSString * colorStr);

@end
