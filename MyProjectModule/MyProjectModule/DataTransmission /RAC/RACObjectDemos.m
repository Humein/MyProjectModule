//
//  RACObjectDemos.m
//  MyProjectModule
//
//  Created by zhangxinxin on 2020/11/17.
//  Copyright © 2020 xinxin. All rights reserved.
//

#import "RACObjectDemos.h"
#import "ReactiveObjC.h"
@interface RACObjectDemos()
@property (nonatomic, strong) UITextField *tF;
@property (nonatomic, strong) NSObject *value;
@property (nonatomic, strong) NSObject *value2;

@end

@implementation RACObjectDemos

- (void)dealloc{
    NSLog(@"%@ - dealloc", NSStringFromClass([self class]));
}

- (instancetype)init{
    if (self = [super init]) {
    }
    return self;
}

#pragma mark - useAges

//MARK: 键值观察--监听TF的值发生变化
- (void)demo1{
     @weakify(self);
    [self.tF.rac_textSignal subscribeNext:^(NSString *value) {
        @strongify(self);
        self.value = value;
    }];

    //当self.value的值变化时调用Block，这是用KVO的机制，RAC封装了KVO
    [RACObserve(self, value) subscribeNext:^(NSString *value) {
        NSLog(@"%@",value);
    }];
}

//MARK: 使用RACSubject替代代理
// https://www.jianshu.com/p/f068f5783d82


//MARK: map的使用
- (void)demo2{
   //创建一个信号
    RACSignal *signalA = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
       //这个信号里面有一个Next事件的玻璃球和一个complete事件的玻璃球
        [subscriber sendNext:@"唱歌"];
        [subscriber sendCompleted];
        return nil;

    }];
    
    //对信号进行改进,当信号里面流的是唱歌.就改进为'跳舞'返还给self.value
    RAC(self, tF.text) = [signalA map:^id(NSString *value) {
        if ([value isEqualToString:@"唱歌"]) {
            return @"跳舞";
        }
        return @"";
        
    }];
}

//MARK: filter使用,你向西，他就向东，他向左，你就向右
- (void)demo3{
    
    //创建两个通道,一个从A流出的通道A,和一个从B流出的通道B
    RACChannelTerminal *channelA = RACChannelTo(self, value);
    RACChannelTerminal *channelB = RACChannelTo(self,value2);
    
    //改造通道A,使通过通道A的值,如果等于'西',就改为'东'
    [[channelA map:^id(NSString *value) {
        if ([value isEqualToString:@"西"]) {
            NSLog(@"东");
            return @"东";
            
        }
        NSLog(@"====== %@",value);
        return value;
    }] subscribe:channelB];//通道A流向B
    
    //改造通道B,使通过通道B的值,如果等于'左',就改为'右'传出去
    [[channelB map:^id(id value) {
        if ([value isEqualToString:@"左"]) {
            NSLog(@"右");
            return @"右";
        }
        NSLog(@"====== %@",value);
        return value;
        
    }] subscribe:channelA];//通道B流向通道A
    
    //KVO监听valueA的值的变化,过滤valueA的值,返回Yes表示通过
    //只有value有值,才可通过
    [[RACObserve(self, value) filter:^BOOL(id value) {
       
        return value ? YES : NO;
        
    }] subscribeNext:^(id x) {
        
        NSLog(@"你向%@",x);
        
    }];
    
    //KVO监听value2的变化
    [[RACObserve(self, value2) filter:^BOOL(id value) {
        return value ? YES: NO;
    }] subscribeNext:^(id x) {
        NSLog(@"他向%@",x);
    }];
    
    //下面使value的值和value2的值发生改变
    self.value = @"西";
    self.value2 = @"左";
}

@end
