//
//  AbstractTableViewCell.m
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/6/12.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import "AbstractTableViewCell.h"
#import "CellModel.h"
#import "NSTimerObserver.h"
@implementation AbstractTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)updateByItem:(CellModel *)item
{
    self.textLabel.text = item.title;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
