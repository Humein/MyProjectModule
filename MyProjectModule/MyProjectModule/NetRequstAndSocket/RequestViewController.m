//
//  RequestViewController.m
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2019/1/3.
//  Copyright © 2019 xinxin. All rights reserved.
//

#import "RequestViewController.h"
#import "RequestMediatorBaseBusniess.h"
@interface RequestViewController ()

@end

@implementation RequestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSDictionary *dicPram = [NSDictionary dictionary];
    
    [RequestMediatorBaseBusniess requestConfig:^(RequestMediatorBaseBusniess * _Nonnull configObject) {
        
        configObject.requestUrl = @"http://123.103.86.52/p/v1/practices/91504021211538936";
        configObject.requestMethod = YTKRequestMethodGET;
        configObject.requestArgument = dicPram;
        configObject.cacheTimeInSecond = 5;

        
    } withParameter:nil withSuccess:^(NSString * _Nonnull succMessage, id  _Nonnull responseObject, NSInteger succCode) {
        
    } andFailure:^(NSString * _Nonnull errorMessage, id  _Nonnull result, NSInteger errorCode) {
        
    }];
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
