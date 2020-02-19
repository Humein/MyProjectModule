//
//  LiveCommetChatTV.m
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2018/10/26.
//  Copyright © 2018 xinxin. All rights reserved.
//

#import "LiveCommetChatTV.h"
#import "liveChatModel.h"
#import "YYWeakProxy.h"

@interface LiveCommetChatTV()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSTimer     *timer;
@property (nonatomic, strong) NSMutableArray *imTableDataSoure;
@property (nonatomic ,retain)NSMutableArray *yxDataSource;
@property (nonatomic ,assign)NSInteger scrollIndex;

@end


@implementation LiveCommetChatTV

-(void)dealloc{
    NSLog(@"%@ 销毁啦！", NSStringFromClass([self class]));
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        [self setupUI];
        self.scrollIndex = 0;
//        _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(action) userInfo:nil repeats:YES];
        // YYWeakProxy
        _timer = [NSTimer timerWithTimeInterval:2
                                                  target:[YYWeakProxy proxyWithTarget:self]
                                                selector:@selector(action)
                                                userInfo:nil
                                                 repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];

    }
    return self;
}

- (void)action{
    liveChatModel *md = [self.yxDataSource objectAtIndex:arc4random()%self.dataList.count];
    [self.imTableDataSoure insertObject:md atIndex:0];
    NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
    [self insertRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationTop];
}

- (NSMutableArray*)imTableDataSoure
{
    if (!_imTableDataSoure) {
        _imTableDataSoure = [NSMutableArray new];
    }
    return _imTableDataSoure;
}

- (void)setDataList:(NSArray *)dataList{
    _dataList = dataList;
    _yxDataSource = [NSMutableArray new];
    [dataList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSString *content = (NSString *)obj;
        CGSize contentSize = [self sizeWithFont:[UIFont systemFontOfSize:16] width:self.frame.size.width-30 content:content];
        
        if (self.font) {
            contentSize = [self sizeWithFont:self.font width:self.frame.size.width-30 content:content];
        }
        
        liveChatModel *md = [[liveChatModel alloc]init];
        md.yx_content = content;
        md.yx_height = contentSize.height+20;
        if (self.padding>0) {
            md.yx_height = contentSize.height+self.padding*2;
        }
        [_yxDataSource addObject:md];
    }];
    [self reloadData];
    
}

- (void)setSpeed:(NSInteger)speed{
    _speed = speed;
//    [_timer setFireDate:[NSDate distantFuture]];
//    _timer = nil;
//    _timer = [NSTimer scheduledTimerWithTimeInterval:speed target:self selector:@selector(action) userInfo:nil repeats:YES];
    _timer = [NSTimer timerWithTimeInterval:speed
                                              target:[YYWeakProxy proxyWithTarget:self]
                                            selector:@selector(action)
                                            userInfo:nil
                                             repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];

}

//MARK: - UITableViewControllerDataSoure

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    liveChatModel *md = _imTableDataSoure[indexPath.row];
    return md.yx_height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.imTableDataSoure.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.transform = CGAffineTransformMakeScale(1, -1);
    }
    
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor =[UIColor darkGrayColor];
    cell.textLabel.font      = [UIFont systemFontOfSize:16.f];
    liveChatModel *md = [self.imTableDataSoure objectAtIndex:indexPath.row];
    cell.textLabel.text = md.yx_content;
    if (self.font) {
        cell.textLabel.font = self.font;
    }
    if (self.color) {
        cell.textLabel.textColor = self.color;
    }
    if (self.contentColor) {
        NSRange range = [md.yx_content rangeOfString:@"："];
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:md.yx_content];
        [string addAttribute:NSForegroundColorAttributeName value:self.contentColor range:NSMakeRange(0, range.location)];
        cell.textLabel.attributedText = string;
    }
    if (self.reviewerNickNameColor) {
        NSRange range = [md.yx_content rangeOfString:@"："];
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:md.yx_content];
        [string addAttribute:NSForegroundColorAttributeName value:self.reviewerNickNameColor range:NSMakeRange(range.location, string.length - range.location)];
        cell.textLabel.attributedText = string;
    }
    
    
    if (self.scrollIndex%2 == 0) {
        
        if (self.evenNumberContentColor) {
            NSRange range = [md.yx_content rangeOfString:@"："];
            NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:md.yx_content];
            [string addAttribute:NSForegroundColorAttributeName value:self.evenNumberContentColor range:NSMakeRange(range.location, string.length - range.location)];
            cell.textLabel.attributedText = string;
        }
        if (self.evenNumberNickNameColor) {
            NSRange range = [md.yx_content rangeOfString:@"："];
            NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:md.yx_content];
            [string addAttribute:NSForegroundColorAttributeName value:self.evenNumberNickNameColor range:NSMakeRange(0, range.location)];
            cell.textLabel.attributedText = string;
        }
    }else{
        
        if (self.oddNumberContentColor) {
            NSRange range = [md.yx_content rangeOfString:@"："];
            NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:md.yx_content];
            [string addAttribute:NSForegroundColorAttributeName value:self.oddNumberContentColor range:NSMakeRange(range.location, string.length - range.location)];
            cell.textLabel.attributedText = string;
        }
        if (self.oddNumberNickNameColor) {
            NSRange range = [md.yx_content rangeOfString:@"："];
            NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:md.yx_content];
            [string addAttribute:NSForegroundColorAttributeName value:self.oddNumberNickNameColor range:NSMakeRange(0, range.location)];
            cell.textLabel.attributedText = string;
        }
    }
    self.scrollIndex ++;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    liveChatModel *md = _imTableDataSoure[indexPath.row];
    if ([self.yx_delegate respondsToSelector:@selector(scrollChatTextView:withIndex:withText:)]) {
        [self.yx_delegate scrollChatTextView:self withIndex:indexPath.row withText:md.yx_content];
    }
}


//MARK: - 取消定时器
- (void)removeTimer
{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)setCureentText:(NSString *)cureentText{
    _cureentText = cureentText;
    [_timer setFireDate:[NSDate distantFuture]];
    [self.imTableDataSoure insertObject:cureentText atIndex:0];
    
    NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
    [self insertRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationTop];
    
    [_timer setFireDate:[NSDate distantPast]];
}


- (void)setupUI {
    
    self.delegate = self;
    self.dataSource = self;
    self.estimatedRowHeight = 0;
    self.estimatedSectionHeaderHeight = 0;
    self.estimatedSectionFooterHeight = 0;
    self.separatorColor = [UIColor clearColor];
    self.backgroundColor = [UIColor clearColor];
    self.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableHeaderView = [[UIView alloc]init];
    self.transform = CGAffineTransformMakeScale(1, -1);
    
}


- (CGSize)sizeWithFont:(UIFont *)font width:(CGFloat)width content:(NSString *)content{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    CGSize size = CGSizeMake(width,CGFLOAT_MAX);
    return [content boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
