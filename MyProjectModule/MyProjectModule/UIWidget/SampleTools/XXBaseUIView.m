//
//  XXBaseUIView.m
//  MyProjectModule
//
//  Created by zhangxinxin on 2020/8/25.
//  Copyright © 2020 xinxin. All rights reserved.
//

#import "XXBaseUIView.h"
#import "Masonry.h"
#import <YYKit/YYKit.h>

@interface XXBaseUIView()
@property (nonatomic, strong) UILabel *titleTagLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@end
@implementation XXBaseUIView


// !!!: 计算富文本高度
-(void)getAttstrHeight{
    // 简单点的方法
    self.titleLabel.preferredMaxLayoutWidth = 220;
    CGSize size = self.titleLabel.intrinsicContentSize;
    
    // 复杂点的方法 不需要label
    NSMutableAttributedString  *attText = [[NSMutableAttributedString  alloc] initWithString:@""];
    attText.minimumLineHeight = 20;
    attText.font = [UIFont systemFontOfSize:14];
    CGSize introSize = CGSizeMake(self.width, CGFLOAT_MAX);
    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:introSize text:attText];
    CGFloat attHeight = layout.textBoundingSize.height;
    
}

// !!!: 并排的两个label如何优先让其中一个宽度自适应 titleTagLabel。 约束优先级
-(void)setupSubViewsConstraints{
    // 并排的两个label如何优先让其中一个宽度自适应 titleTagLabel。 约束优先级
    [self.titleTagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.centerY.equalTo(self);
        make.height.mas_equalTo(22);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleTagLabel.mas_right).offset(4);
        make.centerY.equalTo(self.titleTagLabel);
        make.right.equalTo(self).offset(-20);
    }];
    // titleTagLabel 优先级显示
    [self.titleTagLabel setContentCompressionResistancePriority:751 forAxis:UILayoutConstraintAxisHorizontal];
    // 获取layout的frame
    dispatch_async(dispatch_get_main_queue(), ^{
        // 渐变
        CAGradientLayer *gradientLayer = [self setGradualChangingColor:self.titleTagLabel fromColor:[UIColor redColor] toColor:[UIColor yellowColor]];
        // layer层级
        gradientLayer.frame = self.titleTagLabel.layer.frame;
        [self.layer insertSublayer:gradientLayer below:self.titleTagLabel.layer];
    });
}

// !!!:  绘制渐变色颜色的方法
- (CAGradientLayer *)setGradualChangingColor:(UIView *)view fromColor:(UIColor *)fromColor toColor:(UIColor * )toColor{
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = view.bounds;
    gradientLayer.cornerRadius = 2;
    gradientLayer.colors = @[(__bridge id)fromColor.CGColor,(__bridge id)toColor.CGColor];
    //  设置渐变颜色方向，左上点为(0,0), 右下点为(1,1)
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    gradientLayer.locations = @[@0,@1];
    return gradientLayer;
}


// MARK: - initView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configSubview];
        [self layout];
    }
    return self;
}

-(void)configSubview{
    
}

// MARK: - layoutView
-(void)layout{
    
}

// MARK: - Refresh Data


// MARK: - Private Method


// MARK: - Get/Set

@end
