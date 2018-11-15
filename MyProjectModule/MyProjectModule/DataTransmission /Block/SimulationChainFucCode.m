//
//  SimulationChainFucCode.m
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2018/11/15.
//  Copyright © 2018 xinxin. All rights reserved.
//

#import "SimulationChainFucCode.h"

@implementation SimulationChainFucCode

+(instancetype)initWith:(void (^)(SimulationChainFucCode *))BLOCK{
    SimulationChainFucCode * view = [[SimulationChainFucCode alloc]init];
    
    if (BLOCK) {
        BLOCK(view);
    }
    return view;
    
}
-(SimulationChainFucCode *(^)(CGRect))viewFrame{
    return  ^SimulationChainFucCode*(CGRect rect){
        
        self.frame = rect;
        return self;
    };
    
    
}
-(SimulationChainFucCode *(^)(CGFloat))layerCornerRadious{
    return ^SimulationChainFucCode*(CGFloat radious){
        
        self.layer.cornerRadius = radious;
        self.layer.masksToBounds = YES;
        return self;
    };
    
}

-(SimulationChainFucCode *(^)(NSString *))ColorString{
    
    return ^SimulationChainFucCode* (NSString * colorStr){
        
        self.backgroundColor = [UIColor redColor];
        return self;
    };
    
}
@end
