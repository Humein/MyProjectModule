//
//  CollectionDetaiDemo.m
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/6/26.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import "CollectionDetaiDemo.h"
#import "SectionFModel.h"
#import "JHBodyCell.h"
#import "JHHeaderReusableView.h"
static NSString *const kBodyID = @"JHBodyCell";
static NSString *const kHeaderID = @"JHHeaderReusableView";
@interface CollectionDetaiDemo()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{
    
}
/** collectionView  */
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) UICollectionViewFlowLayout *flowLayout;

/** 保存模型属性的数组  */
@property (nonatomic, strong) NSMutableArray *bodyArray;

@end
@implementation CollectionDetaiDemo


-(void)reloadDataWithFlowLayout:(UICollectionViewFlowLayout *)flowLayout{

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
    
    //注册
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([JHBodyCell class]) bundle:nil] forCellWithReuseIdentifier:kBodyID];
    //注册头部视图
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([JHHeaderReusableView class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHeaderID];
}
#pragma mark - UICollectionViewDataSource
/** 返回有多少组  */
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.bodyArray.count;
    
}

/** 返回每组有多少个item  */
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    //每组的模型
    SectionFModel *home = self.bodyArray[section];
    
    return home.body.count;
    
}
/** 返回每个item的具体内容  */
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JHBodyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kBodyID forIndexPath:indexPath];
    
    //组模型
    SectionFModel *home = self.bodyArray[indexPath.section];
    
    //行模型
    CellFModel *body = home.body[indexPath.row];
    
    cell.bodyModel = body;
    
    return cell;
}


#pragma mark - UICollectionViewDelegate
//点击collectionView的item的时候调用
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(autoViewSelectCellForIndexPath:inAutoView:)]) {
        [self.delegate autoViewSelectCellForIndexPath:indexPath inAutoView:self];
    }
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

#pragma mark - 头部或者尾部视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    //如果是头部视图
    if (kind == UICollectionElementKindSectionHeader) {
        JHHeaderReusableView *headerRV = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kHeaderID forIndexPath:indexPath];
        headerRV.homeModel = self.bodyArray[indexPath.section];
        return headerRV;
        
    }else
    {
        return nil;
    }
    
}



#pragma mark -----UICollectionViewDelegateFlowLayout

#pragma mark -header cell footer大小
//单独定制item的尺寸
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    return CGSizeMake(_itemWidth, _itemWidth);
//}


//定义每个UICollectionView的margin(间距),对每一个section单独设置边界，即内部cell上下左右距离header和footer的边界（间距）
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
//
//    return UIEdgeInsetsMake(0, 5, 0, 5);
//}



//单独定制每行之间的间距
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
//
//    return 5;
//}

//单独定制每行item之间的间距
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
//    return MarginX;
//}



//单独定制头部视图size

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
//
//    return CGSizeMake(0, 0);
//}
//单独定制脚注视图size

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
//
//    return CGSizeMake(0, 0);
//}





#pragma mark -- get&Set
- (NSMutableArray *)bodyArray
{
    if (!_bodyArray) {
        
        //保存模型的数组
        NSMutableArray *temp = [NSMutableArray array];
        //字典转模型
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"HomeDatas" ofType:@"plist"]];
        for (NSDictionary *dict in dictArray) {
            SectionFModel *home = [SectionFModel homeWithDict:dict];
            [temp addObject:home];
        }
        _bodyArray = temp;
    }
    
    return _bodyArray;
}
@end
