//
//  WebViewPrintPageRenderer.m
//  MyProjectModule
//
//  Created by zhangxinxin on 2020/11/10.
//  Copyright © 2020 xinxin. All rights reserved.
//

#import "WebViewPrintPageRenderer.h"
@interface WebViewPrintPageRenderer()
@property(nonatomic,weak)WKWebView* webView;
@end
@implementation WebViewPrintPageRenderer
#pragma mark -
#pragma mark - life cycle - 生命周期
- (void)dealloc{
    NSLog(@"%@ - dealloc", NSStringFromClass([self class]));
}

- (instancetype)init{
    if (self = [super init]) {
        [self setup];
    }
    return self;
}

#pragma mark -
#pragma mark - init setup - 初始化
- (void)setup{
    [self setDefault];//初始化默认数据
}

/// 设置默认数据
- (void)setDefault{
    
}

#pragma mark -
#pragma mark - public methods
-(UIImage *)printContentToImageWithWeb:(WKWebView *)webView{
    //        let urlStr = "https://land.3fang.com/market/110100_110108_________1.html"
    self.webView = webView;
    UIPrintPageRenderer *renderer = [[UIPrintPageRenderer alloc] init];
    [renderer addPrintFormatter:[self.webView viewPrintFormatter] startingAtPageAtIndex:0];
      
    CGRect page;
    page.origin.x = 0;
    page.origin.y = 0;
    page.size.width = webView.scrollView.contentSize.width;
    // 预计算高度 - self.webView.scrollView.contentSize.height 高度过高
    page.size.height = [self getPrintHeight];
      
    CGRect printable = CGRectInset( page, 0, 0 );
      
    [renderer setValue:[NSValue valueWithCGRect:page] forKey:@"paperRect"];
    [renderer setValue:[NSValue valueWithCGRect:printable] forKey:@"printableRect"];
      
    NSMutableData * data = [NSMutableData data];
    UIGraphicsBeginPDFContextToData( data, page, nil );
      
    for (NSInteger i=0; i < [renderer numberOfPages]; i++) {
        UIGraphicsBeginPDFPage();
        CGRect bounds = UIGraphicsGetPDFContextBounds();
        [renderer drawPageAtIndex:i inRect:bounds];
    }
      
    UIGraphicsEndPDFContext();
    
    
    // 保存PDF
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,     NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString * pdfFile = [documentsDirectory stringByAppendingPathComponent:@"test.pdf"];
    [data writeToFile:pdfFile atomically:YES];
    
    
    // PDF转image
    CGDataProviderRef provider = CGDataProviderCreateWithCFData((__bridge CFDataRef)data);
    CGPDFDocumentRef pdf = CGPDFDocumentCreateWithProvider(provider);
    CGDataProviderRelease(provider);
    CGPDFPageRef pages = CGPDFDocumentGetPage(pdf, 1);
    if (!pages) {
        CGPDFDocumentRelease(pdf);
        return nil;
    }
    CGRect pdfRect = CGPDFPageGetBoxRect(pages, kCGPDFCropBox);
    CGSize pdfSize = pdfRect.size;
    CGFloat scale = [UIScreen mainScreen].scale;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(NULL, pdfSize.width * scale, pdfSize.height * scale, 8, 0, colorSpace, kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedFirst);
    if (!ctx) {
        CGColorSpaceRelease(colorSpace);
        CGPDFDocumentRelease(pdf);
        return nil;
    }
    
    CGContextScaleCTM(ctx, scale, scale);
    CGContextTranslateCTM(ctx, -pdfRect.origin.x, -pdfRect.origin.y);
    CGContextDrawPDFPage(ctx, pages);
    CGPDFDocumentRelease(pdf);
    
    CGImageRef image = CGBitmapContextCreateImage(ctx);
    UIImage *pdfImage = [[UIImage alloc] initWithCGImage:image scale:scale orientation:UIImageOrientationUp];
    CGImageRelease(image);
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    return pdfImage;
}

#pragma mark -
#pragma mark - <#custom#> Delegate

#pragma mark -
#pragma mark - private methods
// 预计算高度
- (CGFloat)getPrintHeight {
    
    UIPrintPageRenderer *renderer = [[UIPrintPageRenderer alloc] init];
    
    [renderer addPrintFormatter:[self.webView viewPrintFormatter] startingAtPageAtIndex:0];
    
    CGRect page;
    page.origin.x = 0;
    page.origin.y = 0;
    page.size.width = self.webView.scrollView.contentSize.width;
    page.size.height = 50;

    CGRect printable = CGRectInset( page, 0, 0 );
    
    [renderer setValue:[NSValue valueWithCGRect:page] forKey:@"paperRect"];
    [renderer setValue:[NSValue valueWithCGRect:printable] forKey:@"printableRect"];
    
    NSMutableData * pdfData = [NSMutableData data];
    UIGraphicsBeginPDFContextToData( pdfData, page, nil );
    
    CGFloat height = 0;
    for (NSInteger i=0; i < [renderer numberOfPages]; i++) {
        UIGraphicsBeginPDFPage();
        CGRect bounds = UIGraphicsGetPDFContextBounds();
        [renderer drawPageAtIndex:i inRect:bounds];
        height += bounds.size.height;
    }
    
    UIGraphicsEndPDFContext();
    return height;
}

#pragma mark -
#pragma mark - getters and setters
@end
