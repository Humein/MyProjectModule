//
//  PopTableView.h
//  AnimationCollection
//
//  Created by 鑫鑫 on 2018/5/2.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MatchesSwitchMdoel;

@protocol MatchesSwitchMdoelCellDelegate <NSObject>

-(void)cellClick:(MatchesSwitchMdoel *)viewModel;

@end
@interface PopTableView : UIView
@property(nonatomic,assign) id<MatchesSwitchMdoelCellDelegate> delegate;
- (instancetype)initWithFrame:(CGRect)frame dataSource:(NSArray<NSArray *> *)dataSource withBGView:(NSString *)bgView;
-(void)show;
-(void)dismiss;
@end
