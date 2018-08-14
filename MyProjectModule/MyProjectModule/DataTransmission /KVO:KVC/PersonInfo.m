//
//  PersonInfo.m
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/8/14.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import "PersonInfo.h"
@interface PersonInfo()
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *age;
@end
@implementation PersonInfo
- (void)setName:(NSString *)name{
    if (name != _name)
    {
        //子类不能重写这两个方法，否则无法完成手动触发KVO
        //通过改变这两个方法的位置，可以自定义KVO触发的条件
        [self willChangeValueForKey:@"name"];
        _name = name;
        [self didChangeValueForKey:@"name"];
    }
}
// 手动通知
+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key
{
    BOOL automatic = NO;
    if ([key isEqualToString:@"name"]) {
        automatic = NO;
    } else {
        automatic = [super automaticallyNotifiesObserversForKey:key];
    }
    return automatic;
    
}


@end
