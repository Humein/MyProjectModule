//
//  ClassClusterBaseTableViewCell.h
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2019/1/16.
//  Copyright © 2019 xinxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "ClassClusterModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ClassClusterBaseTableViewCell : UITableViewCell

+ (instancetype)cellWithType:(XXClassClusterType)type;

- (void)setModel:(ClassClusterModel *)model;
@end

NS_ASSUME_NONNULL_END
