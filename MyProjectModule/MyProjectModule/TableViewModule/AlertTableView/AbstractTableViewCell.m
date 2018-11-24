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


@interface AbstractTableViewCell()<TimerObserver>
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
    
    
    [[NSTimerObserver sharedInstance] addTimerObserver:self];

 
    
    
}

- (void)updateByItem:(CellModel *)item
{
    // 过滤 数据源 影响
//    _model = _model.timeCount ? _model : item;
    
    if (_model.timeCount || _model.timeCount == -1) {
        
        if (_model.timeCount == -1) {
            
            self.timeLabel.text =[NSString stringWithFormat:@"%d",0];
        }
        
    }else{
        
        _model = item;
        self.timeLabel.text =[NSString stringWithFormat:@"%ld",(long)_model.timeCount];
        
    }
    
    
    self.textLabel.text = [NSString stringWithFormat:@"%@-----%ld",item.title,(long)item.timeCount];
    
}


- (void)timerCallBack:(NSTimerObserver *)timer {
    

    if (_model.timeCount>0) {
        _model.timeCount -- ;
        self.timeLabel.text =[NSString stringWithFormat:@"%ld",(long)_model.timeCount];

    }else{
        _model.timeCount = -1;
        [[NSTimerObserver sharedInstance] removeTimerObserver:self];
        
    }
    
    
}

@end
