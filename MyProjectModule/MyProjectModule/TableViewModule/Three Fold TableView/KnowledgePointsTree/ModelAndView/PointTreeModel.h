//
//  PointTreeModel.h
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2018/11/5.
//  Copyright © 2018 xinxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PointTreeModel : NSObject

@property (nonatomic , assign) NSInteger id;
@property (nonatomic , assign) NSInteger speed;
@property (nonatomic , assign) NSInteger qnum;
@property (nonatomic , assign) NSInteger unum;
@property (nonatomic , assign) NSInteger rnum;
@property (nonatomic , assign) NSInteger level;
@property (nonatomic , assign) long long unfinishedPracticeId;
@property (nonatomic , copy) NSArray<PointTreeModel *> * children;
@property (nonatomic , assign) NSInteger times;
@property (nonatomic , assign) NSInteger accuracy;
@property (nonatomic , copy) NSString * name;
@property (nonatomic , assign) NSInteger wnum;

// 业务数据
/**
 是否展开
 */
@property (nonatomic, assign) BOOL isSpread;
@end
