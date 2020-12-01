//
//  iPhone.m
//  MyProjectModule
//
//  Created by zhangxinxin on 2020/11/26.
//  Copyright © 2020 xinxin. All rights reserved.
//

#import "iPhone.h"
@interface iPhone()

@end

@implementation iPhone
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



#pragma mark -
#pragma mark - <#custom#> Delegate

#pragma mark - ！！！子类实现
#pragma mark - private methods
/// packaging 沿用模版

/// 配置视图信息
-(void)confingNoticeMessage:(id)model{
    NSLog(@"子类实现");
}

#pragma mark -
#pragma mark - getters and setters

@end
