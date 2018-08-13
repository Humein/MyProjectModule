//
//  CorrectResolver.m
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/8/13.
//  Copyright © 2018年 xinxin. All rights reserved.
//
#define FAKE_DOT @"$"
#define FAKE_ELLIPSIS @"&"
#import "CorrectResolver.h"
#import "ResovlerModel.h"

@implementation CorrectResolver
- (NSArray <ResovlerModel *>*)getSentenceItemsWithString:(NSString *)string
{
    // 替换所有标签内的所有特殊字符
    NSString *result = [self enableSentenceStringWithRawString:string];
    NSArray <ResovlerModel *>*arr = [self breakIntoSentencesFromString:result];
    // 遍历每一句话
    NSMutableArray *sentenceItems = [NSMutableArray arrayWithCapacity:0];
    NSMutableString *temp = [[NSMutableString alloc] init];
    for (ResovlerModel *item in arr)
    {
        ResovlerModel *model = [self updateSentenceTagsItemFromOld:item];
        [temp appendString:model.contentStr];
        model.range = [temp rangeOfString:model.contentStr];
        [sentenceItems addObject:model];
    }
    return [sentenceItems copy];
}

/** 更新句子模型信息 */
- (ResovlerModel *)updateSentenceTagsItemFromOld:(ResovlerModel *)sentenceItem
{
//    正则匹配 标记段落
    NSString *pattern = @"<.+?>|\\[.+?\\]";
    NSError *error = nil;
    NSMutableString *dealString = [NSMutableString new];
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
    NSArray<NSTextCheckingResult *> *result = [regex matchesInString:sentenceItem.contentStr options:0 range:NSMakeRange(0, sentenceItem.contentStr.length)];
    if (!result.count)
    {
        return sentenceItem;
    }
    NSInteger prelocation = 0;
    NSString *tagString = nil;
    NSMutableArray *tagItems = [NSMutableArray arrayWithCapacity:0];
    
    //    栈结构 匹配符号
    for (int i = 0; i< result.count; i++)
    {
        CorrectTagModel *tagItem = [CorrectTagModel new];
        NSTextCheckingResult *res = result[i];
        NSString *subStr = [sentenceItem.contentStr substringWithRange:NSMakeRange(prelocation, res.range.location - prelocation)];
        [dealString appendString:subStr];
        tagString = [sentenceItem.contentStr substringWithRange:res.range];
        // 去除标签的tag
        NSString *emptyTagString = [self displayStringWithRawString:tagString];
        if ([tagString hasPrefix:@"<"])
        {
            tagItem.tagType = SLCorrectTagTypeJianHao;
        }
        else if ([tagString hasPrefix:@"["])
        {
            tagItem.tagType = SLCorrectTagTypeZhongHao;
        }
        [dealString appendString:emptyTagString];
        tagItem.score = [self getScoreFromTag:tagString];
        tagItem.range = [dealString rangeOfString:emptyTagString];
        [tagItems addObject:tagItem];
        NSLog(@"%@",tagString);
        // 更新位置
        prelocation = res.range.location + tagString.length;
    }
    sentenceItem.tags = [tagItems copy];
    sentenceItem.contentStr = [self displayStringWithRawString:sentenceItem.contentStr];
    sentenceItem.hasUnderWave = YES;
    return sentenceItem;
}

- (CGFloat)getScoreFromTag:(NSString *)tagString
{
    NSString *str = [tagString stringByReplacingOccurrencesOfString:FAKE_DOT withString:@"."];
    // NSString *s = [str stringByReplacingOccurrencesOfString:FAKE_ELLIPSIS withString:@"……"];
    NSString *s = str;
    NSMutableArray *characters = [NSMutableArray array];
    NSMutableString *mutStr = [NSMutableString string];
    // 分离出字符串中的所有字符，并存储到数组characters中
    for (int i = 0; i < s.length; i ++)
    {
        NSString *subString = [s substringToIndex:i + 1];
        subString = [subString substringFromIndex:i];
        [characters addObject:subString];
    }
    for (NSString *b in characters)
    {
        NSString *regex = @"^[0-9 | .]*$";
        NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        BOOL isShu = [pre evaluateWithObject:b];// 对b进行谓词运算
        if (isShu)
            [mutStr appendString:b];
    }
    return [mutStr floatValue];
}

/** 分割句子 */
- (NSArray<ResovlerModel *>*)breakIntoSentencesFromString:(NSString *)string
{
    NSArray *arr =@[@"。",@".",@";",@"；",@"…",@"!",@"?",@"？",@",",@"，",@"！",@":",@"：",@"\n"];
    //    NSArray *arr = @[@"。",@",",@".",@",",@";",@",",@"；",@"…",@",",@"!",@",",@"?",@",",@"？",@",",@",",@",",@"，",@",",@"！",@",",@":",@",",@"：",@",",@",",@"。",@",",@"\n"];
    
    NSInteger youbiao = 0;
    NSInteger location = 0;
    NSMutableArray *temp = [NSMutableArray array];
    for (int i = 0; i < string.length; i++)
    {
        NSString *target = [string substringWithRange:NSMakeRange(youbiao, 1)];
        BOOL isDot = NO;
        for (NSString *biaodian in arr)
        {
            if ([biaodian isEqualToString:target])
            {
                isDot = YES;
                break;
            }
        }
        if (isDot == YES)
        {
            ResovlerModel *item = [ResovlerModel new];
            NSRange range = NSMakeRange(location, youbiao - location + 1);
            item.contentStr = [string substringWithRange:range];
            item.haveTagRange = range;
            [temp addObject:item];
            location = youbiao + 1;
        }
        youbiao++;
    }
    ResovlerModel *item = [ResovlerModel new];
    NSRange range = NSMakeRange(location, youbiao - location);
    item.contentStr = [string substringWithRange:range];
    item.haveTagRange = range;
    [temp addObject:item];
    return [temp copy];
}

/** 用于处理有过标记的字符串 */
- (NSString *)enableSentenceStringWithRawString:(NSString *)rawString
{
    NSString *pattern = @"<.+?>|\\[.+?\\]";
    NSError *error = nil;
    NSMutableString *dealString = [NSMutableString string];
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
    NSArray<NSTextCheckingResult *> *result = [regex matchesInString:rawString options:0 range:NSMakeRange(0, rawString.length)];
    if (!result)
        return nil;
    
    NSInteger prelocation = 0;
    NSString *tagStr = nil;
    for (int i = 0; i<result.count; i++)
    {
        NSTextCheckingResult *res = result[i];
        NSString *subStr = [rawString substringWithRange:NSMakeRange(prelocation, res.range.location - prelocation)];
        [dealString appendString:subStr];
        tagStr = [rawString substringWithRange:res.range];
        NSString *str = [tagStr stringByReplacingOccurrencesOfString:@"." withString:FAKE_DOT];
        NSString *str2 = [str stringByReplacingOccurrencesOfString:@"……" withString:FAKE_ELLIPSIS];
        [dealString appendString:str2];
        // model
        prelocation = res.range.location + tagStr.length;
    }
    NSString *subStr = [rawString substringWithRange:NSMakeRange(prelocation, rawString.length - prelocation)];
    [dealString appendString:subStr];
    return [dealString copy];
}

/** 去除标签方法 */
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
@end
