//
//  CreatTreeView.h
//  KnowledgeTree
//
//  Created by 鑫鑫 on 2017/4/25.
//  Copyright © 2017年 xinxin. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface CreatTreeView : UIView
@property (nonatomic ,strong) void(^valueBlcok)(NSString *value);
@property (nonatomic ,strong) void(^cellClickBlcok)(NSInteger row);
@property(nonatomic,strong) UITableView *tableView;
- (instancetype)initWithFrame:(CGRect)frame dataSource:(NSMutableArray<NSMutableArray *> *)dataSource cellViewModelArray:(NSMutableArray<NSMutableArray *> *)cellViewModelArray  levelOneModelArray:(NSMutableArray<NSMutableArray *> *)levelOneModelArray;
@end
