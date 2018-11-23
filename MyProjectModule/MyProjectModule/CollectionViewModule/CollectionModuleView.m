//
//  CollectionModuleView.m
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/6/13.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import "CollectionModuleView.h"
#import "CarouselLayout.h"
#import "WaterfallLayout.h"
#import "FilterCollectionViewLayout.h"
@class FilterTeacherItem;
@interface CollectionModuleView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate,filterLayoutDeleaget>
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)NSMutableArray *dataArray;

@end
@implementation CollectionModuleView



#pragma mark --- Method
- (void)registCell:(Class)cellClass forItem:(Class)itemClass
{
    [self.collectionView registerClass:cellClass forCellWithReuseIdentifier:NSStringFromClass(itemClass)];
}


- (void)reloadData
{
    self.dataArray = [[self.dataSource autoViewlistItems:self] mutableCopy];
    [self.collectionView reloadData];

}



#pragma mark --- Delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(autoViewSelectCellForIndexPath:inAutoView:)]) {
        [self.delegate autoViewSelectCellForIndexPath:indexPath inAutoView:self];
    }
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}


- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    id item = [self.dataArray objectAtIndex:indexPath.row];
    UICollectionViewCell *cell= [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([item class]) forIndexPath:indexPath];
    [self.dataSource cell:cell cellForItemAtIndexPath:indexPath];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}



#pragma mark --- LazyLoad
- (UICollectionView*)collectionView
{
    if (_collectionView== nil) {
        
//        正常
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
        flowLayout.itemSize=CGSizeMake(self.frame.size.width, self.frame.size.height);
        flowLayout.minimumInteritemSpacing = 0.0;
        flowLayout.minimumLineSpacing=0.0;
        flowLayout.sectionInset=UIEdgeInsetsMake(0, 0, 0, 0);
        
//        旋转木马      
        CarouselLayout *carouselLayout                = [[CarouselLayout alloc] init];
        carouselLayout.carouselSlideIndexBlock          = ^(NSInteger index){
            NSLog(@"index======%ld",(long)index);
        };
        carouselLayout.itemSize                         = CGSizeMake(190, 262);
        
//        瀑布流(标签)
        
//        UICollectionViewFlowLayout *waterLayout = [self setupFlowLayout];  废弃
        FilterCollectionViewLayout * waterFallLayout = [[FilterCollectionViewLayout alloc]init];
        waterFallLayout.delegate = self;
        
        
        
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:waterFallLayout];
        
        
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.dataSource=self;
        _collectionView.bounces=YES;
        _collectionView.delegate=self;
        _collectionView.scrollEnabled=YES;
        

        
        _collectionView.backgroundColor=[UIColor whiteColor];
    }
    return _collectionView;
}


//collectionCell自适应宽度 1
- (UICollectionViewFlowLayout *)setupFlowLayout {
    
    WaterfallLayout *layout = [[WaterfallLayout alloc] init];
    
    layout.estimatedItemSize = CGSizeMake(80, 30);
    
    CGFloat space = 15;
    layout.minimumInteritemSpacing = space;
    layout.minimumLineSpacing = space;
    layout.sectionInset = UIEdgeInsetsMake((10), space, (10), space);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    return layout;
}


- (void)setDirection:(ScrollDirection)direction
{
    UICollectionViewFlowLayout *layout =(UICollectionViewFlowLayout*) self.collectionView.collectionViewLayout;
    if (direction==LToRType || direction==RToLType) {
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }else{
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    }
    _direction = direction;
}

- (void)setPagingEnabled:(BOOL)pagingEnabled{
    _pagingEnabled = pagingEnabled;
    self.collectionView.pagingEnabled = pagingEnabled ? : NO;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.collectionView];
    }
    return self;
}


#pragma mark  - <WaterFallLayoutDeleaget>
- (CGFloat)waterFallLayout:(FilterCollectionViewLayout *)waterFallLayout heightForItemAtIndexPath:(NSUInteger)indexPath itemWidth:(CGFloat)itemWidth{
    
    FilterTeacherItem *deselectModel = self.dataArray[indexPath];
//    deselectModel.h = 30;
//    deselectModel.w = 100;
    return itemWidth * 30 / 100;
}

- (CGFloat)rowMarginInWaterFallLayout:(FilterCollectionViewLayout *)waterFallLayout{
    
    return 20;
    
}

- (NSUInteger)columnCountInWaterFallLayout:(FilterCollectionViewLayout *)waterFallLayout{
    
    return 2;
    
}



@end
