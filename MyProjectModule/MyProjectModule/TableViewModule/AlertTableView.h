//
//  AlertTableView.h
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/6/12.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AlertTableView;

@protocol AlertTableViewDelegate <NSObject>

//提供数据源
- (NSMutableArray*)alertTableVieItemList;
//每一个cell 的高度
- (CGFloat)alertTableView:(AlertTableView *)alertTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
//配置数据
- (void)alertTableViewCell:(UITableViewCell*)cell forRowAtIndexPath:(NSIndexPath*)indexPath;
@optional
-(UIView*)alertTableHeaderView:(AlertTableView*)alertTableView headerForSection:(NSInteger)section;

-(CGFloat)alertTableHeaderView:(AlertTableView*)alertTableView headerHeightForSection:(NSInteger)section;
@end
enum{
    AlertFadeType,//渐变的显示方式
    AlertSliderType//滑动的方式显示
};
typedef NSInteger AlertShowType;

typedef void (^SelectIndexBlock)(NSIndexPath *indexPath);
typedef void (^TapCompletionBlock)(BOOL isTap);

@interface AlertTableView : UIView
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,assign)CGRect tableViewFrame;
@property (nonatomic,weak)id <AlertTableViewDelegate>delegate;
@property (nonatomic,strong)SelectIndexBlock selectBlock; //点击cell
@property (nonatomic,strong)TapCompletionBlock tapBlock;  //点击背景
@property (nonatomic,assign)BOOL isCanScroll;//是否可以滚动
@property (nonatomic,assign)BOOL isSelectIndexToHidden;//是否点击了indexPath就关闭
@property (nonatomic,assign)CGPoint FromPoint; //从哪里开始展示
@property (nonatomic,assign)AlertShowType showType;//显示方式




//注册cell和item的对应关系

- (void)registCell:(Class)cellClass forItem:(Class)itemClass;

//显示在window上的

- (void)show;

//显示在view中
- (void)showInView:(UIView*)view;

//刷新数据
- (void)reloadData;

//隐藏
- (void)hidden;
@end
