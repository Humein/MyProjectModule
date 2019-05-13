//
//  CheckConditionItem.h
//  benkelaile-iOS
//
//  Created by Zhang Xin Xin on 2019/4/19.
//  Copyright © 2019 sunlands. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CheckConditionItem : NSObject

@property (nonatomic,copy)NSString *name;

//@property (nonatomic,strong)UIColor *tintColor;//tagCell的颜色

- (float)titleWidth;

- (float)titleHeight;

@end

NS_ASSUME_NONNULL_END
