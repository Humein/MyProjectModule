//
//  PointTreeTypeThree.m
//  MyProjectModule
//
//  Created by 鑫鑫 on 2019/1/2.
//  Copyright © 2019 xinxin. All rights reserved.
//

#import "PointTreeTypeThree.h"

@implementation PointTreeTypeThree
- (NSString *)showTitle{
    return self.title;
}
- (NSString *)cParentId{
    return @(self.parentId).stringValue;
}
@end
