//
//  PopTableView.m
//  AnimationCollection
//
//  Created by 鑫鑫 on 2018/5/2.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import "PopTableView.h"
#import "AppDelegate.h"
@interface PopTableView()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
{
    UIImageView *_imageView;
    
}
@property(nonatomic,strong) NSMutableArray *cellDataSource;
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSString *bgImage;
@property (nonatomic, strong) UIView *containerView;

@end
@implementation PopTableView
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:_imageView.bounds style:UITableViewStylePlain];
        _tableView.separatorColor = [UIColor grayColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.showsVerticalScrollIndicator = YES;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.scrollEnabled = YES;
        _tableView.allowsSelection = YES;
        //        _tableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 10)];
        _tableView.tableHeaderView.backgroundColor = [UIColor redColor];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 10)];
        _tableView.tableFooterView.backgroundColor = [UIColor blueColor];
    }
    return _tableView;
}

#pragma mark - InitMethod
- (instancetype)initWithFrame:(CGRect)frame dataSource:(NSArray<NSArray *> *)dataSource withBGView:(NSString *)bgView{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        _bgImage = bgView;
        _cellDataSource= [NSMutableArray arrayWithArray:dataSource];
//        [self loadData];
        [self addSubviews];
    }
    return self;
}

- (void)addSubviews {

    
    AppDelegate *appdelegate= (AppDelegate*)[UIApplication sharedApplication].delegate;
    UIWindow *keyWindow= appdelegate.window;
    UIView *containerView = [[UIView alloc] initWithFrame:keyWindow.frame];
    containerView.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(containerViewClick)];
    tap.delegate = self;
    [containerView addGestureRecognizer:tap];
    containerView.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
    
    
      _imageView = [[UIImageView alloc] initWithFrame:self.frame];
    {
        CGFloat top = 10;     // 顶端预留部分
        CGFloat bottom = 10 ; // 底端预留部分
        CGFloat left = 40; // 左端预留部分
        CGFloat right = 40; // 右端预留部分
        UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
        UIImage *image = [UIImage imageNamed:_bgImage];
        image = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
        [_imageView setImage:image];
    }
    
    [_imageView addSubview:self.tableView];
    self.tableView.clipsToBounds = YES;
    _imageView.userInteractionEnabled = YES;
    [containerView addSubview:_imageView];
    
    self.containerView = containerView;

}

#pragma mark - layout subviews

- (void)layoutSubviews {
    [super layoutSubviews];

}

- (void)show {
    AppDelegate *appdelegate= (AppDelegate*)[UIApplication sharedApplication].delegate;
    UIWindow *keyWindow= appdelegate.window;
    [keyWindow addSubview:self.containerView];
    [keyWindow bringSubviewToFront:self.containerView];
    [self.tableView reloadData];

}

- (void)dismiss {
    [self.containerView removeFromSuperview];
    [self removeFromSuperview];
}


#pragma mark - UITableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.cellDataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.backgroundColor = [UIColor clearColor];
        cell.userInteractionEnabled = YES;
        //        cell.delegate = self;
    }
    MatchesSwitchMdoel *cellViewModel = [self.cellDataSource objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    cell.textLabel.textColor = [UIColor redColor];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.text = [self.cellDataSource objectAtIndex:indexPath.row];
//    cell.textLabel.text = cellViewModel.name;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MatchesSwitchMdoel *cellViewModel = [self.cellDataSource objectAtIndex:indexPath.row];
    if([self.delegate respondsToSelector:@selector(cellClick:)]){
        [self.delegate cellClick:cellViewModel ];
    }
    
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


- (void)containerViewClick {
    [self.containerView removeFromSuperview];
}

// MARK: UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    
    // 解决tableView手势冲突
    if([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]){
        return NO;
    };
    // 手动调用点击方法
    [self containerViewClick];
    return YES;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    
    
    return [super hitTest:point withEvent:event];
}

//点击事件
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    if (!CGRectContainsPoint(_tableView.frame, point)) {
//        [self hidden];
//        _tapBlock ? _tapBlock (YES) : nil;
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
