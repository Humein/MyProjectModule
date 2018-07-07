//
//  SegmentContentCell.h
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/7/7.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SegmentContentCell : UICollectionViewCell

@property (nonatomic) NSIndexPath* indexPath;

- (void)configureWithViewController:(UIViewController*)childVC parentViewController:(UIViewController*)parentVC;

- (BOOL)isOwnerOfViewController:(UIViewController*)viewController;

@end
