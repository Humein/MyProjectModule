//
//  PaternalViewController.m
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/7/2.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import "PaternalViewController.h"
#import "ViewControllerChildOne.h"
#import "ViewControllerChildTwo.h"
#define Weak_Self __weak typeof(self) weakSelf = self;

@interface PaternalViewController ()
@property (nonatomic,strong) id <BookVCProtocol> refreshHelper;

@end

@implementation PaternalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *VCarray = [NSMutableArray arrayWithObjects:@"ViewControllerChildOne",@"ViewControllerChildTwo", nil];
    Weak_Self;
    [VCarray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        Class class = NSClassFromString(VCarray[idx]);
        UIViewController *listVC = (UIViewController *)[[class alloc] init];
        [weakSelf addChildViewController:listVC];
    }];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self didSelectIndex:arc4random() % 2];
}

-(void)didSelectIndex:(NSInteger )currentIndex{
    self.refreshHelper = self.childViewControllers[currentIndex];
    [self.refreshHelper refreshTableViewWithSwitchModelID:@""];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
