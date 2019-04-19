//
//  CheckConditionCollectionViewCell.h
//  benkelaile-iOS
//
//  Created by Zhang Xin Xin on 2019/4/19.
//  Copyright © 2019 sunlands. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CheckConditionCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *subLineLabel;

@property (nonatomic,strong) UILabel *nameLable;

@property (nonatomic,assign) BOOL select;

@end

NS_ASSUME_NONNULL_END
