//
//  AbstractTableViewCell.m
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/6/12.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import "AbstractTableViewCell.h"
#import "CellModel.h"
#import "NSTimerObserver.h"
#import "MyProjectModule-Swift.h"

@interface AbstractTableViewCell()<TimerObserverDelegate>
@property (nonatomic,strong)  UILabel *timeLabel;
@property (nonatomic,strong) CellModel *model;

@end

@implementation AbstractTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupUI];
    }
    
    return self;
}

-(void)setupUI{
    UILabel *timeLabel =  [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 44, 30)];
    
    timeLabel.backgroundColor = [UIColor grayColor];
    
    self.timeLabel = timeLabel;
    
    [self.contentView addSubview:self.timeLabel];
    
    [[SDTimerObserver sharedInstance] addTimerObserver:self];
 }

- (void)updateByItem:(CellModel *)item{
    _model = item;
    self.timeLabel.text = [NSString stringWithFormat:@"%ld",(long)(_model.timeCount > 0 ? _model.timeCount : 0)];
    self.textLabel.text = [NSString stringWithFormat:@"%@",item.title];
}


// 代理
- (void)timerCallBackWithTimer:(SDTimerObserver *)timer{
    _model.timeCount -- ;
    self.timeLabel.text = [NSString stringWithFormat:@"%ld",(long)(_model.timeCount > 0 ? _model.timeCount : 0)];
}

@end
