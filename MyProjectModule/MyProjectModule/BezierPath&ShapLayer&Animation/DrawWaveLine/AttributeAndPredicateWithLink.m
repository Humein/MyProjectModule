//
//  AttributeAndPredicateWithLink.m
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/10/24.
//  Copyright © 2018 xinxin. All rights reserved.
//

#import "AttributeAndPredicateWithLink.h"
#import <YYKit/YYKit.h>
@interface AttributeAndPredicateWithLink()
@property (nonatomic,strong)YYLabel *showLabel;
@end

@implementation AttributeAndPredicateWithLink

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

-(void)initView{
    
    self.showLabel = [[YYLabel alloc]initWithFrame:self.frame];
    self.showLabel.textAlignment = NSTextAlignmentCenter;
    self.showLabel.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    self.showLabel.numberOfLines = 0;
    self.showLabel.backgroundColor = [UIColor colorWithWhite:0.933 alpha:1.000];
    
    
    
    self.showLabel.width = self.frame.size.width;
    self.showLabel.height = self.frame.size.height;
    self.showLabel.top = 0;
    self.showLabel.left = 0;
    
    [self addSubview:self.showLabel];
    
}

-(void)refersheTheViewWithModel:(NSString *)HTStr{
    
    NSMutableAttributedString *text = [NSMutableAttributedString new];

    HTStr = @"以做好前期<准备(+1.0分)>，真准确定位，认清自我，加强<调查(+2.0分)>研究，了解<市场需求(+11.0分)>";
    
    NSMutableAttributedString *one1 = [[NSMutableAttributedString alloc] initWithString:[self displayStringWithRawString:HTStr]];
    one1.font = [UIFont boldSystemFontOfSize:12];
    one1.underlineStyle = NSUnderlineStyleNone;
    
//  组装成字典/模型
    NSDictionary *dic1 =  [self handleTheStringWithRegularExpression:HTStr].copy;

    [dic1.allKeys enumerateObjectsUsingBlock:^(NSString*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [one1 setTextHighlightRange:[one1.string rangeOfString:dic1.allKeys[idx]] color:[UIColor colorWithRed:0.093 green:0.492 blue:1.000 alpha:1.000] backgroundColor:[UIColor colorWithWhite:0.000 alpha:0.220] userInfo:nil tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
            
            NSLog(@"%@",[NSString stringWithFormat:@"Tap: %@",[dic1 objectForKey:[text.string substringWithRange:range]]]);

            
        } longPressAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
            
            
        }];
    }];
    
    [text appendAttributedString:one1];
    [text appendAttributedString:[self padding]];
    
    self.showLabel.attributedText = text;

    
}


- (NSAttributedString *)padding {
    NSMutableAttributedString *pad = [[NSMutableAttributedString alloc] initWithString:@"\n\n"];
    pad.font = [UIFont systemFontOfSize:4];
    return pad;
}
#pragma mark --- 正则处理

// 处理b文本
-(NSDictionary *)handleTheStringWithRegularExpression:(NSString *)rawString{
    
    NSMutableDictionary *dicHandle = [NSMutableDictionary dictionary];
    NSString *pattern = @"<.+?>|\\[.+?\\]";
    NSError *error = nil;
    NSMutableString *dealString = [NSMutableString new];
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
    NSArray<NSTextCheckingResult *> *result = [regex matchesInString:rawString options:0 range:NSMakeRange(0, rawString.length)];
    
    if (!result.count)
    {
        return dicHandle;
    }
    
    NSInteger prelocation = 0;
    NSString *tagString = nil;
    
    for (int i = 0; i< result.count; i++)
    {
        NSTextCheckingResult *res = result[i];
        NSString *subStr = [rawString substringWithRange:NSMakeRange(prelocation, res.range.location - prelocation)];
        [dealString appendString:subStr];
        tagString = [rawString substringWithRange:res.range];
        // 去除标签的tag
        NSString *emptyTagString = [self displayStringWithRawString:tagString];
        
        [dealString appendString:emptyTagString];
        NSString *url= [self getScoreFromTag:tagString];
        NSString *key = emptyTagString;
        [dicHandle setValue:url forKey:key];
        prelocation = res.range.location + tagString.length;
    }
    
    return dicHandle;
}

