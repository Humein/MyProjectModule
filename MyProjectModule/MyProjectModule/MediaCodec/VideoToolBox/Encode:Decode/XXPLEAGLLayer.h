//
//  XXPLEAGLLayer.h
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2019/10/29.
//  Copyright © 2019 xinxin. All rights reserved.
//

//  This CAEAGLLayer subclass demonstrates how to draw a CVPixelBufferRef using OpenGLES and display the timecode associated with that pixel buffer in the top right corner.

#include <QuartzCore/QuartzCore.h>
#include <CoreVideo/CoreVideo.h>

NS_ASSUME_NONNULL_BEGIN

@interface XXPLEAGLLayer : CAEAGLLayer

@property (nonatomic) CVPixelBufferRef pixelBuffer;

- (id)initWithFrame:(CGRect)frame;
- (void)resetRenderBuffer;

@end

NS_ASSUME_NONNULL_END
