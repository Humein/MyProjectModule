//
//  CollectionDetaiDemo.h
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/6/26.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CollectionDetaiDemo;
@protocol  CollectionViewDelegate <NSObject>

@optional
- (void)autoViewSelectCellForIndexPath:(NSIndexPath*)indexPath inAutoView:(CollectionDetaiDemo *)autoView;



@end

@protocol CollectionViewDataSource <NSObject>
//TODO
@end

@interface CollectionDetaiDemo : UIView


@property (nonatomic,weak)id <CollectionViewDelegate>delegate;
@property (nonatomic,weak)id <CollectionViewDataSource>dataSource;
-(void)initViewWithFlowLayout:(UICollectionViewFlowLayout *)flowLayout;
-(void)reloadDataWithArray:(NSArray *)array;
@end
