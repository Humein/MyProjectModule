//
//  UIViewControllerOne.m
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/7/2.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import "ViewControllerChildOne.h"

@interface ViewControllerChildOne ()

@end

@implementation ViewControllerChildOne

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


#pragma ---delegate
-(void)refreshTableViewWithSwitchModelID:(NSString *)switchModelID{
    NSLog(@">>>>>>>>.>>>>%@=%@",[self class],switchModelID);
    
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
