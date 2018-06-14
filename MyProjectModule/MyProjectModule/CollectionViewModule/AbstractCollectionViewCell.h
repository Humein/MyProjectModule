//
//  AbstractCollectionViewCell.h
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/6/13.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CellModel;
@interface AbstractCollectionViewCell : UICollectionViewCell
- (void)updateByItem:(CellModel *)item;

@end
