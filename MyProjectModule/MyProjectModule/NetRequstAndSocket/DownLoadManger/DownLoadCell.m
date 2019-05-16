//
//  DownLoadCell.m
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2019/5/16.
//  Copyright © 2019 xinxin. All rights reserved.
//

#import "DownLoadCell.h"

#import "DownLoadCell.h"

@interface DownLoadCell ()<XXDownloadItemDelegate>

#define DownLoadCell_BigFont            [UIFont systemFontOfSize:14]
#define DownLoadCell_SmollFont          [UIFont systemFontOfSize:10]
#define DownloadCell_Spcing             8.0
@property (weak, nonatomic) UIProgressView *progressView;
@property (weak, nonatomic) UIButton *button;
@property (weak, nonatomic) UILabel *totalLabel;
@property (weak, nonatomic) UILabel *progressLabel;
@property (weak, nonatomic) UILabel *rateLabel;
@property (strong, nonatomic) NSDate *lastDate;
@property (assign, nonatomic) int64_t bytes;

@end

@implementation DownLoadCell

#pragma mark - 属性方法
- (void)setSource:(XXDownItem *)source
{
    if (source) {
        if (_source) {
            _source.delegate = nil;
        }
        _source = source;
        source.delegate = self;
        self.lastDate = nil;
        self.bytes = 0;
        
        self.textLabel.text = source.fileName;
        if (source.totalBytesExpectedToWrite) {
            float progress = source.totalBytesWritten/(float)source.totalBytesExpectedToWrite;
            self.totalLabel.text = [URLSessionDownManager calculationDataWithBytes:source.totalBytesExpectedToWrite];
            self.progressLabel.text = [NSString stringWithFormat:@"已下载：%.1f%%", progress*100];
            self.progressView.progress = progress;
        }
        else
        {
            self.totalLabel.text = nil;
            self.progressLabel.text = nil;
            self.rateLabel.text = nil;
            self.progressView.progress = 0;
        }
        
        self.rateLabel.text = nil;
        switch (source.filedownState) {
            case XXDownloadStateDown:
                [self.button setTitle:@"暂停" forState:UIControlStateNormal];
                break;
            case XXDownloadStateSuspend:
                [self.button setTitle:@"下载" forState:UIControlStateNormal];
                break;
                
            default:
                break;
        }
    }
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.textLabel.font = DownLoadCell_BigFont;
        self.textLabel.textColor = [UIColor blackColor];
        
        UILabel *label = [[UILabel alloc] init];
        label.font = DownLoadCell_SmollFont;
        label.textColor = [UIColor grayColor];
        [self.contentView addSubview:label];
        self.totalLabel = label;
        
        label = [[UILabel alloc] init];
        label.font = DownLoadCell_SmollFont;
        label.textColor = self.totalLabel.textColor;
        [self.contentView addSubview:label];
        self.progressLabel = label;
        
        label = [[UILabel alloc] init];
        label.font = DownLoadCell_SmollFont;
        label.textColor = self.totalLabel.textColor;
        [self.contentView addSubview:label];
        self.rateLabel = label;
        
        UIProgressView *progressView = [[UIProgressView alloc] init];
        progressView.progress = 0;
        [self.contentView addSubview:progressView];
        self.progressView = progressView;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = [UIFont systemFontOfSize:10];
        [button setTitle:@"暂停" forState:UIControlStateNormal];
        UIColor *color = [UIColor colorWithRed:0 green:122/255.0 blue:255/255.0 alpha:1];
        [button setTitleColor:color forState:UIControlStateNormal];
        [button setTitleColor:color forState:UIControlStateSelected];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        button.layer.borderWidth = 0.5;
        button.layer.borderColor = [UIColor grayColor].CGColor;
        button.layer.cornerRadius = 5;
        button.layer.masksToBounds = YES;
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:button];
        self.button = button;
    }
    
    return self;
}

