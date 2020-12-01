//
//  FactoryUsage.m
//  MyProjectModule
//
//  Created by zhangxinxin on 2020/11/26.
//  Copyright © 2020 xinxin. All rights reserved.
//

#import "FactoryUsage.h"
#import "PhoneFactory.h"
@interface FactoryUsage()

@end

@implementation FactoryUsage

#pragma mark -
#pragma mark - life cycle - 生命周期
- (void)dealloc{
    NSLog(@"%@ - dealloc", NSStringFromClass([self class]));
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

#pragma mark -
#pragma mark - init setup - 初始化视图
- (void)setup{
    [self setDefault];//初始化默认数据
    [self setupSubViews];//设置子View
    [self setupSubViewsConstraints];//设置子View约束
}

/// 设置默认数据
- (void)setDefault{
    
}

/// 设置子视图
- (void)setupSubViews{
    
}

/// 设置子视图约束
-(void)setupSubViewsConstraints{
    
}

//MARK:- 简单工厂
-(void)sampleFactory{
//    Phone *iPhone = [PhoneFactory  createPhoneWithTag:FactoryProductTypeiPhone];
//    Phone *miPhone = [PhoneFactory  createPhoneWithTag:FactoryProductTypeMiPhone];
//
//    [iPhone packaging];
//    [miPhone packaging];
//
//    [self printPhone:iPhone];
//    [self printPhone:miPhone];
    
    NSInteger type = 1;
    Phone *phone = [PhoneFactory createPhoneWithTag:type ? ProductTypeTakeClassTest : ProductTypeGetClassInfo];
    phone.block = ^(FactoryProductType type) {
        NSLog(@"%ld",(long)type);
    };
    // !!!: 哈哈这里有点像策略模式了
    [phone confingNoticeMessage:@""];
    [self printPhone:phone];
}

-(void)printPhone:(Phone *)phone{
    NSLog(@"Store begins to sell phone:%@",[phone class]);
}


#pragma mark -
#pragma mark - public methods


#pragma mark -
#pragma mark - <#custom#> Delegate

#pragma mark -
#pragma mark - event response

#pragma mark -
#pragma mark - private methods

#pragma mark -
#pragma mark - getters and setters

@end
