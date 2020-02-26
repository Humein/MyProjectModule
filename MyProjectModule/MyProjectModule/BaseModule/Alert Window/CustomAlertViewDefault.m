//
//  CustomAlertViewDefault.m
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/8/15.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import "CustomAlertViewDefault.h"
#import <Masonry/Masonry.h>

@interface CustomAlertViewDefault()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,copy) NSMutableArray *cellDataSource;

@end


@implementation CustomAlertViewDefault
-(void)dealloc{
    NSLog(@"%@======销毁",NSStringFromClass(self.class));
}
- (id)initWithFrame:(CGRect)frame
{
    if (self= [super initWithFrame:frame]) {
        
        [self setupContentView];
    }
    return self;
}


#pragma mark- 弹框

- (void)setupContentView
{
   
    [self addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(10, 10, 10, 10));
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView reloadData];

    });
    
}


#pragma mark - UITableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.backgroundColor = [UIColor clearColor];
        cell.userInteractionEnabled = YES;
    }
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    cell.textLabel.textColor = [UIColor redColor];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.text = @"11111111";
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.handleBlock) {
        self.handleBlock(indexPath.row);
    }
}



#pragma mark -- CallBack

-(void)click:(UIButton *)sender{
    if (self.handleBlock) {
        self.handleBlock(sender.tag);
    }
}


#pragma mark --- LayLoad

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _tableView.separatorColor = [UIColor grayColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.showsVerticalScrollIndicator = YES;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.scrollEnabled = YES;
        _tableView.allowsSelection = YES;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 10)];
        _tableView.tableHeaderView.backgroundColor = [UIColor redColor];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 10)];
        _tableView.tableFooterView.backgroundColor = [UIColor blueColor];
    }
    return _tableView;
}


@end
