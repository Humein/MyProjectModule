//
//  Condiment.m
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/7/25.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import "Condiment.h"

@implementation Condiment

- (instancetype)initWithChickenBurger:(id<Decorator>)pieCa {
    if (self = [super init]) {
        _pieCa = pieCa;
    }
    return self;
}


- (NSInteger)getCost {
    return [_pieCa getCost] + 10;
}

- (NSString *)getDescription {
    
    return [NSString stringWithFormat:@"%@%@",[_pieCa getDescription],@"调料"];
}


@end
