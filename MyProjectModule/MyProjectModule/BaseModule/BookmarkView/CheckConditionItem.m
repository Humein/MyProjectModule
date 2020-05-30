//
//  CheckConditionItem.m
//  benkelaile-iOS
//
//  Created by Zhang Xin Xin on 2019/4/19.
//  Copyright © 2019 sunlands. All rights reserved.
//

#import "CheckConditionItem.h"

#import <UIKit/UIKit.h>

@implementation CheckConditionItem


- (float)titleWidth
{
   CGSize size= [self.name boundingRectWithSize:CGSizeMake(1000, 40) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16]} context:nil].size;
    return size.width+20;
}

- (float)titleHeight
{
    return 40.0f-2;
}

@end
