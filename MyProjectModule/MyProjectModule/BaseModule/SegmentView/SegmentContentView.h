//
//  SegmentContentView.h
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/6/19.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SegmentContentView;
@protocol SegmentContentViewDelegate <NSObject>
@optional

/**
 link SegmentTitleView method

 @param segmentContentCollectionView SegmentContentView
 @param offset SegmentContentView's content  scroll offset
 @param originalIndex  original content's Index
 @param targetIndex target content's Index
 */
- (void)segmentContentView:(SegmentContentView *)segmentContentCollectionView offset:(CGFloat)offset originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex;

/**
   Provide the method for SegmentContentView which on Controller. with the offset solve back gesture problem

 @param segmentContentCollectionView SegmentContentView
 @param offsetX SegmentContentView SegmentContentView's content offset
 */
- (void)segmentContentView:(SegmentContentView *)segmentContentCollectionView offsetX:(CGFloat)offsetX;
@end

@interface SegmentContentView : UIView
@property (nonatomic, weak) id<SegmentContentViewDelegate> delegateSegmentContent;

@property (nonatomic, assign) BOOL isScrollEnabled;


/**
 init

 @param frame frame
 @param parentVC parentVC
 @param childVCs childVCs
 
 */
- (instancetype)initWithFrame:(CGRect)frame parentVC:(UIViewController *)parentVC childVCs:(NSArray *)childVCs;


/**
 setPageContentCollectionViewCurrentIndex

 @param currentIndex As the titleView's selected and show the childVC
 */
- (void)setPageContentCollectionViewCurrentIndex:(NSInteger)currentIndex;

@end
