//
//  DrawViewController.m
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/6/14.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import "DrawViewController.h"
#import "DrawUnlineAndScore.h"
@interface DrawViewController ()
@property (nonatomic, strong) UITextView *textView;

@end

@implementation DrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITextView *textStuff = [[UITextView alloc] init];
    textStuff.font = [UIFont systemFontOfSize:16];
    textStuff.frame = CGRectMake(50.0, 100.0, 300.0, 140.0);
    textStuff.textColor = [UIColor blackColor];
    [self.view addSubview:textStuff];
    self.textView = textStuff;
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5;// 字体的行间距
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:15],
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    self.textView.attributedText = [[NSAttributedString alloc] initWithString:@"《你好，旧时光》作为一部“全景式青春治愈剧”，电视剧除了纯纯的校园青春还拓深了外延和内涵：时间横跨过去、现在和未来；从校园家庭到校外生活，空间维度也足够立体；更涵盖了“亲情、友情、师生情”。总之，无论时间、空间还是故事的情绪渲染，都可以看出该剧从多条线索多...空间还是故事的情绪渲染，都可以看出该剧从多条线索多..." attributes:attributes];
    
    NSRange range0 = NSMakeRange(1, 3);
    NSRange range1 = NSMakeRange(20, 6);
    NSRange range2 = NSMakeRange(30, 46);
    NSMutableArray *array = [NSMutableArray arrayWithObjects:[NSValue valueWithRange:range0],[NSValue valueWithRange:range1],[NSValue valueWithRange:range2], nil];
    DrawUnlineAndScore *drawObj =  [DrawUnlineAndScore new];

    [array enumerateObjectsUsingBlock:^(NSValue *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSRange range = [obj rangeValue];
        [drawObj drawRange:range withTheView:self.textView];

    }];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
