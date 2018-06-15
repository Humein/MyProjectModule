//
//  DrawUnlineAndScore.m
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/6/14.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import "DrawUnlineAndScore.h"
@interface DrawUnlineAndScore(){
}
@property (nonatomic, strong) UITextView *textView;

@end
@implementation DrawUnlineAndScore
- (void)drawRange:(NSRange)range withTheView:(UITextView *)textView
{
    self.textView = textView;
    CGRect startRect = [self getRectAtRangePos:range.location];
    CGRect endRect = [self getRectAtRangePos:range.location + range.length];
    CGFloat padding = 1;
    CGFloat margin = 1;
    
    if (ABS(endRect.origin.y - startRect.origin.y) < 5)//They are in the same line
    {
        CGRect wholeRect = CGRectMake(startRect.origin.x, startRect.origin.y + padding, endRect.origin.x - startRect.origin.x, startRect.size.height - 2 * padding);
        // draw
        [self drawWaveLineWithRect:wholeRect];
        CGRect scoreRect = CGRectMake(wholeRect.origin.x + wholeRect.size.width, wholeRect.origin.y + wholeRect.size.height - 7, 30, 50);
        [self drawScoreWithRect:scoreRect];
    }
    else // The range occupies at least two lines
    {
        CGRect firstRect = CGRectMake(startRect.origin.x, startRect.origin.y + padding, self.textView.bounds.size.width - startRect.origin.x - margin, startRect.size.height - 2 * padding);
        // draw
        [self drawWaveLineWithRect:firstRect];
        CGFloat heightDiff = endRect.origin.y - (startRect.origin.y + startRect.size.height);
        if (heightDiff > 5)//The range occupies more than two lines
        {
            CGRect secondRect = CGRectMake(margin, startRect.origin.y + startRect.size.height + padding, self.textView.bounds.size.width - 2*margin, heightDiff - 2 * padding);
            // draw
            [self drawWaveLineWithRect:secondRect];
        }
        CGRect thirdRect = CGRectMake(margin, endRect.origin.y + padding, endRect.origin.x, endRect.size.height - 2* padding);
        // draw
        [self drawWaveLineWithRect:thirdRect];
        CGRect scoreRect = CGRectMake(thirdRect.origin.x + thirdRect.size.width, thirdRect.origin.y + thirdRect.size.height - 7, 30, 50);

        [self drawScoreWithRect:scoreRect];

    }
}


- (void)drawWaveLineWithRect:(CGRect)result1
{
    CGPoint startPoint = CGPointMake(result1.origin.x, result1.origin.y + result1.size.height);
    CGPoint endPoint = CGPointMake(result1.origin.x + result1.size.width, result1.origin.y + result1.size.height);
    UIBezierPath *path = [self getWavePathWithStartPoint:startPoint endPoint:endPoint];
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.lineWidth = 1;
    pathLayer.strokeColor = [UIColor blueColor].CGColor;
    pathLayer.fillColor = nil;
    pathLayer.path = path.CGPath;
    [self.textView.layer addSublayer:pathLayer];
}

- (UIBezierPath *)getWavePathWithStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:startPoint];
    for (int i = 0; i < endPoint.x - startPoint.x; i++)
    {
        CGFloat y = 3 * sinf(i * 0.4) + startPoint.y;
        [path addLineToPoint:CGPointMake(startPoint.x + i, y)];
    }
    [path addLineToPoint:endPoint];
    return path;
}


- (void)drawScoreWithRect:(CGRect)rect
{
    CATextLayer *textLayer = [CATextLayer layer];
    textLayer.frame = rect;
    [self.textView.layer addSublayer:textLayer];
    textLayer.contentsScale = [UIScreen mainScreen].scale;
    //set text attributes
    textLayer.foregroundColor = [UIColor blueColor].CGColor;
    textLayer.alignmentMode = kCAAlignmentJustified;
    textLayer.wrapped = YES;
    
    //choose a font
    UIFont *font = [UIFont systemFontOfSize:11];
    
    //set layer font
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    textLayer.font = fontRef;
    textLayer.fontSize = font.pointSize;
    CGFontRelease(fontRef);
    
    //choose some text
    NSString *text = @"(+10)";
    
    //set layer text
    textLayer.string = text;
}

- (CGRect)getRectAtRangePos:(NSInteger)pos
{
    UITextPosition *beginning = self.textView.beginningOfDocument;
    UITextPosition *start = [self.textView positionFromPosition:beginning offset:pos];
    CGRect rect = [self.textView caretRectForPosition:start];
    return [self.textView convertRect:rect fromView:self.textView.textInputView];
}

@end
