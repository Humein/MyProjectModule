//
//  XXBaseUIView.m
//  MyProjectModule
//
//  Created by zhangxinxin on 2020/8/25.
//  Copyright © 2020 xinxin. All rights reserved.
//

#import "XXBaseUIView.h"

@implementation XXBaseUIView
#pragma mark - initView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configSubview];
        [self layout];
    }
    return self;
}

- (void)configSubview
{
    
}

#pragma mark - layoutView
- (void)layout
{
    
}

#pragma mark - RefreshData


#pragma mark - PrivateMethod

@end
