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

//MARK: KVO键值观察--监听TF的值发生变化
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


//MARK: RAC总结
// https://juejin.im/post/6844903814047203336#heading-4

//MARK: 特别牛逼的宏

/**
 1. RAC(TARGET, ...)  分配一个信号给一个对象的属性, 只要有新的信号产生, 就自动分配给特定的key, 当信号完成时, 绑定自动废弃.
 RAC(_targetLabel,text) = _textField.rac_textSignal;
 RAC(self.streamStateButton,selected) = RACObserve(self.viewModel, stageState);
 
 2. RACObserve(TARGET, KEYPATH)
 替代KVO的宏: 当TARGET的KEYPATH发生变化时, 就会产生新的信号.

 3. @weakify(...) & @strongify(...)
 解除循环引用必备神器
 @weakify(...) 给其中的参数变量创建一个C语言的__weak修饰的影子变量, 这些影子变量随后又会被@strongify(...)修饰, 重新成为强引用的变量

 在block中, 这个宏用弱引用变量, 但在block执行的时候, 要确保该变量一直存在

 @strongify(...)将参数变量强引用, 但前提是, 这些参数之前要被@weakify(...)修饰过, 这个宏将覆盖掉初始的变量名, 所以在当前作用域使用原来的变量名并不会引起循环引用: @weakify(...)和 @strongify(...)一定要成对配合使用!

 
 4.
 
 
 */


//MARK: MVVM + RAC 双向绑定示意图
/**
 https://blog.csdn.net/deft_mkjing/article/details/60773266
 */


//MARK: 使用RACSubject替代代理
// https://www.jianshu.com/p/f068f5783d82


//MARK: 使用RACSubject替代通知
//发送通知
- (void)demo5{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    //发送广播通知
    [center postNotificationName:@"妇女之友" object:nil userInfo:@{@"技巧":@"用心听"}];
}

-(void)demo55{
    //接收通知
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    //RAC的通知不需要我们手动移除
    //注册广播通知
    RACSignal *siganl = [center rac_addObserverForName:@"妇女之友" object:nil];
    //设置接收通知的回调处理
    [siganl subscribeNext:^(NSNotification *x) {
        NSLog(@"技巧: %@",x.userInfo[@"技巧"]);
    }];
}


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
