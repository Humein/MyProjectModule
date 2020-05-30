//
//  AbstractBookmarkViewController.m
//  benkelaile-iOS
//
//  Created by Zhang Xin Xin on 2019/4/19.
//  Copyright © 2019 sunlands. All rights reserved.
//

#import "AbstractBookmarkViewController.h"
#define Screen_Width                     ([UIScreen mainScreen].bounds.size.width)
#define Screen_Height                    ([UIScreen mainScreen].bounds.size.height)
#define UI_IS_IPHONE            ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
#define UI_IS_iPhoneX     (UI_IS_IPHONE && [[UIScreen mainScreen] bounds].size.width == 375.f && [[UIScreen mainScreen] bounds].size.height == 812.f)
#define kTabBarHeight (UI_IS_iPhoneX ?83:49)
#define kStatusBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height)
#define kNavBarHeight 44.0
#define kTopHeight (kStatusBarHeight + kNavBarHeight)
#define Font(a) [UIFont systemFontOfSize:(a)]
#define HexColor(value,a)   [UIColor colorWithRed:((value & 0xFF0000) >> 16)/255.0 green:((value & 0x00FF00) >> 8)/255.0 blue:(value & 0x0000FF)/255.0 alpha:(a)]
#define TableHeaderViewHeight 200


@interface AbstractBookmarkViewController ()

@end

@implementation AbstractBookmarkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.bookmarkView];
    
    //如果自己需要去修改的话
    self.bookmarkView.frame = CGRectMake(0, 0, Screen_Width, Screen_Height-kTopHeight-kTabBarHeight);
    
    [self.bookmarkView setUpViewInBookmarkView];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (BookMarkView*)bookmarkView
{
    if (_bookmarkView == nil) {
        
        _bookmarkView = [[BookMarkView alloc] initWithFrame:self.view.bounds];
        
        [_bookmarkView registTagListCellClass:[CheckConditionCollectionViewCell class] forItemClass:[CheckConditionItem class]];
        
        _bookmarkView.dataSource = self;
        _bookmarkView.delegate = self;
    }
    return _bookmarkView;
}

#pragma mark- bookmarkview的代理

//tagcell的size
- (CGSize)bookmarkViewSizeForTagCellIndexPath:(NSIndexPath*)indexPath bookmarkView:(BookMarkView*)bookmarkView
{
    if (indexPath.row>= self.itemsArray.count) {
        return CGSizeZero;
    }
    CheckConditionItem *item = [self.itemsArray objectAtIndex:indexPath.row];
    return CGSizeMake(item.itemWidth, item.itemHeight);
}


//contentCell的size
- (CGSize)bookmarkViewSizeForContentCellIndexPath:(NSIndexPath*)indexPath bookmarkView:(BookMarkView*)bookmarkView
{
    return CGSizeMake(Screen_Width, Screen_Height-kTopHeight-kTabBarHeight-40);
}


//tagcell的数据源
- (NSArray*)bookmarkViewTagListItems:(BookMarkView*)bookmarkView
{
    return self.itemsArray;
}


//contentcell的数据源
- (NSArray*)bookmarkViewContentListItems:(BookMarkView*)bookmarkView
{
    return self.childViewControllers;
}


//tag的cell和item之间的关联,bool表示是否是当前选中的
- (void)bookmarkViewTagListCellForItemIndexPath:(NSIndexPath *)indexPath cell:(UICollectionViewCell *)cell bookmarkView:(BookMarkView *)bookmarkView isCurrentIndexPath:(BOOL)isCurrent
{
    CheckConditionItem *item = [self.itemsArray objectAtIndex:indexPath.row];
    CheckConditionCollectionViewCell *tmpCell = (CheckConditionCollectionViewCell*)cell;
    if (isCurrent)
    {
        NSDictionary *attribtDic = @{
                                     NSFontAttributeName:Font(16),
                                     };
        NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:item.name attributes:attribtDic];
        tmpCell.nameLable.attributedText = attribtStr;
        tmpCell.select = YES;
    }
    else
    {
        NSDictionary *attribtDic = @{
                                     NSForegroundColorAttributeName:HexColor(0x4A4A4A, 1),
                                     NSFontAttributeName:Font(15),
                                     };
        NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:item.name attributes:attribtDic];
        tmpCell.nameLable.attributedText = attribtStr;
        tmpCell.select = NO;
    }
}

//content的cell和item之间的关联，bool表示是否是当前选中的

- (void)bookmarkViewContentListCellForItemIndexPath:(NSIndexPath *)indexPath bookmarkView:(BookMarkView *)bookmarkView cell:(BookmarkContentViewCell *)cell
{
    AbstractViewController *vc = [self.childViewControllers objectAtIndex:indexPath.row];
    
    NSLog(@"0--->:%zi",indexPath.row);
    
    NSLog(@"1--->:%@",vc);
    
    [cell loadContentView:vc.view];
}

//重复点击同一个tagList中的cell
- (void)bookmarkViewSelectSameCellForTagCellIndexpath:(NSIndexPath*)indexPath bookmarkView:(BookMarkView*)bookmarkView
{
    NSLog(@" same 2---2");
}

//点击了taglist中的cell
- (void)bookmarkViewSelectCellForTagCellIndexPath:(NSIndexPath*)indexPath bookmarkView:(BookMarkView*)bookmarkView
{
    NSLog(@"not same 1---1");
}


- (NSMutableArray*)itemsArray
{
    if (_itemsArray == nil) {
        _itemsArray = [NSMutableArray new];
    }
    return _itemsArray;
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)adjustForHotport
{
    //如果自己需要去修改的话
    self.bookmarkView.frame = CGRectMake(0, 0, Screen_Width, Screen_Height-kTopHeight-kTabBarHeight);
    [self.bookmarkView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
