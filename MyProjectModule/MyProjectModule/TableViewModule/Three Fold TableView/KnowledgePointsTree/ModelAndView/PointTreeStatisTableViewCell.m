//
//  PointTreeStatisTableViewCell.m
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2018/11/5.
//  Copyright © 2018 xinxin. All rights reserved.
//

#import "PointTreeStatisTableViewCell.h"
#import "Masonry.h"
@interface PointTreeStatisTableViewCell ()

@property (nonatomic, strong) UIButton *spreadBtn;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UILabel *titleL;
@property (nonatomic, strong) UILabel *countL;
@property (nonatomic, strong) UIView *separateView;

@end

@implementation PointTreeStatisTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configSubView];
        [self layout];
    }
    return self;
}



// MARK: - UI
- (void)configSubView {
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    [self.contentView addSubview:self.lineView];
    [self.contentView addSubview:self.spreadBtn];
    [self.contentView addSubview:self.titleL];
    [self.contentView addSubview:self.countL];
    [self.contentView addSubview:self.separateView];
}

- (void)layout {
    
    [self.spreadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(13);
        make.left.equalTo(self.contentView).offset(5);
        make.width.height.equalTo(@30);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.spreadBtn);
        make.top.bottom.equalTo(self.contentView);
        make.width.equalTo(@1);
    }];
    [self.titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.spreadBtn);
        make.left.equalTo(self.spreadBtn.mas_right).offset(10);
    }];
    [self.countL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleL.mas_bottom).offset(15);
        make.left.equalTo(self.titleL);
        make.bottom.equalTo(self.contentView).offset(-15);
    }];
    [self.separateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView);
        make.height.equalTo(@0.5);
    }];
}


// MARK: - setter
- (void)setTreeModel:(PointTreeModel *)treeModel {
    _treeModel = treeModel;
    
    self.spreadBtn.selected = treeModel.isSpread;
    
    if (treeModel.level == 0) {
        [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.spreadBtn.mas_bottom).offset(-15);
            make.centerX.equalTo(self.spreadBtn);
            make.bottom.equalTo(self.contentView);
            make.width.equalTo(@1);
        }];
    } else {
        [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.spreadBtn);
            make.top.bottom.equalTo(self.contentView);
            make.width.equalTo(@1);
        }];
    }
    
    switch (treeModel.level) {
        case 0:
            [self.spreadBtn setImage:[UIImage imageNamed:@"mine_train_tree_one_close"] forState:UIControlStateNormal];
            [self.spreadBtn setImage:[UIImage imageNamed:@"mine_train_tree_one_open"] forState:UIControlStateSelected];
            self.separateView.hidden = NO;
            if (treeModel.isSpread) {
                self.lineView.hidden = NO;
            } else {
                self.lineView.hidden = YES;
            }
            break;
        case 1:
            [self.spreadBtn setImage:[UIImage imageNamed:@"mine_train_tree_two_close"] forState:UIControlStateNormal];
            [self.spreadBtn setImage:[UIImage imageNamed:@"mine_train_tree_two_open"] forState:UIControlStateSelected];
            self.lineView.hidden = NO;
            self.separateView.hidden = YES;
            break;
        case 2:
            [self.spreadBtn setImage:[UIImage imageNamed:@"mine_train_tree_three"] forState:UIControlStateNormal];
            self.lineView.hidden = NO;
            self.separateView.hidden = YES;
            break;
        default:
            break;
    }
    self.titleL.text = treeModel.name;
    self.countL.text = [NSString stringWithFormat:@"共%ld道，答对%ld道，正确率%ld％", treeModel.qnum, treeModel.rnum, treeModel.accuracy];
}

- (void)setIsDay:(BOOL)isDay {
    _isDay = isDay;
    
}

// MARK: - 点击事件
- (void)spreadBtnClick:(UIButton *)sender {
    if (self.treeModel.level == 2) {
        return;
    }
    
    sender.selected = !(sender.selected);
    
    self.spreadBtnBlock ? self.spreadBtnBlock() : nil;
}

// MARK: - 懒加载
- (UIButton *)spreadBtn {
    if (!_spreadBtn) {
        _spreadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_spreadBtn setImage:[UIImage imageNamed:@"mine_train_tree_one_close"] forState:UIControlStateNormal];
        [_spreadBtn addTarget:self action:@selector(spreadBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _spreadBtn;
}
- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
    }
    return _lineView;
}
- (UILabel *)titleL {
    if (!_titleL) {
        _titleL = [UILabel new];
        _titleL.textColor = [UIColor redColor];
        _titleL.font = [UIFont systemFontOfSize:15];
    }
    return _titleL;
}
- (UILabel *)countL {
    if (!_countL) {
        _countL = [UILabel new];
        _countL.font = [UIFont systemFontOfSize:11];
    }
    return _countL;
}
- (UIView *)separateView {
    if (!_separateView) {
        _separateView = [UIView new];
    }
    return _separateView;
}

@end
