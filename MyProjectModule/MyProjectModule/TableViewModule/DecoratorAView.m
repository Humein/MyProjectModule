//
//  DecoratorAView.m
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/7/27.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import "DecoratorAView.h"

@implementation DecoratorAView

- (instancetype)initWithChickenBurger:(id<DecoratorProtocols>)burger {
    if (self = [super init]) {
        _burger = burger;
    }
    return self;
}


- (void)cellClicks:(NSString *)viewModel{
    
}



@end
