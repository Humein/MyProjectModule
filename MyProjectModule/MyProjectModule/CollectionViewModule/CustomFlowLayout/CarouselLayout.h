//
//  CarouselLayout.h
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/6/19.
//  Copyright © 2018年 xinxin. All rights reserved.
//
//        旋转木马

#import <UIKit/UIKit.h>
typedef void(^JSCarouselSlideIndexBlock)(NSInteger index);

@interface CarouselLayout : UICollectionViewLayout
@property (nonatomic, copy) JSCarouselSlideIndexBlock carouselSlideIndexBlock;

@property (nonatomic) NSInteger visibleCount;

@property (nonatomic) CGSize itemSize;
@end
