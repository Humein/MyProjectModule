//
//  XXH264DecodeTool.h
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2019/10/29.
//  Copyright © 2019 xinxin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol  H264DecodeFrameCallbackDelegate <NSObject>

//回调sps和pps数据
- (void)gotDecodedFrame:(CVImageBufferRef )imageBuffer;

@end
@interface XXH264DecodeTool : NSObject


-(BOOL)initH264Decoder;

//解码nalu
-(void)decodeNalu:(uint8_t *)frame size:(uint32_t)frameSize;

- (void)endDecode;

@property (weak, nonatomic) id<H264DecodeFrameCallbackDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
