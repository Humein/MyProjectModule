//
//  RunTimeTestViewController.m
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2019/2/18.
//  Copyright © 2019 xinxin. All rights reserved.
//

#import "RunTimeTestViewController.h"
#import "NSObject+RuntimeHelper.h"
@interface RunTimeTestViewController ()

@end

@implementation RunTimeTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self runTimeAddInstanceMethod];
}

@end
