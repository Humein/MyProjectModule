//
//  CheckConditionCollectionViewCell.m
//  benkelaile-iOS
//
//  Created by Zhang Xin Xin on 2019/4/19.
//  Copyright © 2019 sunlands. All rights reserved.
//

#import "CheckConditionCollectionViewCell.h"
#import "Masonry.h"

@implementation CheckConditionCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self configSubView];
        [self layout];
    }
    return self;
}
- (void)configSubView{
    
    self.nameLable = [UILabel new];
    self.nameLable.font= [UIFont systemFontOfSize:14];
    self.nameLable.textAlignment= NSTextAlignmentCenter;
    self.nameLable.backgroundColor = [UIColor clearColor];
    
    self.subLineLabel = [UILabel new];
    self.subLineLabel.backgroundColor = [UIColor redColor];
    self.subLineLabel.layer.shadowColor = [UIColor redColor].CGColor;
    self.subLineLabel.layer.shadowOpacity = 0.3;
    self.subLineLabel.layer.shadowOffset = CGSizeMake(0, 2);
    self.subLineLabel.layer.shadowRadius = 4;
    self.subLineLabel.layer.masksToBounds = NO;
    self.subLineLabel.hidden = YES;
    
    [self.contentView addSubview:self.nameLable];
    [self.contentView addSubview:self.subLineLabel];    
}

- (void)layout
{
    [self.nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0.f);
    }];
    [self.subLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.nameLable);
        make.height.mas_equalTo(6);
        make.bottom.mas_equalTo(self.nameLable);
    }];
}

- (void)setSelect:(BOOL)select
{
    _select = select;
    self.subLineLabel.hidden = !_select;
}

@end
