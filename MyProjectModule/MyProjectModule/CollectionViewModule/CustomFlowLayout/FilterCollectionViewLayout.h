//
//  FilterCollectionViewLayout.h
//  HuaTuOnLine
//
//  Created by Zhang Xin Xin on 2018/11/23.
//  Copyright © 2018 HTZX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FilterCollectionViewLayout;

@protocol  filterLayoutDeleaget <NSObject>

@required
/**
 * 每个item的高度
 */
- (CGFloat)waterFallLayout:(FilterCollectionViewLayout *)waterFallLayout heightForItemAtIndexPath:(NSUInteger)indexPath itemWidth:(CGFloat)itemWidth;

@optional
/**
 * 有多少列
 */
- (NSUInteger)columnCountInWaterFallLayout:(FilterCollectionViewLayout *)waterFallLayout;

/**
 * 每列之间的间距
 */
- (CGFloat)columnMarginInWaterFallLayout:(FilterCollectionViewLayout *)waterFallLayout;

/**
 * 每行之间的间距
 */
- (CGFloat)rowMarginInWaterFallLayout:(FilterCollectionViewLayout *)waterFallLayout;

/**
 * 每个item的内边距
 */
- (UIEdgeInsets)edgeInsetdInWaterFallLayout:(FilterCollectionViewLayout *)waterFallLayout;


@end

/// 选择标签瀑布流 Layout
@interface FilterCollectionViewLayout : UICollectionViewLayout

@property (nonatomic, weak) id<filterLayoutDeleaget> delegate;

@end

NS_ASSUME_NONNULL_END
