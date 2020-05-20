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
    self.titleLabel.text = @"23212131231232";
    self.contentView.clipsToBounds = YES;
    self.contentView.layer.cornerRadius = 10;
    self.titleLabel = [UILabel new];
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

- (void)setContentX:(CGFloat)contentX{
    
    _contentX = contentX;
    self.frame = CGRectMake(contentX, 0, self.frame.size.width, self.frame.size.height);
    
}


-(void)updateByItem:(CellModel *)item{
    self.titleLabel.text = @"23212131231232";
}

// overLoad collectionCell自适应宽度 2
- (UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    // 获得每个cell的属性集
    UICollectionViewLayoutAttributes *attributes = [super preferredLayoutAttributesFittingAttributes:layoutAttributes];
    // 计算cell里面textfield的宽度
    CGRect frame = [self.titleLabel.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 30) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:[NSDictionary dictionaryWithObjectsAndKeys:self.titleLabel.font,NSFontAttributeName, nil] context:nil];
    
    // 这里在本身宽度的基础上 又增加了10
    frame.size.width += 10;
    frame.size.height = 30;
    
    // 重新赋值给属性集
    attributes.frame = frame;
    
    return attributes;
}



@end
