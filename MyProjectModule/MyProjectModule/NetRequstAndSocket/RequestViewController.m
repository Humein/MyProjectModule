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
    // Config:^  Block
    NSDictionary *dicPram = [NSDictionary dictionary];
    [RequestMediatorBaseBusniess requestConfig:^(RequestMediatorBaseBusniess *configObject) {
        configObject.requestUrl = @"http://123.103.86.52/p/v1/practices/91504021211538936";
        configObject.requestMethod = YTKRequestMethodGET;
        configObject.requestArgument = dicPram;
        configObject.cacheTimeInSecond = 5;
        
    }withSuccess:^(NSString * _Nonnull succMessage, id  _Nonnull responseObject, NSInteger succCode) {
        
    } andFailure:^(NSString * _Nonnull errorMessage, id  _Nonnull result, NSInteger errorCode) {
        
        NSLog(@"业务错误==%@，%@，http错误码===%ld",errorMessage,result,(long)errorCode);
    }];
    
    
    
}


@end
