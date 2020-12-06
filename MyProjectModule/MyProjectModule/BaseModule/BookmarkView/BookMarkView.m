//
//  BookMarkView.m
//  benkelaile-iOS
//
//  Created by Zhang Xin Xin on 2019/4/19.
//  Copyright © 2019 sunlands. All rights reserved.
//


#import "BookMarkView.h"
#import "AbstractViewController.h"
#import "Masonry.h"
#import "UIButton+Decorate.h"

/*
 slider是跟着滑动的。所以要检测滑动的偏移量
 */

#define Device_Width ([UIScreen mainScreen].bounds.size.width)

#define Device_Hegiht ([UIScreen mainScreen].bounds.size.height)

static CGFloat BookmarkTagViewDefaultHeight= 40;

static NSString *BookmarkViewContentCellIndentify = @"BookmarkViewContentCellIndentify";

@interface BookmarkContentViewCell()

@end

@implementation BookmarkContentViewCell
// 将子VC的view添加到下面的cell上
- (void)loadContentView:(UIView *)controllerView
{
    
    for (UIView *view in self.subviews) {
        
        if (view == self.contentView) {
            
            
        }else if(view==controllerView){
            
            return;
            
        }else {
            
            [view removeFromSuperview];
        }
    }
    
    NSLog(@"cell中的子试图个数--->:%zi",self.subviews.count);
    
    [self addSubview:controllerView];
    
    [controllerView mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self);
        
    }];
}

//删除cell中其他的view

@end

@interface BookMarkView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) NSMutableArray *tagListArray;

@property (nonatomic,strong) NSMutableArray *contentListArray;

@property (nonatomic,assign) NSInteger beforeIndexPath;

@property (nonatomic,assign) NSInteger afterIndexPath;

@property (nonatomic,assign) NSInteger currentTmpIndex;

@property (nonatomic,assign) NSMutableArray *btnItemsArray;

@property (nonatomic, strong) NSMutableArray *rightButtonsArray;

@property (nonatomic, assign) BOOL keyboardIsVisible;

@end

@implementation BookMarkView

#pragma mark- 获取当前位置

- (NSInteger)currentIndex
{
    return self.currentTmpIndex;
}

#pragma mark- 设置是否可以滑动

- (void)setIsCanScroll:(BOOL)isCanScroll
{
    _isCanScroll = isCanScroll;
    
    self.contentListView.scrollEnabled= _isCanScroll;
    
    self.tagListView.scrollEnabled = YES;
}

#pragma mark- 刷新数据

- (void)reloadData
{
    self.tagListArray = [[self.dataSource bookmarkViewTagListItems:self] mutableCopy];
    self.contentListArray = [[self.dataSource bookmarkViewContentListItems:self] mutableCopy];
    
    if (self.startIndex>= self.tagListArray.count) {
        self.startIndex = 0;
    }
    self.beforeIndexPath = self.startIndex;
    self.afterIndexPath = self.startIndex;
    self.currentTmpIndex = self.startIndex;
    
    [self.contentListView layoutIfNeeded];
    self.contentListView.contentOffset = CGPointMake(self.startIndex*Device_Width, 0);
    
    [self.tagListView reloadData];
    [self.contentListView reloadData];
}

#pragma mark- 绑定上面tagview中的数据

- (void)registTagListCellClass:(Class)cellClass forItemClass:(Class)itemClass
{
    [self.tagListView registerClass:cellClass forCellWithReuseIdentifier:NSStringFromClass(itemClass)];
}

