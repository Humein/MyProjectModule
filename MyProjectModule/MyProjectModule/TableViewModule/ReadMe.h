//
//  ReadMe.h
//  MyProjectModule
//
//  Created by zhangxinxin on 2021/2/20.
//  Copyright © 2021 xinxin. All rights reserved.
//

//*********开发小结***********//  实战在项目中，理论放在markdown中。


0.  自动布局拾遗，避免遗忘。。。

  0.1： 顶部控件如果没有，底部控件上移。如果顶部控件高度没有设置，底部控件会自动上移。否则，需要你手动更新顶部控件高度为0 ！！！

  0.2：外部修改内部控件的布局，可以在setModel 中更新。

  0.3：修改UILabel内边距
重写UILabel
-(CGSize)intrinsicContentSize{
    CGSize originalSize = [super intrinsicContentSize];
    CGSize size = CGSizeMake(originalSize.width+8, originalSize.height);
    return size;
}

  0.4: CollectionView cell宽度是可以自适应。
flowLayout.estimatedItemSize = CGSizeMake(74, 44);



1.  封装UITableView时候通过 contentSize 设置高度；
    1.1 通过重写UITableView子类的contentSize；或者 KVO 监听 contentSize；
    1.2 UITableViewCell嵌套 UITableView / CollectionView 时计算高度。通过 contentSize配合 layoutIfNeeded 来获取；缺点需要写在网路回掉之后，耦合业务
    1.3 layoutSubviews 中获取也行

[self.tableView reloadData];
[self.tableView layoutIfNeeded]; // dispatch_aysn main 也可以
[self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
    make.height.mas_equalTo(self.tableView.contentSize.height);
}];


⚠️ 在iOS11中，表视图默认使用估计高度。这意味着contentSize最初只是估计值。如果你需要使用contentSize，'你可以通过设置3个estimated height属性为0来禁用estimated height
如果还是想用估计高度可以在：先设置tableView高度为最大值，layoutifneed 之后再设置contentSize
    [self.backgroundView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGFLOAT_MAX);
    }];
    [self.tableView reloadData];
    [self.tableView layoutIfNeeded];
    [self.backgroundView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(self.tableView.contentSize.height);
    }];
}


2.  记录Cell的预估高度

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    LevelList *model = [_model.levelList xesApp_objectOrNilAtIndex:indexPath.row];
    //高度缓存
    if (model.cell_height == 0) {
        CGFloat height = cell.height;
        model.cell_height = height;
    }
}



