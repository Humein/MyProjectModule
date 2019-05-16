//
//  DownLoadCell.h
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2019/5/16.
//  Copyright © 2019 xinxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "URLSessionDownManager.h"

NS_ASSUME_NONNULL_BEGIN

#define DownLoadCell_Height         50.0

@interface DownLoadCell : UITableViewCell

@property (strong, nonatomic) XXDownItem *source;

@end

NS_ASSUME_NONNULL_END
