//
//  SegmentContentCell.m
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/7/7.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import "SegmentContentCell.h"

@implementation SegmentContentCell
- (void)configureWithViewController:(UIViewController *)childVC parentViewController:(UIViewController *)parentVC
{
    [parentVC addChildViewController:childVC];
    [self.contentView addSubview:childVC.view];
    childVC.view.frame = self.contentView.bounds;
    childVC.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [childVC didMoveToParentViewController:parentVC];
}

- (BOOL)isOwnerOfViewController:(UIViewController *)viewController
{
    return viewController.view.superview == self.contentView;
}
@end
