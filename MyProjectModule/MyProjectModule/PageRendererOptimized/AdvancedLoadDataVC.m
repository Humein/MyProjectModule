//
//  AdvancedLoadDataVC.m
//  MyProjectModule
//
//  Created by zhangxinxin on 2020/11/5.
//  Copyright © 2020 xinxin. All rights reserved.
//

#import "AdvancedLoadDataVC.h"

@interface AdvancedLoadDataVC ()

@end

@implementation AdvancedLoadDataVC

// MARK: - LifeCycle
-(void)dealloc {
    NSLog(@"%@销毁啦。。。。。。",NSStringFromClass(self.class));
}

-(void)viewDidLoad {
    [super viewDidLoad];
    [self configVC];
    [self configSubview];
}

// MARK: - View config
-(void)configVC {
    
}

-(void)configSubview {
    
}
// MARK: - Make Data
/// 预请求
/// * 提前请求一些特定接口
//   * 在控制器初始化的时候就开始请求接口，viewDidLoad 之后分两种情况
//     * 数据回来在UI渲染之前  --- 直接刷新
//     * UI渲染之后数据还没回来  --- KVO监听刷新


/**
- (void)advancedLoadData{
    kWeakSelf
    [XesAppShoppingCartViewModel getMineRefundOrderListWithPage:1 success:^(XesAppMineOrderListModel *listModel, NSInteger page) {
        if (listModel.orderList.count > 0) {
             weakSelf.dataSource = [NSMutableArray arrayWithArray:listModel.orderList];
        }
        for (XesAppMineOrderModel *model in weakSelf.dataSource) {
            [model dealData];
        }
    } fail:^(NSError *error) {
    }];
}
 
/// 监听请求回调
- (void)monitorLoadData{
    // 数据回来在UI渲染之前
    if (self.dataSource.count > 0) {
        [self.tableView reloadData];
    }else{
        //UI渲染之后数据还没回来 KVO监听
        [XesAppLoadingView showInView:self.view];
        [self addObserver:self forKeyPath:NSStringFromSelector(@selector(dataSource)) options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld) context:nil];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary*)change context:(void *)context{
    [XesAppLoadingView hideInView:self.view];
    [self.tableView reloadData];
    [self removeObserver:self forKeyPath:NSStringFromSelector(@selector(dataSource))];
}
 
 */

// MARK: - Private Method

// MARK: - Target Methods

// MARK: - Delegate

// MARK: - Getter / Setter

@end
