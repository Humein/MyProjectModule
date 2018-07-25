//
//  pie.m
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/7/25.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import "pie.h"

@implementation pie
- (instancetype)initWithChickenBurger:(id<Decorator>)burger {
    if (self = [super init]) {
        _burger = burger;
    }
    return self;
}


- (NSInteger)getCost {
    return [_burger getCost] + 10;
}

- (NSString *)getDescription {
    
    return [NSString stringWithFormat:@"%@%@",[_burger getDescription],@"馅饼"];
}

@end
