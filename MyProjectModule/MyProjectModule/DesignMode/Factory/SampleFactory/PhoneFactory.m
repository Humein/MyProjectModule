//
//  PhoneFactory.m
//  MyProjectModule
//
//  Created by zhangxinxin on 2020/11/26.
//  Copyright © 2020 xinxin. All rights reserved.
//

#import "PhoneFactory.h"
#import "iPhone.h"
#import "MIPhone.h"
@interface PhoneFactory()

@end

@implementation PhoneFactory
#pragma mark -
#pragma mark - life cycle - 生命周期
- (void)dealloc{
    NSLog(@"%@ - dealloc", NSStringFromClass([self class]));
}

- (instancetype)init{
    if (self = [super init]) {
        [self setup];
    }
    return self;
}

#pragma mark -
#pragma mark - init setup - 初始化
- (void)setup{
    [self setDefault];//初始化默认数据
}

/// 设置默认数据
- (void)setDefault{
    
}

#pragma mark -
#pragma mark - public methods
+ (Phone *)createPhoneWithTag:(FactoryProductType)type{
    Phone *product = nil;
    switch (type) {
        case ProductTypeGetClassInfo:
            product = [[iPhone alloc] init];
            break;
        case ProductTypeTakeClassTest:
            product = [[MIPhone alloc] init];
            break;
        default:
            product = nil;
            break;
    }
    return product;
}

#pragma mark -
#pragma mark - <#custom#> Delegate

#pragma mark -
#pragma mark - private methods

#pragma mark -
#pragma mark - getters and setters

@end
