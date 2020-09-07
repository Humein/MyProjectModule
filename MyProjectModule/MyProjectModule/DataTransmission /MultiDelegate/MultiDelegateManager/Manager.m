//
//  Manager.m
//  MyProjectModule
//
//  Created by zhangxinxin on 2020/9/2.
//  Copyright © 2020 xinxin. All rights reserved.
//

#import "Manager.h"

@interface Manager()
{
    MultiDelegate<ManagerDelegate>     *_multiDelegate;
    
}

@end

@implementation Manager

+ (instancetype)shareManager{
    static Manager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}


- (id)init {
    if (self = [super init]) {
        _multiDelegate = (MultiDelegate<ManagerDelegate> *)[[MultiDelegate alloc] init];
        _multiDelegate.silentWhenEmpty = YES;
    }
    return self;
}


#pragma mark - Public Methods
- (void)addDelegate:(id<ManagerDelegate>)delegate{
    if (delegate && ![_multiDelegate.delegates.allObjects containsObject:delegate]) {
        [_multiDelegate addDelegate:delegate];
    }
}

- (void)deleteDelegate:(id<ManagerDelegate>)delegate{
    [_multiDelegate removeDelegate:delegate];
}

- (void)clearAllDelegates{
    [_multiDelegate removeAllDelegates];
}


- (void)reciveBottonClick:(UIButton *)button{
    
    [_multiDelegate manager:self didBottonClick:button];
}


@end
