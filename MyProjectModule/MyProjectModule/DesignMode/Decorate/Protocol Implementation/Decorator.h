//
//  Decorator.h
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/7/25.
//  Copyright © 2018年 xinxin. All rights reserved.
//
#import <Foundation/Foundation.h>

/**
 
    汉堡 分 鸡肉煲 牛肉煲 蔬菜包  >getCost
        汉堡加 辣椒 加。。。。
 */
@protocol Decorator <NSObject>

- (NSString *)getDescription;

- (NSInteger)getCost;


-(NSString *)pieDescription;


@end
