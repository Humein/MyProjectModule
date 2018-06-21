//
//  PersonCenterBaseViewController.h
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/6/21.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PersonalCenterChildBaseVCDelegate <NSObject>

- (void)personalCenterChildBaseVCScrollViewDidScroll:(UIScrollView *)scrollView;

@end

@interface PersonalCenterChildViewController : UIViewController
@property (nonatomic, weak) id<PersonalCenterChildBaseVCDelegate> delegatePersonalCenterChildBaseVC;
@end
