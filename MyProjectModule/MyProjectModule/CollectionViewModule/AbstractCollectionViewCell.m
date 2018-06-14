//
//  AbstractCollectionViewCell.m
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/6/13.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import "AbstractCollectionViewCell.h"
#import "CellModel.h"
#import "Masonry.h"
@interface AbstractCollectionViewCell()
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation AbstractCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
        [self configSubView];
    }
    return self;
}

-(void)configSubView{
    self.titleLabel = [UILabel new];
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

-(void)updateByItem:(CellModel *)item{
    self.titleLabel.text = @"232121312312323212131231232131232321213123123213123232121312312321312323212131231232131232321213123123213123213123";
}

@end
