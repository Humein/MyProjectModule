//
//  FBKVOViewController.m
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/8/25.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import "FBKVOViewController.h"
#import "KVOController.h"
#import "PersonInfo.h"
@interface FBKVOViewController ()
@property (nonatomic, strong) PersonInfo *person;

@end

@implementation FBKVOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _person = [PersonInfo new];
    [self.KVOController observe:_person keyPath:@"name" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld action:@selector(changeColor)];

    [self.KVOController observe:_person keyPath:@"backgroundColor" options:NSKeyValueObservingOptionNew block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSKeyValueChangeKey,id> * _Nonnull change) {
        NSLog(@"%@", change[NSKeyValueChangeNewKey]);
    }];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [_person setValue:@"nihao" forKey:@"name"];

}

- (void)changeColor {
    self.view.backgroundColor = [UIColor redColor];
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
