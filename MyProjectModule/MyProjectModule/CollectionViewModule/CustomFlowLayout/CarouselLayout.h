//
//  CarouselLayout.h
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/6/19.
//  Copyright © 2018年 xinxin. All rights reserved.
//
#import <UIKit/UIKit.h>
typedef void(^JSCarouselSlideIndexBlock)(NSInteger index);
/// 旋转木马  UICollectionView Layout
@interface CarouselLayout : UICollectionViewLayout
@property (nonatomic, copy) JSCarouselSlideIndexBlock carouselSlideIndexBlock;

@property (nonatomic) NSInteger visibleCount;

@property (nonatomic) CGSize itemSize;
@end
