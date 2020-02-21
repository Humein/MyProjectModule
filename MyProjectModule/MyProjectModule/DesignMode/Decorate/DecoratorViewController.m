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
#import "UIImage+Shadow.h"
#import "UIImage+Transform.h"
#import "UIImage+Title.h"
@interface DecoratorViewController ()

@end

@implementation DecoratorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
//
    Hamburger *AA = [[Hamburger alloc] init];
    NSLog(@"AA>>>>>%@,%@",@([AA getCost]).stringValue,[AA getDescription]);
    
    pie *BB = [[pie alloc] initWithChickenBurger:AA];
    
    NSLog(@"BB>>>>>%@,%@，%@",@([BB getCost]).stringValue,[BB getDescription],[BB pieDescription]);
    
    Condiment *CC = [[Condiment alloc]initWithChickenBurger:BB];
    
    NSLog(@"CC>>>>>%@,%@",@([CC getCost]).stringValue,[CC getDescription]);
    
    
//
    UIImage *image = [UIImage imageNamed:@""];

    
    CGAffineTransform rotateTransform = CGAffineTransformMakeRotation(-M_PI / 4.0);
    CGAffineTransform translateTransform = CGAffineTransformMakeTranslation(-image.size.width / 2.0,
                                                                            image.size.height / 8.0);
    CGAffineTransform finalTransform = CGAffineTransformConcat(rotateTransform, translateTransform);
    
    
    UIImage* finalImage = [[image imageWithTransform:finalTransform] imageWithDropShadow];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
