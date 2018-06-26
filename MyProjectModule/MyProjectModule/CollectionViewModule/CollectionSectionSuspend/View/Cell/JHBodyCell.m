//
//  JHBodyCell.m
//
//  Created by 鑫鑫 on 2018/6/26.
//  Copyright © 2018年 xinxin. All rights reserved.
//


#import "JHBodyCell.h"
#import "CellFModel.h"
@interface JHBodyCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UIButton *nameBtn;
@property (weak, nonatomic) IBOutlet UIButton *countBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@end
@implementation JHBodyCell

- (void)awakeFromNib {

    self.backgroundColor = [UIColor blueColor];
}

//collectionView重写Frame不能修改间距,它里面有修改间距的属性
//- (void)setFrame:(CGRect)frame
//{
//    frame.origin.y -= 10;
//    
//    [super setFrame:frame];
//
//}

- (void)setBodyModel:(CellFModel *)bodyModel
{
    _bodyModel = bodyModel;
    self.titleLabel.text = bodyModel.section_title;
    [self.nameBtn setTitle:bodyModel.poi_name forState:UIControlStateNormal];
    [self.countBtn setTitle:bodyModel.fav_count forState:UIControlStateNormal];
    
    NSURL *url = [NSURL URLWithString:bodyModel.imageURL];
}

@end
