//
//  AvoidCrashViewController.m
//  MyProjectModule
//
//  Created by zhangxinxin on 2020/12/2.
//  Copyright © 2020 xinxin. All rights reserved.
//

#import "AvoidCrashViewController.h"

@interface AvoidCrashViewController ()

@end

@implementation AvoidCrashViewController
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
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self tryCatch];
}

// MARK: - View config
-(void)configVC {
    
}

-(void)configSubview {
    
}
// MARK: - Make Data

// MARK: - Private Method

// !!!: @try @catch 语句处理崩溃
-(void)tryCatch{
    //
    /** 很少用到try 和catch
    1.
      exception容易造成内存管理问题（文档有描述即使是arc下，也不是安全的）；exception使用block造成额外的开销，效率较低等等
     try catch 会中断程序的执行流程。对于采用GC来释放内存的java等语言，这没什么问题。C++/OC这种语言，内存释放的代码往往会因为try catch的中断执行不到。所以会造成内存泄露。ARC的原理就是在代码编译期间在alloc init的后面插入release代码。try catch如果中断了代码执行，同样会有内存泄露的问题。
            
    2.
     try catch 无法捕获UncaughtException，而oc中大部分crash如：内存溢出、野指针等都是无法捕获的，而能捕获的只是像数组越界之类
     苹果在文档中也强调了，要自己做好防护，不要寄希望于try catch，因为能抓的异常有限
              
     */
    
    
    // 0. 插入nil到可变数组中
    NSString *nilStr = nil;
    NSMutableArray *arrayM = [NSMutableArray array];
    
    //1.信号量错误
    int list[2]={1,2};
    int *p = list;

    //2.ios越界崩溃
    NSArray *array= @[@"tom",@"xxx",@"ooo"];
    
    //3. 解归档错误

    
    @try {
         //如果@try中的代码会导致程序崩溃，就会来到@catch
         
         /// 将一个nil插入到可变数组中，这行代码肯定有问题
        [arrayM addObject:nilStr];
        
        /// 导致SIGABRT的错误，因为内存中根本就没有这个空间，哪来的free，就在栈中的对象而已
        free(p);
        p[1] = 5;
        
        /// 越界崩溃
        [array objectAtIndex:5];
         
     }
     @catch (NSException *exception) {
         //如果@try中的代码有问题(导致崩溃),就会来到@catch
         
         //在这里你可以进行相应的处理操作
         
         //如果你要抛出异常(让程序崩溃),就写上 @throw exception
     }
     @finally {
         
         //@finally中的代码是一定会执行的
         
         //你可以在这里进行一些相应的操作
     }
}


// MARK: - Target Methods

// MARK: - Delegate

// MARK: - Getter / Setter

@end
