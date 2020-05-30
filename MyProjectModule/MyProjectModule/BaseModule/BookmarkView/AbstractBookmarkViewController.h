//
//  AbstractBookmarkViewController.h
//  benkelaile-iOS
//
//  Created by Zhang Xin Xin on 2019/4/19.
//  Copyright © 2019 sunlands. All rights reserved.
//

#import "AbstractViewController.h"
#import "BookMarkView.h"
#import "CheckConditionItem.h"
#import "CheckConditionCollectionViewCell.h"

@interface AbstractBookmarkViewController : AbstractViewController<BookMarkViewDataSource,BookMarkViewDelegate>

@property (nonatomic,strong)NSMutableArray *itemsArray;

@property (nonatomic,strong)BookMarkView *bookmarkView;


@end
