//
//  AbstractView.h
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/6/27.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AbstractFCollectionView;
@protocol  CollectionViewDelegate <NSObject>

@optional
- (void)ABScollectionView:(AbstractFCollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
@end

@protocol CollectionViewDataSource <NSObject>
- (void)ABScell:(UICollectionViewCell *)cell cellForItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface AbstractFCollectionView : UIView
@property (nonatomic,weak)id <CollectionViewDelegate>delegate;
@property (nonatomic,weak)id <CollectionViewDataSource>dataSource;
//初始化
-(void)initViewWithFlowLayout:(UICollectionViewFlowLayout *)flowLayout ;
//注册cell
- (void)registCell:(Class )cellClass forItem:(Class )itemClass;
//注册头ReusableView
- (void)registHeaderReusableView:(Class )cellClass forItem:(Class )itemClass;
//刷新
-(void)reloadDataWithArray:(NSArray *)array;
@end
