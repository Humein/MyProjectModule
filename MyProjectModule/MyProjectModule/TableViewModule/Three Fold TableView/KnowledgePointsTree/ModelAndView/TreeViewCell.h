//
//  TreeViewCell.h
//  KnowledgeTree
//
//  Created by 鑫鑫 on 2017/4/12.
//  Copyright © 2017年 xinxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TreeViewModel.h"
#define UICOLOR_RGB_Alpha(_color,_alpha) [UIColor colorWithRed:((_color>>16)&0xff)/255.0f green:((_color>>8)&0xff)/255.0f blue:(_color&0xff)/255.0f alpha:_alpha]
#define UIColorFromRGBA(rgbValue, alphaValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:alphaValue]
#define UI_IS_IPAD              ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
#define UI_IS_IPHONE            ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
@protocol QuestionTableViewCellDelegate <NSObject>
@optional
-(void)checkClick:(TreeViewModel *)viewModel;
-(void)restartClick:(TreeViewModel *)viewModel;

@end

@interface TreeViewCell : UITableViewCell

@property(nonatomic,strong) TreeViewModel *cellViewModel;
@property(nonatomic,assign) id<QuestionTableViewCellDelegate> delegate;

-(void)refreshCellWithViewModel:(TreeViewModel *)viewModel;

+(CGFloat)heightForCell;
@end
