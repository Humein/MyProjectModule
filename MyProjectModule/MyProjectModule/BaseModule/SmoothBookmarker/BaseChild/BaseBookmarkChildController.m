//
//  BaseBookmarkChildController.m
//  benkelaile-iOS
//
//  Created by Zhang Xin Xin on 2019/4/19.
//  Copyright © 2019 sunlands. All rights reserved.
//

#import "BaseBookmarkChildController.h"

@interface BaseBookmarkChildController ()

@end

@implementation BaseBookmarkChildController

// UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(listViewDidScroll:)]) {
        
        [self.delegate listViewDidScroll:scrollView];
    }
}



@end
