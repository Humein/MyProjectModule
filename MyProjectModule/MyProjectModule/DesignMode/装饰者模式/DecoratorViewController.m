//
//  DecoratorViewController.m
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/7/25.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import "DecoratorViewController.h"
#import "Hamburger.h"
#import "Condiment.h"
#import "pie.h"
@interface DecoratorViewController ()

@end

@implementation DecoratorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    Hamburger *AA = [[Hamburger alloc] init];
    NSLog(@"AA>>>>>%@,%@",@([AA getCost]).stringValue,[AA getDescription]);
    
    pie *BB = [[pie alloc] initWithChickenBurger:AA];
    
    NSLog(@"BB>>>>>%@,%@",@([BB getCost]).stringValue,[BB getDescription]);
    
    Condiment *CC = [[Condiment alloc]initWithChickenBurger:BB];
    
    NSLog(@"CC>>>>>%@,%@",@([CC getCost]).stringValue,[CC getDescription]);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
