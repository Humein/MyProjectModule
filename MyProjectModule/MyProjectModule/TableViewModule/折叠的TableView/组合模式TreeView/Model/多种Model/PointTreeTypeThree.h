//
//  PointTreeTypeThree.h
//  MyProjectModule
//
//  Created by 鑫鑫 on 2019/1/2.
//  Copyright © 2019 xinxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CompositePointTreeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PointTreeTypeThree : CompositePointTreeModel<ModelProtocol>
@property (nonatomic , assign) NSInteger rnum;
@property (nonatomic , assign) NSInteger level;
@property (nonatomic , assign) long long unfinishedPracticeId;



@end

NS_ASSUME_NONNULL_END
