//
//  ClassClusterTableViewCellB.m
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2019/1/16.
//  Copyright © 2019 xinxin. All rights reserved.
//

#import "ClassClusterTableViewCellB.h"


@interface ClassClusterTableViewCellB ()

@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UILabel *rightLabel;

@end

@implementation ClassClusterTableViewCellB

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.leftImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.leftImageView];
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(2);
        make.bottom.mas_offset(-2);
        make.width.mas_equalTo(self.leftImageView.mas_height);
    }];
    
    self.rightLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.rightLabel];
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.mas_offset(0);
        make.left.mas_equalTo(self.leftImageView.mas_right).mas_offset(10);
    }];
}

- (void)setModel:(ClassClusterModel *)model {
    self.leftImageView.image = [UIImage imageNamed:model.image];
    self.rightLabel.text = model.title;
}

-(void)configCellWithModel:(ClassClusterModel *)model{
    self.rightLabel.text = model.title;
}

- (void)configEventDelegate:(id)delegate {
    if ([delegate conformsToProtocol:@protocol(ViewControllerBDelegate)]) {
        self.delegate = delegate;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.delegate && [self.delegate  respondsToSelector:@selector(viewControllerBsendValue:)]){
        //如果协议响应了sendValue：方法
        //通知代理执行协议的方法
        [self.delegate viewControllersendValue:@"1111"];
    }
}
@end
