//
//  MemoryCache.m
//  MyProjectModule
//
//  Created by 鑫鑫 on 2018/9/21.
//  Copyright © 2018年 xinxin. All rights reserved.
//

/**
 >>>AFN Cache Method
 
 
 [关于AFNetworking的缓存机制](https://www.jianshu.com/p/9a98d79267fa)
 
 
 AFNetworking实际上使用了两个独立的缓存机制:AFImagecache和NSURLCache.
 
 AFImagecache：一个提供图片内存缓存的类，继承自NSCache。
 
      AFImageCache是UIImageView+AFNetworking分类的一部分。它继承自NSCache，通过一个URL字符串作为它的key（从NSURLRequest中获取）来存储UIImage对象。
 
 
 NSURLCache：NSURLConnection's默认的URL缓存机制，用于存储NSURLResponse对象：一个默认缓存在内存，通过配置可以缓存到磁盘的类。
 

 对NSURLRequest对象设置缓存策略
 
 NSURLCache对每个NSURLRequest对象都会遵守缓存策略（NSURLRequestCachePolicy）。策略定义如下：
 
 NSURLRequestUseProtocolCachePolicy:指定定义在协议实现里的缓存逻辑被用于URL请求。这是URL请求的默认策略
 
 NSURLRequestReloadIgnoringLocalCacheData:忽略本地缓存，从源加载
 
 NSURLRequestReloadIgnoringLocalAndRemoteCacheData:忽略本地&服务器缓存，从源加载
 
 NSURLRequestReturnCacheDataElseLoad:先从缓存加载，如果没有缓存，从源加载
 
 NSURLRequestReturnCacheDataDontLoad离线模式，加载缓存数据（无论是否过期），不从源加载
 
 NSURLRequestReloadRevalidatingCacheData存在的缓存数据先确认有效性，无效的话从源加载
 
>>>> NSCache
[NSCache详解及SDWebImage缓存策略源码分析] (https://www.jianshu.com/p/239226822bc6)
 
 
>>>> NSMutabelDicnary
 
 */




#import "MemoryCache.h"


@implementation MemoryCache

@end
