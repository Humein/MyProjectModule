//
//  PaternalViewController.m
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/7/7.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import "PaternalSViewController.h"
#import "UIView+frameAdjust.h"
#import "ChildViewController.h"
@interface PaternalSViewController (){
    UIView *_headerView;
}

@end

@implementation PaternalSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 100)];
    _headerView.backgroundColor = [UIColor redColor];
    
    
    [self configView];
    [self configData];


    
}

-(void)configView{
    self.headerHeight = 100;
    [self.containerSView addSubview:_headerView];
}

-(void)configData{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];

        for (int i = 0 ; i<5; i++) {
            [arr addObject:[self childVCWithModel:i]];
        }
        
        self.childSliderControllers = [arr copy];

    });

}
- (ChildViewController *)childVCWithModel:(int )item
{
    ChildViewController *vc = [[ChildViewController alloc] init];
    vc.itemTitle = @(item).stringValue;
    return vc;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
