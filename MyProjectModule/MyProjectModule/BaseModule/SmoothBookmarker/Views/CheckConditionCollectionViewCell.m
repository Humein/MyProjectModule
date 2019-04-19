//
//  CheckConditionCollectionViewCell.m
//  benkelaile-iOS
//
//  Created by Zhang Xin Xin on 2019/4/19.
//  Copyright © 2019 sunlands. All rights reserved.
//

#import "CheckConditionCollectionViewCell.h"
#import <Masonry/Masonry.h>
#define Font(a) [UIFont systemFontOfSize:(a)]
#define HexColor(value,a)   [UIColor colorWithRed:((value & 0xFF0000) >> 16)/255.0 green:((value & 0x00FF00) >> 8)/255.0 blue:(value & 0x0000FF)/255.0 alpha:(a)]

@implementation CheckConditionCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self configSubView];
        [self layout];
    }
    return self;
}


- (void)configSubView
{
    self.nameLable = [UILabel new];
    self.nameLable.font= Font(14);
    self.nameLable.textAlignment= NSTextAlignmentCenter;
    self.nameLable.backgroundColor = [UIColor clearColor];
    
    self.subLineLabel = [UILabel new];
    self.subLineLabel.backgroundColor = HexColor(0xFF6D73, 1);
    self.subLineLabel.layer.shadowColor = HexColor(0xFF6D73, 1).CGColor;
    self.subLineLabel.layer.shadowOpacity = 0.3;
    self.subLineLabel.layer.shadowOffset = CGSizeMake(0, 2);
    self.subLineLabel.layer.shadowRadius = 4;
    self.subLineLabel.layer.masksToBounds = NO;
    self.subLineLabel.hidden = YES;
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
