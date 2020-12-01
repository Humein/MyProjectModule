//
//  Phone.m
//  MyProjectModule
//
//  Created by zhangxinxin on 2020/11/26.
//  Copyright © 2020 xinxin. All rights reserved.
//

#import "Phone.h"
@interface Phone()

@end

@implementation Phone
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
- (void)packaging{
    // 模版模式 实际就是把不变的行为放在父类，把自定义行为放在子类. 主要的思想是将公共方法提取到父类。并且通过父类定义子类的框架
    NSLog(@"模版行为");
}

/// 配置视图信息
-(void)confingNoticeMessage:(id)model{
    NSLog(@"子类实现");
}

#pragma mark -
#pragma mark - <#custom#> Delegate

#pragma mark -
#pragma mark - private methods

#pragma mark -
#pragma mark - getters and setters


@end
