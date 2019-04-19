
//
//  SmoothTitleView.m
//  benkelaile-iOS
//
//  Created by Zhang Xin Xin on 2019/4/19.
//  Copyright © 2019 sunlands. All rights reserved.
//

#import "SmoothTitleView.h"
#import <Masonry/Masonry.h>
#define Font(a) [UIFont systemFontOfSize:(a)]
#define HexColor(value,a)   [UIColor colorWithRed:((value & 0xFF0000) >> 16)/255.0 green:((value & 0x00FF00) >> 8)/255.0 blue:(value & 0x0000FF)/255.0 alpha:(a)]

/*
 slider是跟着滑动的。所以要检测滑动的偏移量
 */

#define Device_Width ([UIScreen mainScreen].bounds.size.width)

#define Device_Hegiht ([UIScreen mainScreen].bounds.size.height)

static NSString *BookmarkViewContentCellIndentify = @"BookmarkViewContentCellIndentify";

@interface BookmarkTagViewCell()

@end

@implementation BookmarkTagViewCell

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

@interface SmoothTitleView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) NSMutableArray *tagListArray;

@property (nonatomic,strong) NSMutableArray *contentListArray;

@property (nonatomic,assign) NSInteger beforeIndexPath;

@property (nonatomic,assign) NSInteger afterIndexPath;

@property (nonatomic,assign) NSMutableArray *btnItemsArray;

@property (nonatomic, strong) NSMutableArray *rightButtonsArray;

@property (nonatomic, assign) BOOL keyboardIsVisible;

@end

@implementation SmoothTitleView

#pragma mark- 获取当前位置

- (NSInteger)currentIndex
{
    return self.currentTmpIndex;
}

#pragma mark- 刷新数据

- (void)reloadData
{
    self.tagListArray = [[self.dataSource bookmarkViewTagListItems:self] mutableCopy];
    
    if (self.startIndex>= self.tagListArray.count) {
        self.startIndex = 0;
    }
    self.beforeIndexPath = self.startIndex;
    self.afterIndexPath = self.startIndex;
    self.currentTmpIndex = self.startIndex;
    
    [self.tagListView reloadData];
}

#pragma mark- 绑定上面tagview中的数据

- (void)registTagListCellClass:(Class)cellClass forItemClass:(Class)itemClass
{
    [self.tagListView registerClass:cellClass forCellWithReuseIdentifier:NSStringFromClass(itemClass)];
}


#pragma mark- collectionView的代理，这个代理走的是全部的

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.keyboardIsVisible)
    {
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
        
        [self updateStyleWithCurrentIndexPath];
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
    
    return [self.dataSource bookmarkViewSizeForTagCellIndexPath:indexPath bookmarkView:self];
    
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    id item = [self.tagListArray objectAtIndex:indexPath.row];
    
    UICollectionViewCell *cell = [self.tagListView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([item class]) forIndexPath:indexPath];
    
    //这里有一个选中和非选中的状态
    if (self.currentTmpIndex == indexPath.row) {
        
        [self.dataSource bookmarkViewTagListCellForItemIndexPath:indexPath cell:cell bookmarkView:self isCurrentIndexPath:YES];
        
    }else{
        
        [self.dataSource bookmarkViewTagListCellForItemIndexPath:indexPath cell:cell bookmarkView:self isCurrentIndexPath:NO];
    }
    return cell;
}


#pragma mark- 业务的处理

- (void)updateStyleWithCurrentIndexPath
{
    //这个是taglist的滑动，如果不对的话，就在这里去找
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.currentTmpIndex inSection:0];
    
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
    
    CGFloat width= 0;
    
    for (NSInteger i = count-1;i>=0;i--) {
        
        UIButton *button =[self.rightButtonsArray objectAtIndex:i];
        
        button.tag=1000+i;
        
        [self.tagView addSubview:button];
        
        [button addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchDown];
        
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
        make.edges.equalTo(self);
    }];
    
    [self.tagListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.tagView);
    }];
}


- (void)setIsHiddenTagHeaderView:(BOOL)isHiddenTagHeaderView
{
    if (self.tagView.superview==self && isHiddenTagHeaderView) {
        
        [self.tagView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self);
            make.height.mas_equalTo(@0);
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
    
    lineView.backgroundColor = HexColor(0xf1f1f1, 1);
    
    [self.tagView addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.tagView);
        make.height.equalTo(@1);
    }];
}

- (UICollectionView*)tagListView
{
    if (_tagListView==nil) {
        
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
