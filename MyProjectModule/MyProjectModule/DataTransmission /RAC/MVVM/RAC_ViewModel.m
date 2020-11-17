//
//  RAC_ViewModel.m
//  MyProjectModule
//
//  Created by zhangxinxin on 2020/11/17.
//  Copyright © 2020 xinxin. All rights reserved.
//

#import "RAC_ViewModel.h"

@interface RAC_ViewModel()
@property (nonatomic, strong, readwrite) RACSubject *pageSelectSubject;
@end

@implementation RAC_ViewModel

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
    [self.pageSelectSubject subscribeNext:^(id  _Nullable x) {
            
    }];
}

/// 设置子视图
- (void)setupSubViews{
    
}

/// 设置子视图约束
-(void)setupSubViewsConstraints{
    
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
- (RACSubject *)pageSelectSubject {
    if (!_pageSelectSubject) {
        _pageSelectSubject = [[RACSubject alloc] init];
    }
    return _pageSelectSubject;
}

@end
