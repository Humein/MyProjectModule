//
//  JHHeaderReusableView.m
//
//  Created by 鑫鑫 on 2018/6/26.
//  Copyright © 2018年 xinxin. All rights reserved.
//


#import "JHHeaderReusableView.h"
#import "SectionFModel.h"
@interface JHHeaderReusableView ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@end
@implementation JHHeaderReusableView

- (void)awakeFromNib {


}

/** 赋值 */
- (void)setHomeModel:(SectionFModel *)homeModel
{
    _homeModel = homeModel;

    self.nameLabel.text = homeModel.tag_name;
    self.countLabel.text = homeModel.section_count;
    
    self.backgroundColor = [UIColor grayColor];
//    self.backgroundColor = JHRandomColor;
}
/** 点击头部视图的跳转 */
- (IBAction)clickHeader:(UIButton *)sender {
    
}

@end
