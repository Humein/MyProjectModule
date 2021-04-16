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
@property (nonatomic, strong) YYLabel *titleLabel;
@property (nonatomic, strong) UITableView *tableView;

@end
@implementation XXBaseUIView


// !!!: 计算富文本高度
-(void)getAttstrHeight{
    // 简单点的方法。
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.preferredMaxLayoutWidth = self.width;
    CGSize size = self.titleLabel.intrinsicContentSize;
    
    // 复杂点的方法并且好用的 能处理
    NSMutableAttributedString  *attText = [[NSMutableAttributedString  alloc] initWithString:@""];
    // 修改富文本的上下偏移量，可以做上下对齐处理。如果不好使，用UILabel 替换 YYLable
    [attText setBaselineOffset:@(-2) range:[attText.string rangeOfString:attText.string]];
    
    // 换行处理 preferredMaxLayoutWidth换行
    self.titleLabel.numberOfLines = 2; 
    self.titleLabel.preferredMaxLayoutWidth = self.width;
    
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
    // titleTagLabel 优先级显示 https://juejin.cn/post/6904180829883203592
    [self.titleTagLabel setContentCompressionResistancePriority:751 forAxis:UILayoutConstraintAxisHorizontal];
    // 获取layout的frame
    dispatch_async(dispatch_get_main_queue(), ^{
        // 渐变
        CAGradientLayer *gradientLayer = [self setGradualChangingColor:self.titleTagLabel fromColor:[UIColor redColor] toColor:[UIColor yellowColor]];
        // layer层级
        /*
          父子层级无法调换
          可以通过一个共有的父层级，然后通过zPosition属性设置子视图Layer的层次高于其他Layer即可覆盖
         */
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

// !!!: tableView 渐变背景颜色
-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStyleGrouped];
        
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        // 调整layer层级 ⚠️：layer要有同一个父layer zPosition 属性调整视图层级关系
        gradientLayer.zPosition = -1;
        _tableView.backgroundView.layer.zPosition = 0;
        
        gradientLayer.frame = _tableView.bounds;
        [_tableView.layer addSublayer:gradientLayer];
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(0, 1);
        //设置颜色数组
        gradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor,
        (__bridge id)[UIColor grayColor].CGColor];
        //设置颜色分割点（范围：0-1）
        gradientLayer.locations = @[@(0.3f),@(1.0f)];

        _tableView.backgroundColor = [UIColor grayColor];

        _tableView.estimatedRowHeight = 161;
    }
    return _tableView;
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
