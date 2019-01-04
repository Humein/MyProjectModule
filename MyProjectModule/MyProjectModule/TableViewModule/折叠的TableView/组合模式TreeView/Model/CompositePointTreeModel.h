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
 展视
 */
-(NSString *)showTitle;
/**
 是否展开
 */
- (BOOL )isSpread;

@end

@interface CompositePointTreeModel : NSObject

@property (nonatomic , copy) NSArray<CompositePointTreeModel<ModelProtocol> *> * children;


@end

NS_ASSUME_NONNULL_END
