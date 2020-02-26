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
#import "AbstractCollectionViewCell.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define SCROLLVIEW_WIDTH SCREEN_WIDTH

#define BaseTag 10

/**
 动画偏移量 是指rightView相对于leftView的偏移量
 */
#define AnimationOffset 100



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



#pragma mark --- 正常Normal-Delegate


// 偏移动画，，，
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat x = scrollView.contentOffset.x;
    
    NSInteger leftIndex = x/SCROLLVIEW_WIDTH;    
    //这里的left和right是区分拖动中可见的两个视图
    AbstractCollectionViewCell * leftView = [scrollView viewWithTag:(leftIndex + BaseTag)];
    AbstractCollectionViewCell * rightView = [scrollView viewWithTag:(leftIndex + 1 + BaseTag)];
    
    
    //    leftView.contentX = -(SCROLLVIEW_WIDTH - x + (leftIndex * SCROLLVIEW_WIDTH));
    //    rightView.contentX = (SCROLLVIEW_WIDTH + x - ((leftIndex + 1) * SCROLLVIEW_WIDTH));
    
    
    rightView.contentX = -(SCROLLVIEW_WIDTH - AnimationOffset) + (x - (leftIndex * SCROLLVIEW_WIDTH))/SCROLLVIEW_WIDTH * (SCROLLVIEW_WIDTH - AnimationOffset);
    leftView.contentX = ((SCROLLVIEW_WIDTH - AnimationOffset) + (x - ((leftIndex + 1) * SCROLLVIEW_WIDTH))/SCROLLVIEW_WIDTH * (SCROLLVIEW_WIDTH - AnimationOffset));
}





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

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(30, 50);
}


#pragma mark --- LazyLoad
- (UICollectionView*)collectionView
{
    if (_collectionView== nil) {
        
//        正常
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
        flowLayout.itemSize=CGSizeMake(self.frame.size.width, self.frame.size.height);
        flowLayout.minimumInteritemSpacing = 23.0;
//        flowLayout.minimumLineSpacing=0.0;
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
        
        
        
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:carouselLayout];
        
        
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

//{
//    // Collection容器
//    private lazy var collectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        let itemWidth = (UIScreen.main.bounds.width - 95 - 40 - 20)/2
//        layout.itemSize = CGSize(width: itemWidth, height: 42)
//        layout.minimumLineSpacing = 20
//        layout.scrollDirection =  .vertical
//        layout.sectionInset = UIEdgeInsets(top: 0, left:20, bottom: 20, right:20)
//        
//        let view = UICollectionView(frame: CGRect.init(x:0, y:0, width:UIScreen.main.bounds.width - 95, height:UIScreen.main.bounds.height - 130), collectionViewLayout: layout)
//        view.backgroundColor = .white
//        view.showsVerticalScrollIndicator = true
//        view.register(SDMajorCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "SDMajorCollectionViewCell")
//        view.delegate = self
//        view.dataSource = self
//        return view
//    }()
//    
//    var dataArray = [Any]()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupUI()
//    }
//    
//    func setupUI() {
//        self.view.addSubview(collectionView)
//        collectionView.reloadData()
//    }
//    
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 39
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SDMajorCollectionViewCell", for: indexPath) as! SDMajorCollectionViewCell
//        return cell
//    }
//    
//
//}

@end
