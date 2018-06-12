//
//  AbstractTableViewCell.h
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/6/12.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CellModel;
@interface AbstractTableViewCell : UITableViewCell
- (void)updateByItem:(CellModel *)item;
@end
