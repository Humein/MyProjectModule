//
//  BookmarkViewDemo.m
//  MyProjectModule
//
//  Created by XinXin on 2020/5/30.
//  Copyright © 2020 xinxin. All rights reserved.
//

#import "BookmarkViewDemo.h"
#import "BaseBookmarkChildDemoController.h"
@interface BookmarkViewDemo ()
@property (nonatomic,strong)NSMutableArray *gl_items;//item的数组，所有的item的数组
@property (nonatomic,strong)NSMutableDictionary *gl_items_dict;//控制器的数组

@end

@implementation BookmarkViewDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupChildVc];
    // Do any additional setup after loading the view.
}

- (void)setupChildVc {
    NSArray *resultArray = @[@1, @2, @3, @4, @5];
    self.bookmarkView.frame = CGRectMake(0, 80, self.view.frame.size.width, self.view.frame.size.height - 80);
    
    [resultArray enumerateObjectsUsingBlock:^(AbstractViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CheckConditionItem *conditionItem = [CheckConditionItem new];
        conditionItem.name = @"你好吗";
        conditionItem.itemWidth= [conditionItem titleWidth];
        conditionItem.itemHeight = [conditionItem titleHeight];
        BaseBookmarkChildDemoController *vc = [[BaseBookmarkChildDemoController alloc] init];
        [self.itemsArray addObject:conditionItem];
        [self addChildViewController:vc];
    }];
    
    [self.bookmarkView reloadData];


}

- (NSMutableArray*)gl_items
{
    if (_gl_items==nil) {
        _gl_items = [NSMutableArray new];
    }
    return _gl_items;
}

- (NSMutableDictionary*)gl_items_dict
{
    if (_gl_items_dict == nil) {
        _gl_items_dict = [NSMutableDictionary new];
    }
    return _gl_items_dict;
}


@end

