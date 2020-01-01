//
//  ClassClusterBaseTableViewCell.m
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2019/1/16.
//  Copyright © 2019 xinxin. All rights reserved.
//

#import "ClassClusterBaseTableViewCell.h"
#import "ClassClusterTableViewCellA.h"
#import "ClassClusterTableViewCellB.h"
#import "ClassClusterTableViewCellC.h"

@implementation ClassClusterBaseTableViewCell

+ (instancetype)cellWithType:(XXClassClusterType)type {
    // 根据type创建对应的子类cell
    switch (type) {
        case XXClassClusterTypeA:
        {
            return [[ClassClusterTableViewCellA alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:XXClassClusterCellAReuseID];
        }
            break;
            
        case XXClassClusterTypeB:
        {
            return [[ClassClusterTableViewCellB alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:XXClassClusterCellBReuseID];
        }
            break;
            
        case XXClassClusterTypeC:
        {
            return [[ClassClusterTableViewCellC alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:XXClassClusterCellCReuseID];
        }
            break;
    }
}

- (void)setModel:(ClassClusterModel *)model {
    // 子类重写
}

@end
