//
//  PointTreeTypeTwo.h
//  MyProjectModule
//
//  Created by 鑫鑫 on 2019/1/2.
//  Copyright © 2019 xinxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CompositePointTreeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PointTreeTypeTwo : CompositePointTreeModel<ModelProtocol>
@property (nonatomic , assign) NSInteger times;
@property (nonatomic , assign) NSInteger accuracy;
@property (nonatomic , copy) NSString * name;
@property (nonatomic , assign) NSInteger wnum;



@end

NS_ASSUME_NONNULL_END
