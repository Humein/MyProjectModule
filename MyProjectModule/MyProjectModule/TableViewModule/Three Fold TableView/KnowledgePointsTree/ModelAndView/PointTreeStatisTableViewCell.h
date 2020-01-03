//
//  PointTreeStatisTableViewCell.h
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2018/11/5.
//  Copyright © 2018 xinxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PointTreeModel.h"

@interface PointTreeStatisTableViewCell : UITableViewCell
/**
 白天、黑夜模式
 */
@property (nonatomic, assign) BOOL isDay;
/**
 cell数据Model
 */
@property (nonatomic, strong) PointTreeModel *treeModel;
/**
 展开点击block
 */
@property (nonatomic, copy) void(^spreadBtnBlock)(void);
@end
