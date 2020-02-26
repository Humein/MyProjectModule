//
//  PointTreeTypeTwo.m
//  MyProjectModule
//
//  Created by 鑫鑫 on 2019/1/2.
//  Copyright © 2019 xinxin. All rights reserved.
//

#import "PointTreeTypeTwo.h"

@implementation PointTreeTypeTwo
- (NSString *)showTitle{
    return self.title;
}
- (NSString *)cParentId{
    return @(self.parentId).stringValue;
}
@end
