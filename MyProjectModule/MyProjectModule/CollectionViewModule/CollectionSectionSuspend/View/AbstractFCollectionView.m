//
//  AbstractView.m
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/6/27.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import "AbstractFCollectionView.h"
@interface AbstractFCollectionView()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{
    
}
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)NSMutableArray *sectionDataArray;

@end
@implementation AbstractFCollectionView
-(void)initViewWithFlowLayout:(UICollectionViewFlowLayout *)flowLayout{
    
    if (flowLayout) {
        _flowLayout = flowLayout;
    }else{
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
        flowLayout.itemSize=CGSizeMake(self.frame.size.width, self.frame.size.height);
        flowLayout.minimumInteritemSpacing = 0.0;
        flowLayout.minimumLineSpacing=0.0;
        flowLayout.sectionInset=UIEdgeInsetsMake(0, 0, 0, 0);
        _flowLayout = flowLayout;
    }
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:_flowLayout];
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.bounces = NO;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    self.collectionView = collectionView;
    [self addSubview:collectionView];
    
}

- (void)registHeaderReusableView:(Class )cellClass forItem:(Class )itemClass{
    [self.collectionView registerClass:cellClass forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass(itemClass)];
    
}

- (void)registCell:(Class )cellClass forItem:(Class )itemClass{
    [self.collectionView registerClass:cellClass forCellWithReuseIdentifier:NSStringFromClass(itemClass)];
}

-(void)reloadDataWithArray:(NSArray *)array{
    self.dataArray = [array copy];
}


#pragma mark --- Delegate
/** 返回有多少组  TODO */
//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
//{
//    return self.sectionDataArray.count;
//
//}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
    
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    id item = [self.dataArray objectAtIndex:indexPath.row];
    UICollectionViewCell *cell= [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([item class]) forIndexPath:indexPath];
    [self.dataSource ABScell:cell cellForItemAtIndexPath:indexPath];
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(ABScollectionView:didSelectItemAtIndexPath:)]) {
        [self.delegate ABScollectionView:self didSelectItemAtIndexPath:indexPath];
    }
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

#pragma mark - 头部或者尾部视图 TODO
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    if (kind == UICollectionElementKindSectionHeader) {
        id item = [self.sectionDataArray objectAtIndex:indexPath.row];
        UICollectionReusableView *headerRV = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass([item class] )forIndexPath:indexPath];
        return headerRV;
        
    }else
    {
        return nil;
    }
    
}



@end
