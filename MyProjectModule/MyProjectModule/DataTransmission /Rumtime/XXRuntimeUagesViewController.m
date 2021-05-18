//
//  XXRuntimeUagesViewController.m
//  MyProjectModule
//
//  Created by zhangxinxin on 2021/5/14.
//  Copyright © 2021 xinxin. All rights reserved.
//

#import "XXRuntimeUagesViewController.h"
#import <objc/message.h>

@interface XXRuntimeUagesViewController ()

@end

@implementation XXRuntimeUagesViewController
// TODO: 标示处有功能代码待编写
// FIXME: 标示处代码需要修正
// !!!: 标示处代码需要注意
// ???: 标示处代码有疑问

// MARK: - LifeCycle
-(void)dealloc {
    NSLog(@"%@销毁啦。。。。。。",NSStringFromClass(self.class));
}

-(void)viewDidLoad {
    [super viewDidLoad];
    [self configVC];
    [self configSubview];
    [self changeLog];
    NSLog(@"++++");
    
}

// MARK: - View config
-(void)configVC {
    
}

-(void)configSubview {
    
}
// MARK: - Make Data
// MARK: 拦截并替换系统方法;为原有方法添加额外功能
/// 需要在分类中添加
- (void)changeLog {
    Class cls = [self class];
    // 获取方法地址
    Method swizzledMethod = class_getClassMethod(cls, @selector(XXNSLog:));
   // 获取imageWithName方法地址
    Method originalMethod = class_getClassMethod(cls, @selector(NSLog:));
    // 交换方法地址，相当于交换实现方式
    method_exchangeImplementations(swizzledMethod, originalMethod);
}

// 不能在分类中重写系统方法，因为会把系统的功能给覆盖掉，而且分类中不能调用super.

- (void)XXNSLog:(NSString *)str {
   // 这里调用XXNSLog，相当于调用NSLog; 不用调用系统方法；否则会递归的。 注意：由于方法交换，系统的方法名已变成了自定义的方法名
    [self XXNSLog:str]; // 保留原来功能
    NSLog(@"新加功能");
}
// MARK: - Private Method

// MARK: - Target Methods

// MARK: - Delegate

// MARK: - Getter / Setter

@end
