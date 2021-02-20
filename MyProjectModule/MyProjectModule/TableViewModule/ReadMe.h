//
//  ReadMe.h
//  MyProjectModule
//
//  Created by zhangxinxin on 2021/2/20.
//  Copyright © 2021 xinxin. All rights reserved.
//

//*********开发小结***********//  实战在项目中，理论放在markdown中。

1.  UITableViewCell嵌套 UITableView / CollectionView 时计算高度。通过 contentSize配合layoutIfNeeded 来获取

[self.tableView reloadData];
[self.tableView layoutIfNeeded];
[self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
    make.height.mas_equalTo(self.tableView.contentSize.height);
}];

2.



