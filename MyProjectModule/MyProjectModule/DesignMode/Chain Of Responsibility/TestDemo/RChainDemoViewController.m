//
//  RChainDemoViewController.m
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/7/17.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import "RChainDemoViewController.h"
#import "UIResponder+UIResponderChain.h"
#import "ResponderControlView.h"

@interface RChainDemoViewController ()
@end

@implementation RChainDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initALLView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    

}

-(void)initALLView{
    ResponderControlView  *RAView = [[ResponderControlView alloc]initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, 400)];
    RAView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:RAView];
}


@end
