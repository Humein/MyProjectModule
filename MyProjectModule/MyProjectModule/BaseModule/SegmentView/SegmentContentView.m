//
//  SegmentContentView.m
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/6/19.
//  Copyright © 2018年 xinxin. All rights reserved.
//


#import "SegmentContentView.h"
@interface SegmentContentView()<UICollectionViewDelegate,UICollectionViewDataSource>
// Parent VC
@property (nonatomic, weak) UIViewController *parentViewController;
// Child VC
@property (nonatomic, strong) NSArray *childViewControllers;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, assign) NSInteger startOffsetX;
// Previous childVC idnex
@property (nonatomic, assign) NSInteger previousCVCIndex;

@end

@implementation SegmentContentView
static NSString *const cellID = @"cellID";
#pragma mark --- PublicMethod
-(instancetype)initWithFrame:(CGRect)frame parentVC:(UIViewController *)parentVC childVCs:(NSArray *)childVCs{
    if (self = [super initWithFrame:frame]) {
        NSAssert (parentVC != nil || childVCs != nil, @"Must set parent and child VC ");
        self.parentViewController = parentVC;
        self.childViewControllers = childVCs;
        
        [self initData];
        [self setupSubviews];
    }
    return self;
    
}

- (void)setPageContentCollectionViewCurrentIndex:(NSInteger)currentIndex{
    CGFloat offsetX = currentIndex * self.collectionView.frame.size.width;
    // process content offset
    if (_previousCVCIndex != currentIndex) {
        self.collectionView.contentOffset = CGPointMake(offsetX, 0);
    }
    _previousCVCIndex = currentIndex;
    if (self.delegateSegmentContent && [self.delegateSegmentContent respondsToSelector:@selector(segmentContentView:offsetX:)]) {
        [self.delegateSegmentContent segmentContentView:self offsetX:offsetX];
    }
}


#pragma mark ----Delegate
//UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.childViewControllers.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];

    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    UIViewController *childVC = self.childViewControllers[indexPath.item];
    [self.parentViewController addChildViewController:childVC];
    [cell.contentView addSubview:childVC.view];
    childVC.view.frame = cell.contentView.frame;
    [childVC didMoveToParentViewController:self.parentViewController];
    return cell;
}

//UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _startOffsetX = scrollView.contentOffset.x;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat offsetX = scrollView.contentOffset.x;
//    mark last childVC index
    _previousCVCIndex = offsetX / scrollView.frame.size.width;
    
    if (self.delegateSegmentContent && [self.delegateSegmentContent respondsToSelector:@selector(segmentContentView:offsetX:)]) {
        [self.delegateSegmentContent segmentContentView:self offsetX:offsetX];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    CGFloat offsetX = scrollView.contentOffset.x;
    // pageContentCollectionView:offsetX:
    if (self.delegateSegmentContent && [self.delegateSegmentContent respondsToSelector:@selector(segmentContentView:offsetX:)]) {
        [self.delegateSegmentContent segmentContentView:self offsetX:offsetX];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    CGFloat progress = 0;
    NSInteger originalIndex = 0;
    NSInteger targetIndex = 0;
    // Left Scorll OR Right Scorll
    CGFloat currentOffsetX = scrollView.contentOffset.x;
    CGFloat scrollViewW = scrollView.bounds.size.width;
    if (currentOffsetX > _startOffsetX) { // Left
        
        progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW);
        originalIndex = currentOffsetX / scrollViewW;
        targetIndex = originalIndex + 1;
        
        if (targetIndex >= self.childViewControllers.count) {
            progress = 1;
            targetIndex = originalIndex;
        }
        
        if (currentOffsetX - _startOffsetX == scrollViewW) {
            progress = 1;
            targetIndex = originalIndex;
        }
    } else { // Right
        
        progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW));
        targetIndex = currentOffsetX / scrollViewW;
        originalIndex = targetIndex + 1;
        
        if (originalIndex >= self.childViewControllers.count) {
            originalIndex = self.childViewControllers.count - 1;
        }
    }
    // transfer the offset／originalIndex／targetIndex   TitleView
    if (self.delegateSegmentContent && [self.delegateSegmentContent respondsToSelector:@selector(segmentContentView:offset:originalIndex:targetIndex:)]) {
        [self.delegateSegmentContent segmentContentView:self offset:progress originalIndex:originalIndex targetIndex:targetIndex];
    }
}


#pragma mark ---PrivateMethod
- (void)initData {
    _startOffsetX = 0;
    _previousCVCIndex = -1;
}

- (void)setupSubviews {
    // 0、处理偏移量
    UIView *tempView = [[UIView alloc] initWithFrame:CGRectZero];
    [self addSubview:tempView];
    // 1、添加UICollectionView, 用于在Cell中存放控制器的View
    [self addSubview:self.collectionView];
}

#pragma mark ---GetSet
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = self.bounds.size;
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        CGFloat collectionViewX = 0;
        CGFloat collectionViewY = 0;
        CGFloat collectionViewW = self.frame.size.width;
        CGFloat collectionViewH = self.frame.size.height;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(collectionViewX, collectionViewY, collectionViewW, collectionViewH) collectionViewLayout:flowLayout];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.pagingEnabled = YES;
        _collectionView.bounces = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellID];
    }
    return _collectionView;
}
- (void)setIsScrollEnabled:(BOOL)isScrollEnabled {
    _isScrollEnabled = isScrollEnabled;
    if (isScrollEnabled) {
        _collectionView.scrollEnabled = YES;
    } else {
        _collectionView.scrollEnabled = NO;
    }
}
@end
