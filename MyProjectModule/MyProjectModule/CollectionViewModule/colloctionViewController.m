//
//  colloctionViewController.m
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/6/12.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import "colloctionViewController.h"
#import "CollectionModuleView.h"
#import "CellModel.h"
#import "AbstractCollectionViewCell.h"
@interface colloctionViewController ()<CollectionViewDataSource,CollectionViewDelegate>
@property (nonatomic,strong) CollectionModuleView *autoView;
@property (nonatomic,strong)NSMutableArray *itemList;

@end

@implementation colloctionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CellModel *model =  [CellModel new];
    model.title = @"colloctionViewController";
    model.itemHeight = [model titleHeight];
    self.itemList = [NSMutableArray arrayWithObjects:model,model,model
                     , nil];
    
    [self.autoView registCell:[AbstractCollectionViewCell class] forItem:[CellModel class]];
    [self.autoView reloadData];
    self.autoView.pagingEnabled = YES;
    [self.view addSubview:self.autoView];

}

#pragma mark ----Delegate
//cell的宽高
- (CGSize)autoViewsizeCellIndexPath:(NSIndexPath*)indexPath autoView:(CollectionModuleView *)autoView {
    return CGSizeMake(self.view.frame.size.width, 120);
}

//数据源
- (NSArray*)autoViewlistItems:(CollectionModuleView *)autoView {
    return self.itemList;
}


//这里是每个cell和对应的数据的关联
- (void)cell:(UICollectionViewCell *)cell cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CellModel *item = [self.itemList objectAtIndex:indexPath.row];
    AbstractCollectionViewCell *tmpCell =(AbstractCollectionViewCell*)cell;
    [tmpCell updateByItem:item];
}





- (CollectionModuleView *)autoView {
    if (!_autoView) {
        _autoView = [[CollectionModuleView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 200)];
        _autoView.backgroundColor = [UIColor blueColor];
        _autoView.direction = RToLType;
        _autoView.dataSource = self;
        _autoView.delegate = self;
    }
    return _autoView;
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
