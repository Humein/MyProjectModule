//
//  CheckConditionItem.h
//  benkelaile-iOS
//
//  Created by Zhang Xin Xin on 2019/4/19.
//  Copyright © 2019 sunlands. All rights reserved.
//

#import "AbstractItem.h"

@interface CheckConditionItem : NSObject

@property (nonatomic,copy)NSString *name;

@property (nonatomic,assign)float itemHeight;

@property (nonatomic,assign)float itemWidth;


- (float)titleWidth;

- (float)titleHeight;

@end
