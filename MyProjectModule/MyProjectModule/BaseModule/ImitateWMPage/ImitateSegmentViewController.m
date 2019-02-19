//
//  ImitateSegmentViewController.m
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/7/7.
//  Copyright © 2018年 xinxin. All rights reserved.
//
#define Screen_Width ([UIScreen mainScreen].bounds.size.width)
#define Screen_Height ([UIScreen mainScreen].bounds.size.height)


#import "ImitateSegmentViewController.h"
#import "SegmentContentCell.h"
#import "SegmentSliderView.h"
#import "UIView+frameAdjust.h"
static CGFloat const kMargin = 20;
static NSString * const kCellID = @"SegmentHorizontalCell";

@interface ImitateSegmentViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,UIScrollViewDelegate>
{
    NSMutableDictionary<NSNumber*, UIViewController*>* _controllerCache;
}
//SlidingBlockContent
@property (nonatomic, strong) UIScrollView *sliderView;
//SegmentContent
@property (nonatomic, strong) UICollectionView *containerView;
//SlidingBlockUnLine
@property (nonatomic, strong) UIView *underline;
@end

@implementation ImitateSegmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _controllerCache = [NSMutableDictionary dictionary];

}


#pragma mark --------Delegate
#pragma - config stretch delegate

- (void)configureStretchScrollViewDelegate
{
    UIViewController *currentViewController = self.childSliderControllers[self.currentIndex];
    UIScrollView *scrollView = [self stretchScrollViewFromViewController:currentViewController];
    scrollView.delegate = self;
}
- (UIScrollView *)stretchScrollViewFromViewController:(UIViewController *)viewController
{
    return [self hasStretchScrollViewWithViewController:viewController] ? [(id<SSliderProtocol>)viewController stretchScrollView] : nil;
}
- (BOOL)hasStretchScrollViewWithViewController:(UIViewController *)viewController
{
    return [viewController conformsToProtocol:@protocol(SSliderProtocol)] &&
    [viewController respondsToSelector:@selector(stretchScrollView)];
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.childSliderControllers.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SegmentContentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellID forIndexPath:indexPath];
    if (cell.indexPath)
    {
        UIViewController* controller = _controllerCache[@(cell.indexPath.item)];
        if (controller != nil && [cell isOwnerOfViewController:controller])
        {
            [self removeViewControllerAtIndex:cell.indexPath.item];
        }
    }
    UIViewController* page = [self viewControllerAtIndex:indexPath.item];
    [cell configureWithViewController:page parentViewController:self];
    cell.indexPath = indexPath;
    return cell;
}

