//
//  HitEventStrikeView.m
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2018/11/6.
//  Copyright © 2018 xinxin. All rights reserved.
//

#import "HitEventStrikeView.h"

@implementation HitEventStrikeView

+ (instancetype)viewWithFrame:(CGRect)frame hitTestBlock:(UIView * _Nullable (^)(UIView * _Nullable hitView, CGPoint point, UIEvent * _Nullable event))hitTestBlock {
    HitEventStrikeView *hitTestView = [[self alloc] initWithFrame:frame];
    [hitTestView setHitTestBlock:hitTestBlock];
    return hitTestView;
}

- (nullable UIView *)hitTest:(CGPoint)point withEvent:(nullable UIEvent *)event {
    UIView *hitView = [super hitTest:point withEvent:event];
    return self.hitTestBlock ? self.hitTestBlock(hitView, point, event) : nil;
}

@end
