//
//  DrawViewController.m
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/6/14.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import "DrawViewController.h"
#import "DrawUnlineAndScore.h"
#import "DrawLine.h"
#import "DrawBaseAnimaltionView.h"
#import "StartWaterView.h"
#import "AttributeAndPredicateWithLink.h"
#import "YYKit.h"
@interface DrawViewController ()
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) YYLabel      *hintLabel;
@end

@implementation DrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITextView *textStuff = [[UITextView alloc] init];
    textStuff.font = [UIFont systemFontOfSize:16];
    textStuff.frame = CGRectMake(50.0, 100.0, 100.0, 140.0);
    textStuff.textColor = [UIColor blackColor];
    [self.view addSubview:textStuff];
    self.textView = textStuff;
    
    
    {
//         进度
    DrawLine *line = [[DrawLine alloc]initWithFrame:CGRectMake(50, 300, 50, 50)];
    line.lineBackgroundColor = [UIColor grayColor];
    line.lineForegroundColor = [UIColor redColor];
    line.cycleSize = CGSizeMake(50, 50);
    line.lineWidht = 2;
    line.duration = 2;
    line.numberFont = 15;
    line.numberColor = [UIColor redColor];
    
    [self.view addSubview:line];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [line setStrokeEnd:0.8 AndNumberValue:55 animated:YES];

    });
    }
    
    {
//   脉动
        DrawBaseAnimaltionView *heartBeat = [[DrawBaseAnimaltionView alloc]initWithFrame:CGRectMake(50, 400, 50, 50)];
        heartBeat.backgroundColor = [UIColor grayColor];
        [self.view addSubview:heartBeat];

    }
    
    
    
    {
//        💗
        UIImage *maskImage = [UIImage imageNamed:@"btn_link_fill"];
        UIImage *lineImage = [UIImage imageNamed:@"btn_link_line"];
        
        StartWaterView *starView = [[StartWaterView alloc] init];
        starView.frame = CGRectMake(200, 100, maskImage.size.width, maskImage.size.height);
        starView.maskImage = maskImage;
        starView.borderImage = lineImage;
        starView.fillColor = [UIColor colorWithRed:0.94 green:0.27 blue:0.32 alpha:1];
        [self.view addSubview:starView];
        
        
    }
    
// 正则 富文本 超链接
    {
        AttributeAndPredicateWithLink *link = [[AttributeAndPredicateWithLink alloc]initWithFrame:CGRectMake(50, 484, 100, 80)];
        link.backgroundColor = [UIColor grayColor];
        [link refersheTheViewWithModel:nil];
        [self.view addSubview:link];
    }
    
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5;// 字体的行间距
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:15],
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    self.textView.attributedText = [[NSAttributedString alloc] initWithString:@"《你好，旧时光》作为一部“全景式青春治愈剧”，电视剧除了纯纯的校园青春还拓深了外延和内涵：时间横跨过去、现在和未来；从校园家庭到校外生活，空间维度也足够立体；更涵盖了“亲情、友情、师生情”。总之，无论时间、空间还是故事的情绪渲染，都可以看出该剧从多条线索多...空间还是故事的情绪渲染，都可以看出该剧从多条线索多...你好，旧时光》作为一部“全景式青春治愈剧”，电视剧除了纯纯的校园青春还拓深了外延和内涵：时间横跨过去、现在和未来；从校园家庭到校外生活，空间维度也足够立体；更涵盖了“亲情、友情、师生情”。总之，无论时间、空间还是故事的情绪渲染，都可以看出该剧从多条线索多...空间还是故事的情绪渲染，都可以看出该剧从多条线索多..." attributes:attributes];
    
    NSRange range0 = NSMakeRange(1, 3);
    NSRange range1 = NSMakeRange(20, 6);
    NSRange range2 = NSMakeRange(100, 124);
    
    DrawUnlineAndScore *drawObj =  [DrawUnlineAndScore new];

    NSDictionary *dic0 = @{
                          @"range":[NSValue valueWithRange:range0]?:@"",
                          @"color":[UIColor redColor]?:@"",
                          @"score":@"10分",
                          };
    NSDictionary *dic1 = @{
                          @"range":[NSValue valueWithRange:range1]?:@"",
                          @"color":[UIColor yellowColor]?:@"",
                          @"score":@"80分",
                          };
    NSDictionary *dic2 = @{
                          @"range":[NSValue valueWithRange:range2]?:@"",
                          @"color":[UIColor greenColor]?:@"",
                          @"score":@"20分",
                          };
    NSMutableArray *dicArray = [NSMutableArray arrayWithObjects:dic0 ,dic1 ,dic2 , nil];
    
    [dicArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [drawObj drawUnlineWithParm:obj withTheView:self.textView];
    }];
    
    
}

#pragma mark - YYText使用
-(void)addHintLabel{
//    [self.tableView addSubview:self.hintLabel];
//    [self.hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_footerView.mas_bottom).offset(13);
//        make.left.equalTo(self.tableView).offset(16);
//    }];
//    [self.hintLabel layoutIfNeeded];
//    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, self.hintLabel.height + 16, 0);
//    [self.tableView layoutIfNeeded];
}
// YYLabel 富文本
-(void)refreshHintLabelWithDetail:(NSString *)detail{
    NSMutableAttributedString *text = [NSMutableAttributedString new];
    NSMutableAttributedString *hintTitle = [[NSMutableAttributedString alloc] initWithString:@"温馨提示："];
    [hintTitle setColor:[UIColor redColor] range:hintTitle.rangeOfAll];
    NSMutableAttributedString *detailTitle = [[NSMutableAttributedString alloc] initWithString:detail];
    [detailTitle setColor:[UIColor blueColor] range:detailTitle.rangeOfAll];
    [text appendAttributedString:hintTitle];
    [text appendAttributedString:detailTitle];
    [text setFont:[UIFont systemFontOfSize:12] range:text.rangeOfAll];
    [text setLineSpacing:5];

//    self.hintLabel.attributedText = text;
}
- (YYLabel *)hintLabel {
    if (!_hintLabel) {
        _hintLabel = [[YYLabel alloc] initWithFrame:CGRectZero];
        _hintLabel.textAlignment = NSTextAlignmentLeft;
        _hintLabel.numberOfLines = 0;
        // 如果使用自动布局处理YYLabel 需要设置最大宽度
        _hintLabel.preferredMaxLayoutWidth = self.view.width - 24;
    }
    return _hintLabel;
}
@end