#pragma mark - UICollectionViewDelegate
//Handel gesture conflict
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // Horizontal Scroll collectionView
    if (scrollView == self.containerView)
    {
        CGFloat value = scrollView.contentOffset.x / scrollView.frame.size.width;
        if (value < 0)
            return;
        NSUInteger leftIndex = (int)value;
        NSUInteger rightIndex = leftIndex + 1;
        if (rightIndex >= [self getLabelArrayFromSubviews].count)
            rightIndex = [self getLabelArrayFromSubviews].count - 1;
        CGFloat scaleRight = value - leftIndex;
        CGFloat scaleLeft  = 1 - scaleRight;
        SegmentSliderView *labelLeft  = [self getLabelArrayFromSubviews][leftIndex];
        SegmentSliderView *labelRight = [self getLabelArrayFromSubviews][rightIndex];
        labelLeft.scale  = scaleLeft;
        labelRight.scale = scaleRight;
        if (scaleLeft == 1 && scaleRight == 0)
            return;
        _underline.centerX = labelLeft.centerX + (labelRight.centerX - labelLeft.centerX) * scaleRight;
        _underline.width = 20;
        // 视图滚动时，使键盘辞去第一响应
        [self.view endEditing:YES];
    }
    else // child's controller scrollView scroll event
    {
        CGFloat maximumContentOffsetY = self.maximumContentOffsetY;
        UIViewController *currentViewController = self.childSliderControllers[self.currentIndex];
        if ([self hasStretchScrollViewWithViewController:currentViewController])
        {
            UIScrollView *currentScrollView = [(id<SSliderProtocol>)currentViewController stretchScrollView];
            if (currentScrollView == scrollView)
            {
                UIScrollView *basicScrollView = self.containerSView;
                CGFloat basicScrollViewContentOffsetY = basicScrollView.contentOffset.y;
                CGFloat scrollViewContentOffsetY = scrollView.contentOffset.y;
                if (basicScrollViewContentOffsetY < 0)
                {
                    basicScrollViewContentOffsetY = 0;
                }
                else if (basicScrollViewContentOffsetY >= 0 && basicScrollViewContentOffsetY < maximumContentOffsetY)
                {
                    if (basicScrollViewContentOffsetY == 0)
                    {
                        if (scrollViewContentOffsetY > 0)
                        {
                            basicScrollViewContentOffsetY += scrollViewContentOffsetY;
                        }
                    }
                    else
                    {
                        basicScrollViewContentOffsetY += scrollViewContentOffsetY;
                        scrollViewContentOffsetY = 0;
                    }
                }
                else
                {
                    if (scrollViewContentOffsetY < 0)
                    {
                        basicScrollViewContentOffsetY += scrollViewContentOffsetY;
                        scrollViewContentOffsetY = 0;
                    }
                    else
                    {
                        basicScrollViewContentOffsetY = maximumContentOffsetY;
                    }
                }
                basicScrollView.contentOffset = CGPointMake(basicScrollView.contentOffset.x, basicScrollViewContentOffsetY);
                scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, scrollViewContentOffsetY);
            }
            else
            {
                if (scrollView == self.containerSView)
                    if (self.containerSView.contentOffset.y > maximumContentOffsetY)
                        self.containerSView.contentOffset = CGPointMake(self.containerSView.contentOffset.x, maximumContentOffsetY);
            }
        }
        else
        {
            if (scrollView == self.containerSView)
                if (self.containerSView.contentOffset.y > maximumContentOffsetY)
                    self.containerSView.contentOffset = CGPointMake(self.containerSView.contentOffset.x, maximumContentOffsetY);
        }
    }
}
/** 手指滑动containerView，滑动结束后调用 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:self.containerView])
    {
        [self scrollViewDidEndScrollingAnimation:scrollView];
    }
    [self configureStretchScrollViewDelegate];
}

/** 手指点击sliderView */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    NSUInteger index = scrollView.contentOffset.x / self.containerView.width;
    NSArray *array = [self getLabelArrayFromSubviews];
    if (!array) return;
    
    SegmentSliderView *titleLable = array[index];
    
    CGFloat offsetx = 0.f;
    SegmentSliderView *lastLabel = [[self getLabelArrayFromSubviews] objectAtIndex:self.childSliderControllers.count -1];
    if (lastLabel.x + lastLabel.width > _sliderView.width)
        offsetx = titleLable.center.x - _sliderView.width * 0.5;
    CGFloat offsetMax = fabs(_sliderView.contentSize.width - _sliderView.width);
    if (offsetx < 0)
        offsetx = 0;
    if (offsetx > offsetMax)
        offsetx = offsetMax;
    [_sliderView setContentOffset:CGPointMake(offsetx, 0) animated:YES];
    for (SegmentSliderView *label in [self getLabelArrayFromSubviews])
        label.textColor = [UIColor blackColor];
    
    // __strong and __weak
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.35 animations:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf->_underline.width = 20;
        strongSelf->_underline.centerX = titleLable.centerX;
        titleLable.textColor = [UIColor redColor];
    }];
    
    _currentIndex = index;
    if (self.sliderDelegate)
        [self.sliderDelegate sliderViewDidChangedCurrentIndex:_currentIndex];
    
    // 配置自视图的代理
    [self configureStretchScrollViewDelegate];
}


#pragma mark ---PrivateMethod

- (void)labelClick:(UITapGestureRecognizer *)recognizer
{
    SegmentSliderView *label = (SegmentSliderView *)recognizer.view;
    [_containerView setContentOffset:CGPointMake(label.tag * _containerView.frame.size.width, 0)];
    [self scrollViewDidEndScrollingAnimation:self.containerView];
}


/** 获取sliderview中所有的label，合成一个数组，因为sliderview.subViews中有其他非Label元素 */
- (NSArray *)getLabelArrayFromSubviews
{
    NSMutableArray *arrayM = [NSMutableArray array];
    for (SegmentSliderView *label in _sliderView.subviews)
    {
        if ([label isKindOfClass:[SegmentSliderView class]])
            [arrayM addObject:label];
    }
    return arrayM.copy;
}

- (void)refreshCache
{
    for (UIViewController* controller in _controllerCache.allValues)
    {
        [controller willMoveToParentViewController:nil];
        [controller.view removeFromSuperview];
        [controller removeFromParentViewController];
    }
    [_controllerCache removeAllObjects];
}

- (void)resetChannelLabel
{
    for (UIView * view  in [_sliderView subviews]) {
        [view removeFromSuperview];
    }
    [_sliderView removeFromSuperview];
    _sliderView = nil;
    
    if (![self.sliderView.subviews containsObject:self.sliderView])
        [self.containerSView addSubview:self.sliderView];
    
    if (![self.sliderView.subviews containsObject:self.containerView])
        [self.containerSView addSubview:self.containerView];
}

- (UIViewController *)viewControllerAtIndex:(NSInteger)index
{
    UIViewController* result = _controllerCache[@(index)];
    if (result == nil)
    {
        result = self.childSliderControllers[index];
        _controllerCache[@(index)] = result;
    }
    return result;
}


