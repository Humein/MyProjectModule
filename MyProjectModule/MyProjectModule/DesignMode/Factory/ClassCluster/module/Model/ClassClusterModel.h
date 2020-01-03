//
//  ClassClusterModel.h
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2019/1/16.
//  Copyright © 2019 xinxin. All rights reserved.
//

#import <Foundation/Foundation.h>
static NSString * const XXClassClusterCellAReuseID = @"XXClassClusterCellAReuseID";
static NSString * const XXClassClusterCellBReuseID = @"XXClassClusterCellBReuseID";
static NSString * const XXClassClusterCellCReuseID = @"XXClassClusterCellCReuseID";

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, XXClassClusterType) {
    XXClassClusterTypeA,
    XXClassClusterTypeB,
    XXClassClusterTypeC
};

@interface ClassClusterModel : NSObject
@property (nonatomic, assign) XXClassClusterType type;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *cellReuseID;
@end

NS_ASSUME_NONNULL_END
