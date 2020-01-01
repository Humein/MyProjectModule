//
//  ZTKLLDownHelper.m
//  NetRequstAPI_Example
//
//  Created by 鑫鑫 on 2018/5/10.
//  Copyright © 2018年 shou1wang@gmail.com. All rights reserved.
//

#import "ZTKLLDownHelper.h"
@interface ZTKLLDownHelper()
@property (nonatomic,strong)ZTKDownItem *downItem;
@property (nonatomic, strong)  NSTimer  *timer;
@end

@implementation ZTKLLDownHelper
- (id)initWithDownItem:(ZTKDownItem *)downItem{
    if (self = [super init]) {
        _downItem = downItem;
    }
    return self;
    
}
- (void)deleteItem {
    
}

- (void)down {
    NSLog(@"222222");
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(StartDown) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];

}
-(void)StartDown{
    
    NSLog(@"<<<<<<<");
    
}
- (void)resume {
    
}
- (NSArray *)performQuery:(NSString *)query {
    return @[@"2",@"2"];
}

- (void)stop {
    [self.timer invalidate];
    self.timer = nil;
}



@end
