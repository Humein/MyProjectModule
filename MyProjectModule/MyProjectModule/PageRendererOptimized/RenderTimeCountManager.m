//
//  RenderTimeCountManager.m
//  MyProjectModule
//
//  Created by zhangxinxin on 2020/11/5.
//  Copyright © 2020 xinxin. All rights reserved.
//

#import "RenderTimeCountManager.h"

@implementation RenderTimeCountManager{
    NSTimeInterval _lastTime;
}

+ (instancetype)sharedInstance {
  static RenderTimeCountManager *sharedCache = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedCache = [[self alloc] init];
  });
  return sharedCache;
}


-(NSString *)getTimeStamp{
    NSTimeInterval now = [self getNowTimeStamp];
    NSTimeInterval dur = now - _lastTime;
    _lastTime = now;
    return [NSString stringWithFormat:@"%0.4f",dur];
}

-(NSTimeInterval)getNowTimeStamp {
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    return a;
}

@end
