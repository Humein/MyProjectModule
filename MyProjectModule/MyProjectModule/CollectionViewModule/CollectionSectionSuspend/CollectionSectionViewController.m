//
//  CollectionSectionViewController.m
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/6/26.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import "CollectionSectionViewController.h"
#import "CollectionDetaiDemo.h"
#import "HeaderSuspendedLayout.h"
@interface CollectionSectionViewController ()

@end

@implementation CollectionSectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CollectionDetaiDemo *demo = [[CollectionDetaiDemo alloc]initWithFrame:CGRectMake(0, 84, self.view.frame.size.width, self.view.frame.size.height)];
    HeaderSuspendedLayout *layout = [HeaderSuspendedLayout new];
    layout.itemSize = CGSizeMake(self.view.frame.size.width, 150);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 10;
    //设置头部视图的尺寸
    layout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height * 0.085);
    [demo reloadDataWithFlowLayout:layout];

    [self.view addSubview:demo];
    
    
    // Do any additional setup after loading the view.
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
