//
//  AlertTableView.m
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/6/12.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import "AlertTableView.h"
@interface AlertTableView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation AlertTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    [self addSubview:self.tableView];
    
    return self;
}

#pragma mark ----Delegate
    #pragma mark- tableview的代理
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _selectBlock ? _selectBlock(indexPath) :nil;
    if (_delegate && [_delegate respondsToSelector:@selector(alertTableView:didSelectRowAtIndexPath:)]){
        
        [_delegate alertTableView:self didSelectRowAtIndexPath:indexPath];
    }
    if (self.isSelectIndexToHidden) {
        [self hidden];
    }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSObject *item = [self.dataArray objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([item class]) forIndexPath:indexPath];

    [self.delegate alertTableViewCell:cell forRowAtIndexPath:indexPath];
    
    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.delegate alertTableView:self heightForRowAtIndexPath:indexPath];
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [self.delegate respondsToSelector:@selector(alertTableHeaderView:headerForSection:)] ?[self.delegate alertTableHeaderView:self headerForSection:section] : nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return [self.delegate respondsToSelector:@selector(alertTableHeaderView:headerHeightForSection:)] ? [self.delegate alertTableHeaderView:self headerHeightForSection:section] : 0;
}



#pragma mark --- PrivateMethod

#pragma mark --- PublicMethod
- (void)show
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [self showInView:keyWindow];
}
- (void)showInView:(UIView*)view
{
    self.frame= view.bounds;
    [view addSubview:self];
    self.tableView.frame= CGRectMake(self.FromPoint.x, self.FromPoint.y, CGRectGetWidth(self.tableViewFrame), CGRectGetHeight(self.tableViewFrame));
    self.dataArray =[self.delegate alertTableVieItemList];
    [self.tableView reloadData];
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    
    if (self.showType==AlertFadeType) {
        [UIView animateWithDuration:0.3 animations:^{
            self.tableView.alpha=1.0;
        } completion:^(BOOL finished) {
            
        }];
        
    }else if (self.showType==AlertSliderType){
        
        [UIView animateWithDuration:0.3 animations:^{
            self.tableView.alpha=1.0;
        } completion:^(BOOL finished) {
            
        }];
    }
}


- (void)reloadData
{
    self.dataArray =[self.delegate alertTableVieItemList];
    [self.tableView reloadData];
}


- (void)hidden
{
    if (self.showType==AlertFadeType) {
        
        [UIView animateWithDuration:0.2 animations:^{
            self.tableView.alpha= 0.0f;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }else if (self.showType == AlertSliderType){
        [self removeFromSuperview];
    }
    
}


- (void)registCell:(Class)cellClass forItem:(Class)itemClass
{
    [self.tableView registerClass:cellClass forCellReuseIdentifier:NSStringFromClass(itemClass)];
}

- (void)setSelectBlock:(SelectIndexBlock)selectBlock
{
    if (_selectBlock) {
        _selectBlock = nil;
    }
    
    selectBlock ? _selectBlock = [selectBlock copy] : nil;
}


- (void)setTapBlock:(TapCompletionBlock)tapBlock
{
    tapBlock ? _tapBlock = [tapBlock copy] : nil;
}

- (void)setIsCanScroll:(BOOL)isCanScroll
{
    _isCanScroll = isCanScroll;
    self.tableView.scrollEnabled= isCanScroll;
}

#pragma mark --- LazyLoad
- (NSMutableArray*)dataArray
{
    if (_dataArray== nil) {
        
        _dataArray= [NSMutableArray new];
    }
    return _dataArray;
}

- (UITableView*)tableView
{
    if (_tableView==nil) {
        _tableView = [[UITableView alloc] initWithFrame:_tableViewFrame style:UITableViewStylePlain];
        _tableView.dataSource=self;
        _tableView.delegate=self;
        _tableView.separatorStyle= UITableViewCellSeparatorStyleNone;
        _tableView.keyboardDismissMode =UIScrollViewKeyboardDismissModeOnDrag;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.clipsToBounds= YES;
        _tableView.layer.cornerRadius= 5.0f;
        _tableView.estimatedRowHeight = 40;
    }
    
    return _tableView;
}
//点击事件
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    if (!CGRectContainsPoint(_tableView.frame, point)) {
        [self hidden];
        _tapBlock ? _tapBlock (YES) : nil;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
