//
//  CompositePointTreeModel.h
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2019/1/2.
//  Copyright © 2019 xinxin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CompositePointTreeModel : NSObject
@property (nonatomic , assign) NSInteger id;
@property (nonatomic , assign) NSInteger speed;
@property (nonatomic , assign) NSInteger qnum;
@property (nonatomic , assign) NSInteger unum;
@property (nonatomic , assign) NSInteger rnum;
@property (nonatomic , assign) NSInteger level;
@property (nonatomic , assign) long long unfinishedPracticeId;
@property (nonatomic , copy) NSArray<CompositePointTreeModel *> * children;
@property (nonatomic , assign) NSInteger times;
@property (nonatomic , assign) NSInteger accuracy;
@property (nonatomic , copy) NSString * name;
@property (nonatomic , assign) NSInteger wnum;


//业务属性
/**
 是否展开
 */
@property (nonatomic, assign) BOOL isSpread;


@end

NS_ASSUME_NONNULL_END
