//
//  SLSliderContentCell.h
//  SLSliderControl
//
//  Created by iforvert on 2017/11/30.
//  Copyright © 2017年 iforvert. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLSliderContentCell : UICollectionViewCell

@property (nonatomic) NSIndexPath* indexPath;

- (void)configureWithViewController:(UIViewController*)childVC parentViewController:(UIViewController*)parentVC;

- (BOOL)isOwnerOfViewController:(UIViewController*)viewController;

@end
