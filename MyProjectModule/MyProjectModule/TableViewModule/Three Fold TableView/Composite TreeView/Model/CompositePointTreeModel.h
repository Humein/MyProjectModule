//
//  CompositePointTreeModel.h
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2019/1/2.
//  Copyright © 2019 xinxin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ModelProtocol <NSObject>
@optional
/**
 
 */
-(NSString *)showTitle;

// 请求下一级
-(NSString *)cParentId;

@end

@interface CompositePointTreeModel : NSObject


@property (nonatomic , copy) NSString *showTitle;

@property (nonatomic , copy) NSString *cParentId;







@property (nonatomic , copy) NSArray<CompositePointTreeModel<ModelProtocol> *> * children;

/**
 是否展开
 */
@property (nonatomic, assign) BOOL isSpread;
@end

NS_ASSUME_NONNULL_END
