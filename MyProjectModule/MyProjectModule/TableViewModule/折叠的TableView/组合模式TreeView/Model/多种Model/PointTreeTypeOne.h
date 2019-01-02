//
//  PointTreeTypeOne.h
//  MyProjectModule
//
//  Created by 鑫鑫 on 2019/1/2.
//  Copyright © 2019 xinxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CompositePointTreeModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface PointTreeTypeOne : CompositePointTreeModel<ModelProtocol>
@property (nonatomic , assign) NSInteger id;
@property (nonatomic , assign) NSInteger speed;
@property (nonatomic , assign) NSInteger qnum;
@property (nonatomic , assign) NSInteger unum;



@end

NS_ASSUME_NONNULL_END
