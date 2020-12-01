//
//  WebViewPrintPageRenderer.h
//  MyProjectModule
//
//  Created by zhangxinxin on 2020/11/10.
//  Copyright © 2020 xinxin. All rights reserved.
//
/*===================================================
        * 文件描述 ：webView全部截图 pdf 转 image*
=====================================================*/
#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WebViewPrintPageRenderer : NSObject
/// 打印图片
-(UIImage *)printContentToImageWithWeb:(WKWebView *)webView;
@end

NS_ASSUME_NONNULL_END
