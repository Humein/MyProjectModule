//
//  PointsTreeTableViewCell.m
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2019/1/4.
//  Copyright © 2019 xinxin. All rights reserved.
//

#import "PointsTreeTableViewCell.h"
#import "Masonry.h"
@interface PointsTreeTableViewCell ()

// 展开Button
@property (nonatomic, strong) UIButton *spreadBtn;
// 线View
@property (nonatomic, strong) UIView *lineView;
// 标题Label
@property (nonatomic, strong) UILabel *titleL;
// 数量Label
@property (nonatomic, strong) UILabel *countL;
// 继续做题Label
@property (nonatomic, strong) UILabel *continueL;

@property (nonatomic, strong) UIView *treeWaterView;


@end
@implementation PointsTreeTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
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
    [self.contentView addSubview:self.continueL];
    [self.contentView addSubview:self.treeWaterView];

}
- (void)layout {
    
    [self.spreadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(5);
        make.width.height.equalTo(@30);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.spreadBtn);
        make.top.bottom.equalTo(self.contentView);
        make.width.equalTo(@1);
    }];
    [self.titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(15);
        make.left.equalTo(self.spreadBtn.mas_right).offset(5);
    }];
    [self.treeWaterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleL);
        make.width.equalTo(@140);
        make.height.equalTo(@17);
        make.bottom.equalTo(self.contentView).offset(-15);
    }];
    
    [self.countL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.treeWaterView.mas_right).offset(20);
        make.centerY.equalTo(self.treeWaterView);
    }];
    [self.continueL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-15);
    }];
}

// 不需要父控件中子视图开始被创建,导致懒加载无效
- (void)setupViews {
}

// MARK: - setter
- (void)setTreeModel:(PointTreeOnlyOneModel *)treeModel {
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
            self.contentView.backgroundColor = [UIColor whiteColor];
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
            break;
        case 2:
            [self.spreadBtn setImage:[UIImage imageNamed:@"mine_train_tree_three"] forState:UIControlStateNormal];
            self.lineView.hidden = NO;
            break;
        default:
            break;
    }
    self.continueL.hidden = !(treeModel.unfinishedPracticeId > 0);
    self.titleL.text = treeModel.name;
    self.countL.text = [NSString stringWithFormat:@"%ld/%ld", treeModel.rnum + treeModel.wnum, treeModel.qnum];
    
}

// MARK: - 点击事件
- (void)spreadBtnClick:(UIButton *)sender {
    
//    数据截断处
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
        _lineView.backgroundColor = [UIColor redColor];
    }
    return _lineView;
}
- (UILabel *)titleL {
    if (!_titleL) {
        _titleL = [UILabel new];
    }
    return _titleL;
}
- (UIView *)treeWaterView {
    if (!_treeWaterView) {
        _treeWaterView = [UIView new];
    }
    return _treeWaterView;
}
- (UILabel *)countL {
    if (!_countL) {
        _countL = [UILabel new];
    }
    return _countL;
}
- (UILabel *)continueL {
    if (!_continueL) {
        _continueL = [UILabel new];
        _continueL.text = @"继续做题";
    }
    return _continueL;
}

@end
