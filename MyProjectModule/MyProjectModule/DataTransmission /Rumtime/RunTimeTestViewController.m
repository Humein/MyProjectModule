//
//  RunTimeTestViewController.m
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2019/2/18.
//  Copyright © 2019 xinxin. All rights reserved.
//

#import "RunTimeTestViewController.h"
#import "NSObject+RuntimeHelper.h"
#import <objc/message.h>
@interface RunTimeTestViewController ()
@property (nonatomic , assign) NSObject *weakObject;
@property (nonatomic , strong) NSObject *strongObject;

@end

@implementation RunTimeTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@", self.objc_weak_id);
    self.objc_weak_id = @"0";
    NSLog(@"%@", self.objc_weak_id);
    
    
    NSObject *newObje = [NSObject new];
    
    self.weakObject = newObje;
    
    self.strongObject = [NSObject new];
    
    __weak NSObject *weakObje = newObje;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        NSLog(@"newObje=====%@",weakObje);

    });
    
    self.weakObject = nil;
    NSLog(@"end");
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"%@",[self.weakObject description]);
    
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];

    [UIView animateWithDuration:5 animations:^{

        self.strongObject = [NSObject new];
        
    } completion:^(BOOL finished) {
        
        NSLog(@"animated=====%@",@(finished));
        
    }];
    
}

-(void)dealloc{
    NSLog(@"%@", self.objc_weak_id);
    NSLog(@"%@=====nil",[self description]);
    
}

/// weak associated object
- (void)weakAssociatedObject:(NSObject *)object{
   {
    id __weak weakObject = object;
    id (^block)() = ^{ return weakObject; };
    objc_setAssociatedObject(self, @selector(context), block, OBJC_ASSOCIATION_COPY);
    }

//     {
//    id (^block)() = objc_getAssociatedObject(self, @selector(context));
//    id curContext = (block ? block() : nil);
//    return curContext;
//    }
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self runTimeAddInstanceMethod];
}

//MARK:- 在对象生命周期内只执行一次
-(void)launch{
    if (objc_getAssociatedObject(self, _cmd)) {
        return;
    }else{
        objc_setAssociatedObject(self, _cmd, @"launched", OBJC_ASSOCIATION_RETAIN);
    }
    NSLog(@"方法只执行一次");
}



@end
