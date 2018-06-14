//
//  CollectionModuleView.h
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/6/13.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import <UIKit/UIKit.h>
enum{
    LToRType,//左 -> 右
    RToLType,//右 -> 左
    UToDType,//上 -> 下
    DToUType //下 -> 上
};
typedef NSInteger ScrollDirection;

@class CollectionModuleView;
@protocol  CollectionViewDelegate <NSObject>

@optional

- (void)autoViewSelectCellForIndexPath:(NSIndexPath*)indexPath inAutoView:(CollectionModuleView *)autoView;


- (void)autoViewWillDisplayCellIndexPath:(NSIndexPath*)indexPath inAutoView:(CollectionModuleView *)autoView;




@end

@protocol CollectionViewDataSource <NSObject>
//数据源
- (NSArray*)autoViewlistItems:(CollectionModuleView *)autoView;
//cell的宽高
- (CGSize)autoViewsizeCellIndexPath:(NSIndexPath*)indexPath autoView:(CollectionModuleView *)autoView;

//这里是每个cell和对应的数据的关联
- (void)cell:(UICollectionViewCell *)cell cellForItemAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface CollectionModuleView : UIView
@property (nonatomic,weak)id <CollectionViewDelegate>delegate;
@property (nonatomic,weak)id <CollectionViewDataSource>dataSource;
@property (nonatomic,assign)ScrollDirection direction;//滑动方向
@property (nonatomic,assign)BOOL pagingEnabled;

-(void)reloadData;
//把cell和item对应起来
- (void)registCell:(Class)cellClass forItem:(Class)itemClass;
@end
