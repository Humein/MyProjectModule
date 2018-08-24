//
//  CustomAlertViewDefault.m
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/8/15.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import "CustomAlertViewDefault.h"
#import <Masonry/Masonry.h>


@implementation CustomAlertViewDefault
-(void)dealloc{
    NSLog(@"%@======销毁",NSStringFromClass(self.class));
}
- (id)initWithFrame:(CGRect)frame
{
    if (self= [super initWithFrame:CGRectZero]) {
        
        [self setupContentView];
    }
    return self;
}


#pragma mark- 弹框

- (void)setupContentView
{
  
    UIButton *one = [UIButton buttonWithType:UIButtonTypeInfoDark];
    [one setFrame:CGRectMake(0, 0, 10, 10)];
    one.backgroundColor = [UIColor grayColor];
    one.tag = 100;
    [one addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchDown];
    
    [self addSubview:one];
    
    UIButton *two = [UIButton buttonWithType:UIButtonTypeInfoDark];
    [two setFrame:CGRectMake(20, 20, 10, 10)];
    two.backgroundColor = [UIColor yellowColor];
    two.tag = 101;
    [two addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:two];

    
}

-(void)click:(UIButton *)sender{
    if (self.handleBlock) {
        self.handleBlock(sender.tag);
    }
}


@end
