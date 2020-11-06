//
//  XXBaseUIView.m
//  MyProjectModule
//
//  Created by zhangxinxin on 2020/8/25.
//  Copyright © 2020 xinxin. All rights reserved.
//

#import "XXBaseUIView.h"

@implementation XXBaseUIView
// MARK: - initView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configSubview];
        [self layout];
    }
    return self;
}

-(void)configSubview{
    
}

// MARK: - layoutView
-(void)layout{
    
}

// MARK: - Refresh Data


// MARK: - Private Method


// MARK: - Get/Set

@end
