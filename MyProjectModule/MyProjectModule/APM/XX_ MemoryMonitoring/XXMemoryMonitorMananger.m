//
//  XXMemoryMonitorMananger.m
//  MyProjectModule
//
//  Created by zhangxinxin on 2021/5/11.
//  Copyright © 2021 xinxin. All rights reserved.
//

#import "XXMemoryMonitorMananger.h"
@interface XXMemoryMonitorMananger()
@property (nonatomic, copy) void(^testLeakMemory)(void);

@end

@implementation XXMemoryMonitorMananger

- (void)dealloc{
    NSLog(@"%@ - dealloc", NSStringFromClass([self class]));
}

-(void)viewDidLoad {
    [super viewDidLoad];
    [self configVC];
}

-(void)configVC{
    self.view.backgroundColor = [UIColor grayColor];
    self.testLeakMemory = ^{
        NSLog(@"%@", NSStringFromClass([self class]));
    };
}

@end
