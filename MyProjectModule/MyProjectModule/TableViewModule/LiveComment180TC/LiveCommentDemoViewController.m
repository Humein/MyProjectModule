//
//  LiveCommentDemoViewController.m
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2018/10/26.
//  Copyright © 2018 xinxin. All rights reserved.
//

#import "LiveCommentDemoViewController.h"
#import "LiveCommetChatTV.h"
@interface LiveCommentDemoViewController ()<ScrollChatViewDelegate>

@end

@implementation LiveCommentDemoViewController

-(void)dealloc{
    NSLog(@"%@ 销毁啦！", NSStringFromClass([self class]));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    LiveCommetChatTV *view = [[LiveCommetChatTV alloc]initWithFrame:CGRectMake(0, 300, self.view.frame.size.width-100, 300)];
    view.speed = 1;
    view.font = [UIFont systemFontOfSize:18];
    view.reviewerNickNameColor = [UIColor redColor];
    view.contentColor = [UIColor grayColor];
    view.oddNumberNickNameColor = [UIColor purpleColor];
    view.padding = 5;
    view.yx_delegate =self;
    view.dataList = @[@"corr：美女主播,这么美~~~主播,这么美~~~主播,这么美~~~主播,这么美~~~主播,这么美~~~",@"ScrollChatTextView：你眼睛好大啊 ~",@"社姐：能动手就别吵吵",@"YXScroll：你的腿好白好长😋",@"小麦主播：😆别逗乐~",@"小麦主播：哪有啦,人家只是美美哒~",@"ChatTextView：我用500万可以保养你吗？联系我微信哦ccoco",@"dayp：我是要成为主播男人的男人~😂",@"ChatTextView：看到你我的心就凌乱了~",@"设计师p：主播你是🐒请来的逗比吗~",@"方冰峰：哈哈哈哈哈哈 ~我也要成为主播男人",@"夏鸥按：都别当我看球~",@"大于P：主播,这么美~~~主播,这么美~~~主播,比范冰冰都美！！！！"];
    [self.view addSubview:view];
    // Do any additional setup after loading the view.
}


- (void)scrollChatTextView:(LiveCommetChatTV *)view withIndex:(NSInteger)index withText:(NSString *)text{
   
    NSLog(@"=点击回调==>%@",text);
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
