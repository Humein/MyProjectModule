//
//  ClassClusterTableViewCellA.m
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2019/1/16.
//  Copyright © 2019 xinxin. All rights reserved.
//

#import "ClassClusterTableViewCellA.h"
@interface ClassClusterTableViewCellA ()

@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UIImageView *rightImageView;

@end
@implementation ClassClusterTableViewCellA

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.rightImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.rightImageView];
    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-20);
        make.top.mas_equalTo(2);
        make.bottom.mas_offset(-2);
        make.width.mas_equalTo(self.rightImageView.mas_height);
    }];
    
    self.leftLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.leftLabel];
    self.leftLabel.textAlignment = NSTextAlignmentRight;
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_offset(0);
        make.right.mas_equalTo(self.rightImageView.mas_left).mas_offset(-10);
    }];
}

- (void)setModel:(ClassClusterModel *)model {
    self.leftLabel.text = model.title;
    self.rightImageView.image = [UIImage imageNamed:model.image];
}

@end
