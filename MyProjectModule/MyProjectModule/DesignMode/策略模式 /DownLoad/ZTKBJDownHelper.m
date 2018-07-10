//
//  ZTKBJDownHelper.m
//  NetRequstAPI_Example
//
//  Created by 鑫鑫 on 2018/5/10.
//  Copyright © 2018年 shou1wang@gmail.com. All rights reserved.
//

#import "ZTKBJDownHelper.h"
@interface ZTKBJDownHelper()
@property (nonatomic,strong)ZTKDownItem *downItem;
@property (nonatomic, strong)  NSTimer  *timer;

@end

@implementation ZTKBJDownHelper
- (id)initWithDownItem:(ZTKDownItem *)downItem
{
    if (self = [super init]) {
        _downItem = downItem;
    }
    return self;
}


- (void)deleteItem {
    
}

- (void)down {
    NSLog(@"111111111");
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(StartDown) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];


}

- (void)resume {
    
}

- (void)stop {
    [self.timer invalidate];
    self.timer = nil;
}

- (NSArray *)performQuery:(NSString *)query {
    return @[@"1",@"1"];
}


-(void)StartDown{

    NSLog(@">>>>>>>>>>");

    //1: 抛出delegate 给 控制器
    
   // 2： 找到对应的model 直接 修改
}

@end