// get URL
- (NSString *)getScoreFromTag:(NSString *)tagString
{
    NSString *str = [tagString stringByReplacingOccurrencesOfString:@"" withString:@""];
    NSMutableArray *characters = [NSMutableArray array];
    NSMutableString *mutStr = [NSMutableString string];
    
    NSString *pattern = @"\\+[0-9.]{3,}分";
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSArray<NSTextCheckingResult *> *result = [regex matchesInString:str options:0 range:NSMakeRange(0, str.length)];
    if (result.count)
    {
        NSTextCheckingResult *res = result.lastObject;
        NSString *scoreStr = [str substringWithRange:res.range];
        // 分离出字符串中的所有字符，并存储到数组characters中
        for (int i = 0; i < scoreStr.length; i++)
        {
            NSString *subString = [scoreStr substringToIndex:i + 1];
            subString = [subString substringFromIndex:i];
            [characters addObject:subString];
        }
        BOOL start = NO;
        for (NSString *b in characters)
        {
            if ([b isEqualToString:@"+"])
            {
                start = YES;
            }
            if (start)
            {
                NSString *regex = @"^[0-9 | .]*$";
                NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
                BOOL isShu = [pre evaluateWithObject:b];// 对b进行谓词运算
                if (isShu)
                    [mutStr appendString:b];
            }
        }
    }
    return mutStr;
}


// 去标签
- (NSString *)displayStringWithRawString:(NSString *)searchText
{
    NSString *pattern = @"<.+?>|\\[.+?\\]";
    NSError *error = nil;
    NSMutableString *dealString = [NSMutableString string];
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
    NSArray<NSTextCheckingResult *> *result = [regex matchesInString:searchText options:0 range:NSMakeRange(0, searchText.length)];
    if (result)
    {
        NSInteger prelocation = 0;
        NSString *tagStr = nil;
        for (int i = 0; i<result.count; i++)
        {
            NSTextCheckingResult *res = result[i];
            NSString *subStr = [searchText substringWithRange:NSMakeRange(prelocation, res.range.location - prelocation)];
            [dealString appendString:subStr];
            tagStr = [searchText substringWithRange:res.range];
            if ([tagStr hasPrefix:@"["])
            {
                // [dealString appendString:@"#####"];
                NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\(.+?\\)" options:NSRegularExpressionCaseInsensitive error:&error];
                NSArray<NSTextCheckingResult *> *result = [regex matchesInString:tagStr options:0 range:NSMakeRange(0, tagStr.length)];
                if (result.count)
                {
                    NSString *defen = [tagStr substringWithRange:result[0].range];
                    NSString *content = [tagStr substringWithRange:NSMakeRange(1, tagStr.length - 2 - defen.length)];
                    [dealString appendString:content];
                }
                else
                {
                    NSString *content = [tagStr substringWithRange:NSMakeRange(1, tagStr.length - 2)];
                    [dealString appendString:content];
                }
            }
            else if ([tagStr hasPrefix:@"<"])
            {
                // [dealString appendString:@"$$$$$"];
                NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\(.+?\\)" options:NSRegularExpressionCaseInsensitive error:&error];
                NSArray<NSTextCheckingResult *> *result = [regex matchesInString:tagStr options:0 range:NSMakeRange(0, tagStr.length)];
                if (result.count)
                {
                    NSString *defen = [tagStr substringWithRange:result[0].range];
                    NSString *content = [tagStr substringWithRange:NSMakeRange(1, tagStr.length - 2 - defen.length)];
                    [dealString appendString:content];
                }
                else
                {
                    NSString *content = [tagStr substringWithRange:NSMakeRange(1, tagStr.length - 2)];
                    [dealString appendString:content];
                }
            }
            // model
            prelocation = res.range.location + tagStr.length;
        }
        NSString *subStr = [searchText substringWithRange:NSMakeRange(prelocation, searchText.length - prelocation)];
        [dealString appendString:subStr];
        return [dealString copy];
    }
    else
    {
        return nil;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
