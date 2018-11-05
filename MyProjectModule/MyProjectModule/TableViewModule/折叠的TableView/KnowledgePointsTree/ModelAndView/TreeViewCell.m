//
//  TreeViewCell.m
//  KnowledgeTree
//
//  Created by 鑫鑫 on 2017/4/12.
//  Copyright © 2017年 xinxin. All rights reserved.
//

#import "TreeViewCell.h"
#import "Masonry.h"
#import "UIView+frameAdjust.h"
@implementation TreeViewCell

{
    UILabel *_titleLabel;
    UILabel *_countLabel;
    UIView *_lineView;
    UIImageView *_openStateImageView;
    UIButton *_checkButton;
    UIButton *_restartButton;
    UIView *_separatorView;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self makeView];
    }
    return self;
}

-(void)makeView{
    // CGFloat cellHeight = [TreeViewCell heightForCell];
    
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.textColor = UICOLOR_RGB_Alpha(0x333333, 1);
    _titleLabel.font = [UIFont systemFontOfSize:15];
    _titleLabel.numberOfLines = 1;
    [self.contentView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(20);
        make.left.mas_equalTo(self).offset(36);
        make.size.mas_equalTo(CGSizeMake(220, 16));
    }];
    
    _countLabel = [[UILabel alloc]init];
    _countLabel.textColor = UICOLOR_RGB_Alpha(0x999999, 1);
    _countLabel.font = [UIFont systemFontOfSize:12];
    _countLabel.numberOfLines = 1;
    [self.contentView addSubview:_countLabel];
    [_countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_titleLabel.mas_bottom).offset(17);
        make.left.mas_equalTo(self).offset(36);
        make.size.mas_equalTo(CGSizeMake(self.width, 13));
    }];
    
    _lineView = [[UIView alloc]initWithFrame:CGRectMake(20, 0, 1, 0)];
    _lineView.backgroundColor = UICOLOR_RGB_Alpha(0xf1f1f1, 1);
    [self.contentView addSubview:_lineView];
    
    _openStateImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mine_train_tree_one_open"]];
    [self.contentView addSubview:_openStateImageView];
    [_openStateImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_left).offset(20);
        make.centerY.mas_equalTo(_titleLabel).offset(0);
        make.size.mas_equalTo(_openStateImageView.image.size);
    }];
    

    
    _separatorView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0.5)];
    _separatorView.backgroundColor = UICOLOR_RGB_Alpha(0xdcdcdc, 1);
    [self.contentView addSubview:_separatorView];
    [_separatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(0);
        make.right.mas_equalTo(self).offset(0);
        make.top.mas_equalTo(self).offset(0);
        make.height.mas_equalTo(0.5);
    }];
}

-(void)refreshCellWithViewModel:(TreeViewModel *)viewModel{
    self.cellViewModel = viewModel;
    _titleLabel.text = viewModel.knowledgeModel.name;
    
    NSString *str_minute = [NSString stringWithFormat:@"%02d",([viewModel.knowledgeModel.times intValue] %3600)/60];
    NSString *str_second = [NSString stringWithFormat:@"%02d",[viewModel.knowledgeModel.times intValue] %60];
    NSString *format_time = [NSString stringWithFormat:@"%@'%@''",str_minute,str_second];
    NSString *totalTime = [NSString stringWithFormat:@"%@",format_time];
    NSString *countString = [NSString stringWithFormat:@"共%@道,答对%@道,未作答%@,正确率%d％,总计用时%@",viewModel.knowledgeModel.qnum,viewModel.knowledgeModel.rnum,viewModel.knowledgeModel.unum,[viewModel.knowledgeModel.accuracy intValue],totalTime];
    _countLabel.text = countString;
    
    CGFloat lineY = 0;
    CGFloat lineHeight = 0;
    
    CGFloat openStateImageViewCenterY = 28;
    CGFloat cellHeight = [TreeViewCell heightForCell];
    CGFloat lineHeightForTop = cellHeight - openStateImageViewCenterY;
    CGFloat lineHeightForBottom = openStateImageViewCenterY;
    CGFloat lineHeightForCellHeight = cellHeight;
    UIImage *imageWithLevelOneOpen = [UIImage imageNamed:@"mine_train_tree_one_open"];
    UIImage *imageWithLevelOneClose = [UIImage imageNamed:@"mine_train_tree_one_close"];
    UIImage *imageWithLevelTwoOpen = [UIImage imageNamed:@"mine_train_tree_two_open"];
    UIImage *imageWithLevelTwoClose = [UIImage imageNamed:@"mine_train_tree_two_close"];
    UIImage *imageWithLevelThreeOpen = [UIImage imageNamed:@"mine_train_tree_three"];
    UIImage *imageWithLevelThreeClose = [UIImage imageNamed:@"mine_train_tree_three"];
    
    switch (viewModel.level) {
        case ErrorQuestionCellLevelOne:
            _separatorView.hidden = NO;
            switch (viewModel.openstate) {
                case ErrorQuestionCellOpen:
                    _openStateImageView.image = imageWithLevelOneOpen;
                    break;
                case ErrorQuestionCellClose:
                    _openStateImageView.image = imageWithLevelOneClose;
                    break;
                default:
                    break;
            }
            break;
        case ErrorQuestionCellLevelTwo:
            _separatorView.hidden = YES;
            switch (viewModel.openstate) {
                case ErrorQuestionCellOpen:
                    _openStateImageView.image = imageWithLevelTwoOpen;
                    break;
                case ErrorQuestionCellClose:
                    _openStateImageView.image = imageWithLevelTwoClose;
                    break;
                default:
                    break;
            }
            break;
            
        case ErrorQuestionCellLevelThree:
            _separatorView.hidden = YES;
            switch (viewModel.openstate) {
                case ErrorQuestionCellOpen:
                    _openStateImageView.image = imageWithLevelThreeOpen;
                    break;
                case ErrorQuestionCellClose:
                    _openStateImageView.image = imageWithLevelThreeClose;
                    break;
                default:
                    break;
            }
            break;
            
            
        default:
            break;
    }
    
    switch (viewModel.index) {
        case ErrorQuestionCellIndexTop:
            switch (viewModel.openstate) {
                case ErrorQuestionCellOpen:
                    lineY = openStateImageViewCenterY;
                    lineHeight = lineHeightForTop;
                    break;
                case ErrorQuestionCellClose:
                    lineY = 0;
                    lineHeight = 0;
                    break;
                default:
                    break;
            }
            
            break;
        case ErrorQuestionCellIndexCenter:
            lineY = 0;
            lineHeight = lineHeightForCellHeight;
            break;
        case ErrorQuestionCellIndexBottom:
            lineY = 0;
            lineHeight = lineHeightForBottom;
            break;
            
        default:
            
            break;
    }
    
    _lineView.y = lineY;
    _lineView.height = lineHeight;
    
    [_openStateImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_left).offset(20);
        make.centerY.mas_equalTo(_titleLabel).offset(0);
        make.size.mas_equalTo(_openStateImageView.image.size);
    }];
}

-(void)checkClick:(UIButton *)sender{
    if([self.delegate respondsToSelector:@selector(checkClick:)]){
        [self.delegate checkClick:self.cellViewModel];
    }
}

-(void)restartClick:(UIButton *)sender{
    if([self.delegate respondsToSelector:@selector(restartClick:)]){
        [self.delegate restartClick:self.cellViewModel];
    }
}

+(CGFloat)heightForCell{
    return UI_IS_IPAD?90:80;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


@end