#pragma mark- collectionView的代理，这个代理走的是上下全部的

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // XXTODO 不是一次性加载的核心逻辑 区别上下collectionView代理回调
    if (collectionView == self.tagListView)
    {
        if (self.keyboardIsVisible)
        { // 防止键盘弹出导致的bug
            [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
            sleep(0.45);
            return;
        }
        
        if (self.currentTmpIndex==indexPath.row) {//点击同一个cell
            
            if ([self.delegate respondsToSelector:@selector(bookmarkViewSelectSameCellForTagCellIndexpath:bookmarkView:)]) {
                
                [self.delegate bookmarkViewSelectSameCellForTagCellIndexpath:indexPath bookmarkView:self];
            }
            
        }else{//点击不同的cell
            
            if ([self.delegate respondsToSelector:@selector(bookmarkViewSelectCellForTagCellIndexPath:bookmarkView:)]) {
                [self.delegate bookmarkViewSelectCellForTagCellIndexPath:indexPath bookmarkView:self];
            }
            
            //点击上面的时候，需要滑动下面的,在滑动下面的之后，再去触动上面的变化
            NSIndexPath *tmpIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
            
            self.currentTmpIndex= tmpIndexPath.row;
            
            [self.contentListView scrollToItemAtIndexPath:tmpIndexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
            
            [self updateStyleWithCurrentIndexPath];
        }
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView == self.tagListView) {
        
        return self.tagListArray.count;
        
    }else{
        
        return self.contentListArray.count;
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == self.tagListView) {
        
        return [self.dataSource bookmarkViewSizeForTagCellIndexPath:indexPath bookmarkView:self];
        
    }else{
        
        return [self.dataSource bookmarkViewSizeForContentCellIndexPath:indexPath bookmarkView:self];
    }
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // XXTODO 不是一次性加载的核心逻辑
    if (collectionView == self.tagListView) {
        
        id item = [self.tagListArray objectAtIndex:indexPath.row];
        
        UICollectionViewCell *cell = [self.tagListView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([item class]) forIndexPath:indexPath];
        
        //这里有一个选中和非选中的状态
        if (self.currentTmpIndex == indexPath.row) {
            
            [self.dataSource bookmarkViewTagListCellForItemIndexPath:indexPath cell:cell bookmarkView:self isCurrentIndexPath:YES];
            
        }else{
            
            [self.dataSource bookmarkViewTagListCellForItemIndexPath:indexPath cell:cell bookmarkView:self isCurrentIndexPath:NO];
        }
        return cell;
        
    }else{
        
        BookmarkContentViewCell*cell = [self.contentListView dequeueReusableCellWithReuseIdentifier:BookmarkViewContentCellIndentify forIndexPath:indexPath];
        
        [self.dataSource bookmarkViewContentListCellForItemIndexPath:indexPath bookmarkView:self cell:cell];
        
        return cell;
    }
}

#pragma mark- 即将展示cell

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == self.contentListView) {
        
        NSLog(@"即将显示 %zi",indexPath.row);

        self.beforeIndexPath = indexPath.row;
        
        NSLog(@"当前-->:%zi",self.currentTmpIndex);
        if ([self.delegate respondsToSelector:@selector(bookmarkViewWillDisplayCellForItemIndexPath:bookmarkView:)])
        {
            [self.delegate bookmarkViewWillDisplayCellForItemIndexPath:indexPath bookmarkView:self];
        }
    }
}

#pragma mark- 已经展示了cell

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == self.contentListView) {

        self.afterIndexPath = indexPath.row;

        NSLog(@"显示完毕 %zi",indexPath.row);

        NSLog(@"当前-->:%zi",self.currentTmpIndex);
        
        if (self.beforeIndexPath == self.afterIndexPath) { //是同一个,因为没有滑过来,保持当前值

            self.currentTmpIndex = self.currentTmpIndex;

        }else{//不同的，说明已经滑过来了，使用新值

            self.currentTmpIndex = self.beforeIndexPath;
        }
        
        if (self.currentTmpIndex>= self.contentListArray.count) {
            
            self.currentTmpIndex=0;
        }
        NSLog(@"当前变化成-->:%zi",self.currentTmpIndex);
        
      
        //开始滑动tagList
        [self updateStyleWithCurrentIndexPath];
    }
}


#pragma mark- 业务的处理

- (void)updateStyleWithCurrentIndexPath
{
    //这个是taglist的滑动，如果不对的话，就在这里去找
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.currentTmpIndex inSection:0];
    
    if ([self.delegate respondsToSelector:@selector(bookmarkViewDisPlayCellForItemIndexPath:bookmarkView:)]) {
        [self.delegate bookmarkViewDisPlayCellForItemIndexPath:indexPath bookmarkView:self];
    }
    
    [self.tagListView reloadData];
    
    NSArray *visibleIndexPathArray=[self.tagListView indexPathsForVisibleItems];

    BOOL isHave= NO;

    for (NSIndexPath *tempIndex in visibleIndexPathArray) {

        if (ABS(tempIndex.row - self.currentTmpIndex) < 1) {

            isHave=YES;
        }
    }
    if (isHave==NO) {

        if (self.tagListArray.count>self.currentTmpIndex) {

            [self.tagListView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
        }
    }
}


#pragma mark- 视图的初始化和属性的赋值

- (void)setbuttonItems:(UIButton*)btnItem,...
{
    for (UIButton *btn in self.self.rightButtonsArray)
    {
        [btn removeFromSuperview];
    }
    [self.rightButtonsArray removeAllObjects];
    
    va_list args;
    
    va_start(args, btnItem);
    if (btnItem)
    {
        [self.rightButtonsArray addObject:btnItem];
        
        UIButton *otherItem;
        
        while ((otherItem = va_arg(args, UIButton *)))
        {
            //依次取得所有参数
            if (otherItem==nil) {
                continue;
            }
            [self.rightButtonsArray addObject:otherItem];
        }
    }
    va_end(args);
    
    //全部都是在右边,而且是顺序的
    
    NSInteger count= self.rightButtonsArray.count;
    
    CGFloat width= 10;
    
    for (NSInteger i = count-1;i>=0;i--) {
        
        UIButton *button =[self.rightButtonsArray objectAtIndex:i];
        
        button.tag=1000+i;
        
        [self.tagView addSubview:button];
        
        button.targetAction(self,@selector(rightButtonClick:));
        
        button.layer.shadowColor= [UIColor whiteColor].CGColor;
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self.tagView.mas_centerY);
            make.right.equalTo(self.tagView.mas_right).with.offset(-width);
            make.width.equalTo(@(button.frame.size.width));
            make.height.equalTo(@(button.frame.size.height));
        }];
        
        width= width+button.frame.size.width;
    }
    
    [self.tagListView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.tagView).with.insets(UIEdgeInsetsMake(0, 0, 0, width));
    }];
}