- (void)buttonClicked:(UIButton *)sender
{
    if ([sender.currentTitle isEqualToString:@"下载"]) {
        [[URLSessionDownManager shareInstance] continueDownload:self.source];
    }
    else
    {
        [[URLSessionDownManager shareInstance] suspendDownload:self.source];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //设置位置信息
    CGFloat Y = DownloadCell_Spcing;
    CGFloat H = self.frame.size.height - 2*Y;
    CGFloat W = H;
    CGFloat X = self.frame.size.width - W - DownloadCell_Spcing;
    self.button.frame = CGRectMake(X, Y, W, H);
    
    W = X - 2*DownloadCell_Spcing;
    X = DownloadCell_Spcing;
    Y = DownloadCell_Spcing;
    H = self.frame.size.height - 2*Y - 15;
    self.textLabel.frame = CGRectMake(X, Y, W, H);
    
    Y = Y + H;
    W = [self.totalLabel.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: DownLoadCell_SmollFont} context:nil].size.width;
    H = 15;
    self.totalLabel.frame = CGRectMake(X, Y, W, H);
    
    X = X + W + DownloadCell_Spcing;
    W = [self.progressLabel.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: DownLoadCell_SmollFont} context:nil].size.width;
    self.progressLabel.frame = CGRectMake(X, Y, W, H);
    
    W = [self.rateLabel.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: DownLoadCell_SmollFont} context:nil].size.width;
    X = self.button.frame.origin.x - DownloadCell_Spcing - W;
    self.rateLabel.frame = CGRectMake(X, Y, W, H);
    
    W = self.button.frame.origin.x - 2*DownloadCell_Spcing;
    X = DownloadCell_Spcing;
    Y = self.frame.size.height - DownloadCell_Spcing;
    H = DownloadCell_Spcing;
    self.progressView.frame = CGRectMake(X, Y, W, H);
}

#pragma mark - <XXDownloadDelegate>代理方法
- (void)downloadSource:(XXDownItem *)source didWriteData:(NSData *)data totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    if (!self.totalLabel.text) {
        self.totalLabel.text = [URLSessionDownManager calculationDataWithBytes:totalBytesExpectedToWrite];
        self.totalLabel.frame = CGRectMake(self.totalLabel.frame.origin.x, self.totalLabel.frame.origin.y, [self.totalLabel.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: DownLoadCell_SmollFont} context:nil].size.width, self.totalLabel.frame.size.height);
    }
    
    NSDate *now = [NSDate date];
    if (self.lastDate) {
        NSTimeInterval timeInterval = [now timeIntervalSinceDate:self.lastDate];
        self.bytes += data.length;
        if (timeInterval > 1) {
            float progress = totalBytesWritten/(float)totalBytesExpectedToWrite;
            self.progressView.progress = progress;
            self.progressLabel.text = [NSString stringWithFormat:@"已下载：%.1f%%", progress*100];
            self.progressLabel.frame = CGRectMake(self.totalLabel.frame.origin.x + self.totalLabel.frame.size.width + DownloadCell_Spcing, self.progressLabel.frame.origin.y, [self.progressLabel.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: DownLoadCell_SmollFont} context:nil].size.width, self.progressLabel.frame.size.height);
            
            self.rateLabel.text = [NSString stringWithFormat:@"%@/s", [URLSessionDownManager calculationDataWithBytes:(int64_t)(self.bytes/timeInterval)]];
            CGFloat W = [self.rateLabel.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: DownLoadCell_SmollFont} context:nil].size.width;
            self.rateLabel.frame = CGRectMake(self.button.frame.origin.x - DownloadCell_Spcing - W, self.rateLabel.frame.origin.y, W, self.rateLabel.frame.size.height);
            
            self.lastDate = now;
            self.bytes = 0;
        }
    }
    else
    {
        self.lastDate = [NSDate date];
    }
}
- (void)downloadSource:(XXDownItem *)source changedState:(XXDownloadState)state
{
    if (state == XXDownloadStateDown) {
        [self.button setTitle:@"暂停" forState:UIControlStateNormal];
    }
    else if (state == XXDownloadStateSuspend)
    {
        [self.button setTitle:@"下载" forState:UIControlStateNormal];
        self.rateLabel.text = nil;
    }
}

@end