- (void)removeViewControllerAtIndex:(NSInteger)index
{
    UIViewController* controller = _controllerCache[@(index)];
    if (controller)
    {
        [controller willMoveToParentViewController:nil];
        [controller.view removeFromSuperview];
        [controller removeFromParentViewController];
        [_controllerCache removeObjectForKey:@(index)];
    }
}
- (void)setupChannelLabel
{
    CGFloat x = 8;
    CGFloat h = _sliderView.bounds.size.height;
    int i = 0;
    
    for (UIViewController <SSliderProtocol>* vc  in self.childSliderControllers)
    {
        SegmentSliderView *label = [SegmentSliderView sliderLabelWithTitle:[vc sliderContentString]];
        label.frame = CGRectMake(x, 0, label.width + kMargin, h);
        [_sliderView addSubview:label];
        x += label.bounds.size.width;
        label.tag = i++;
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick:)]];
    }
    _sliderView.contentSize = CGSizeMake(x, 0);
}

- (void)setupChildView
{
    [self.view addSubview:self.containerSView];
    if (@available(iOS 11.0, *))
        self.containerView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    else
        self.automaticallyAdjustsScrollViewInsets = NO;
    if (![self.sliderView.subviews containsObject:self.containerView])
        [self.containerSView addSubview:self.containerView];
    if (![self.sliderView.subviews containsObject:self.sliderView])
        [self.containerSView addSubview:self.sliderView];
}

#pragma mark ---PublicMethod
- (void)reloadPages
{
    if (self.childSliderControllers.count)
        self.currentIndex = 0;
    [self refreshCache];
    [self resetChannelLabel];
    [self.containerView reloadData];
    // 配置子视图代理
    [self configureStretchScrollViewDelegate];
}

- (void)scrollToIndex:(NSInteger)index {
    if(index >= [self.containerView numberOfItemsInSection:0])return;
    [self.containerView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
}

#pragma mark ---set
- (void)setChildSliderControllers:(NSArray<__kindof UIViewController *> *)childSliderControllers
{
    _childSliderControllers = childSliderControllers;
    [self setupChildView];
    // 配置代理
    [self configureStretchScrollViewDelegate];
}

- (void)setCurrentIndex:(NSInteger)currentIndex
{
    _currentIndex = currentIndex;
    NSAssert(self.childSliderControllers.count > _currentIndex, @"Can't set currentIndex beyong the number of childSliderControllers");
    [_containerView setContentOffset:CGPointMake(_currentIndex * _containerView.frame.size.width, 0)];
    [self scrollViewDidEndScrollingAnimation:self.containerView];
}

#pragma mark ---get


- (UIScrollView *)sliderView
{
    if (_sliderView == nil)
    {
        _sliderView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.headerHeight, Screen_Width, 44)];
        _sliderView.tag = 100;
        _sliderView.backgroundColor = [UIColor whiteColor];
        _sliderView.showsHorizontalScrollIndicator = NO;
        [self setupChannelLabel];
        // 设置下划线
        if ([self getLabelArrayFromSubviews].count != 0)
        {
            [_sliderView addSubview:({
                SegmentSliderView *firstLabel = [self getLabelArrayFromSubviews][0];
                firstLabel.textColor = [UIColor redColor];
                _underline = [[UIView alloc] initWithFrame:CGRectMake(0, 42, 20, 2)];
                _underline.centerX = firstLabel.centerX;
                _underline.backgroundColor = [UIColor redColor];
                _underline;
            })];
        }
    }
    return _sliderView;
}


- (UICollectionView *)containerView
{
    if (_containerView == nil)
    {
        CGFloat tabBarH = 49;
        CGFloat naviBarH = 64.f;
        CGFloat h = Screen_Height - naviBarH - self.sliderView.height;
        CGRect frame = CGRectMake(0, self.sliderView.y + self.sliderView.height, Screen_Width, h);
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _containerView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:flowLayout];
        _containerView.backgroundColor = [UIColor whiteColor];
        _containerView.delegate = self;
        _containerView.dataSource = self;
        [_containerView registerClass:[SegmentContentCell class] forCellWithReuseIdentifier:kCellID];
        // 设置cell的大小和细节
        flowLayout.itemSize = _containerView.bounds.size;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 0;
        _containerView.pagingEnabled = YES;
        _containerView.showsHorizontalScrollIndicator = NO;
    }
    return _containerView;
}


- (UIScrollView *)containerSView
{
    if (_containerSView == nil)
    {
        _containerSView = [[UIScrollView alloc] initWithFrame:self.view.frame];
        _containerSView.backgroundColor = [UIColor whiteColor];
        _containerSView.delegate = self;
        _containerSView.showsHorizontalScrollIndicator = NO;
        _containerSView.showsVerticalScrollIndicator = NO;
        _containerSView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height + self.headerHeight);
    }
    return _containerSView;
}

- (CGFloat)maximumContentOffsetY
{
    return floor(self.headerHeight);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