- (void)rightButtonClick:(UIButton*)btn
{
    btn.selected= !btn.selected;
    
    self.rightClickBlock  ? self.rightClickBlock(btn,btn.tag-1000,btn.selected) : nil;
}

- (void)setRightClickBlock:(TopViewRightButtonClickBlock)rightClickBlock
{
    rightClickBlock ? _rightClickBlock = [rightClickBlock copy] : nil;
}

#pragma mark- 默认的加载

- (void)setUpViewInBookmarkView
{
    [self addSubview:self.tagView];
    
    [self.tagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.mas_equalTo(BookmarkTagViewDefaultHeight);
    }];
    
    [self.tagListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.tagView);
    }];
    
    [self addSubview:self.contentListView];
    
    [self.contentListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tagView.mas_bottom);
        make.left.right.bottom.equalTo(self);
    }];
}


- (void)setIsHiddenTagHeaderView:(BOOL)isHiddenTagHeaderView
{
    if (self.tagView.superview==self && self.contentListView.superview==self && isHiddenTagHeaderView) {
        
        [self.tagView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self);
            make.height.mas_equalTo(@0);
        }];
        
        [self.contentListView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.tagView.mas_bottom);
            make.left.right.bottom.equalTo(self);
        }];
    }
}


#pragma mark - KeyBoard Action

- (void)keyboardWillShow
{
    _keyboardIsVisible = YES;
}

- (void)keyboardDidHide
{
    _keyboardIsVisible = NO;
}

- (BOOL)keyboardIsVisible
{
    return _keyboardIsVisible;
}

#pragma mark- 试图的渲染

//视图的加载
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    self.startIndex = 0;
    self.currentTmpIndex= self.startIndex;
    self.beforeIndexPath= self.startIndex;
    self.afterIndexPath= self.startIndex;
    
    //主要是懒加载，我们直接加载一次
    self.contentListView = self.contentListView;
    self.tagListView = self.tagListView;
    
    [self.tagView addSubview:self.tagListView];
   
    [self setUpLineView];
    
    [self.tagListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.tagView);
    }];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center  addObserver:self selector:@selector(keyboardWillShow)  name:UIKeyboardWillShowNotification object:nil];
    [center addObserver:self selector:@selector(keyboardDidHide)  name:UIKeyboardWillHideNotification object:nil];
    return self;
}

- (void)setUpLineView
{
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectZero];
    
    lineView.backgroundColor = [UIColor redColor];
    
    [self.tagView addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.tagView);
        make.height.equalTo(@1);
    }];
}

- (UICollectionView*)contentListView
{
    if (_contentListView == nil) {
        UICollectionViewFlowLayout *flowLayout= [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumInteritemSpacing=0.0f;
        flowLayout.minimumLineSpacing=0.0f;
        
        _contentListView= [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        
        _contentListView.dataSource=self;
        _contentListView.delegate=self;
        
        _contentListView.backgroundColor=[UIColor whiteColor];
        _contentListView.pagingEnabled=YES;
        _contentListView.showsHorizontalScrollIndicator=NO;
        _contentListView.showsVerticalScrollIndicator=NO;
        
        if (@available(iOS 11.0, *)) {
             _contentListView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        //注册一下
        [_contentListView registerClass:[BookmarkContentViewCell class] forCellWithReuseIdentifier:BookmarkViewContentCellIndentify];
    }
    return _contentListView;
}


- (UICollectionView *)tagListView
{
    if (_tagListView==nil) {
        // 这个item宽度是根据字数自己算的。
        UICollectionViewFlowLayout *flowLayout= [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumLineSpacing=0.0f;
        flowLayout.minimumInteritemSpacing=0.0f;
        flowLayout.sectionInset=UIEdgeInsetsMake(0, 0, 0, 1);
        
        _tagListView= [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        
        _tagListView.backgroundColor=[UIColor whiteColor];
        
        _tagListView.dataSource=self;
        _tagListView.delegate=self;
        
        _tagListView.showsHorizontalScrollIndicator=NO;
        _tagListView.showsVerticalScrollIndicator=NO;
        
        if (@available(iOS 11.0, *)) {
            _tagListView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        
    }
    return _tagListView;
}

- (NSArray*)tagListArray
{
    if (_tagListArray== nil) {
        
        _tagListArray = [NSMutableArray new];
    }
    return _tagListArray;
}


- (NSArray*)contentListArray
{
    if (_contentListArray== nil) {
        
        _contentListArray = [NSMutableArray new];
    }
    return _contentListArray;
}


- (UIView*)tagView
{
    if (_tagView == nil) {
        _tagView = [[UIView alloc] initWithFrame:CGRectZero];
        _tagView.backgroundColor = [UIColor whiteColor];
    }
    return _tagView;
}

- (NSMutableArray *)rightButtonsArray
{
    return _rightButtonsArray ? : (_rightButtonsArray = ({
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
        arr;
    }));
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
