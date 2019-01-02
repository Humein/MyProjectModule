//
//  PointTreeOnlyOneModel.h
//  MyProjectModule
//
//  Created by 鑫鑫 on 2019/1/2.
//  Copyright © 2019 xinxin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PointTreeOnlyOneModel : NSObject
// 后台传来的原始数据格式
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
/**
 是否已请求下级数据（分级加载）
 */
@property (nonatomic, assign) BOOL isNextDataRequest;

@end

NS_ASSUME_NONNULL_END
