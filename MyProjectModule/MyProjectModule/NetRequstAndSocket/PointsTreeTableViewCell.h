//
//  PointsTreeTableViewCell.h
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2019/1/4.
//  Copyright © 2019 xinxin. All rights reserved.
//

#import "AbstractTableViewCell.h"
#import "PointTreeOnlyOneModel.h"
#import "CompositePointTreeModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface PointsTreeTableViewCell : UITableViewCell
/**
 cell数据Model
 */
@property (nonatomic, strong) PointTreeOnlyOneModel *treeModel;


@property (nonatomic, strong) CompositePointTreeModel *compositetreeModel;

/**
 展开点击block
 */
@property (nonatomic, copy) void(^spreadBtnBlock)(void);
@end

NS_ASSUME_NONNULL_END
