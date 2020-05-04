//
//  RenderImageViewController.m
//  MyProjectModule
//
//  Created by XinXin on 2020/4/30.
//  Copyright © 2020 xinxin. All rights reserved.
//

#import "RenderImageViewController.h"
#import <OpenGLES/ES3/gl.h>
#import <OpenGLES/ES3/glext.h>
#import <GLKit/GLKit.h>

@interface RenderImageViewController ()<GLKViewDelegate>{
    EAGLContext *_context;
    /**
     GLKBaseEffect 一种简单的光照/着色系统，用于基于着色器OpenGL渲染.
     
     */
    GLKBaseEffect *_cEffect;
}

@end

@implementation RenderImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //1.OpenGL ES 相关初始化
    [self setUpConfig];
    
    [self setUpVertexData];
    
    [self setUpTexture];
    
}
-(void)setUpConfig{
   
    //初始化上下文,调用es3.0的API
    _context = [[EAGLContext alloc]initWithAPI:(kEAGLRenderingAPIOpenGLES3)];
    if (!_context) {
        NSLog(@"初始化OpenGLes失败");
    }
    [EAGLContext setCurrentContext:_context];
    
    //2.获取GLKView(等下图片是加载在这上面) & 设置context
    GLKView *view =(GLKView *) self.view;
    view.context = _context;
    //- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect;在代理方法里实现图像绘制
    view.delegate = self;
    
    //4.设置背景颜色,默认是黑色
    glClearColor(1, 1, 1, 1.0);
    
}
-(void)setUpVertexData{
    //1.设置顶点数组(顶点坐标,纹理坐标),顶点的坐标原点在屏幕中心
    /*
     纹理坐标系取值范围[0,1];原点是左下角(0,0);
     故而(0,0)是纹理图像的左下角, 点(1,1)是右上角.
     */
    GLfloat vertexData[] = {
        //顶点坐标            纹理坐标
        0.5, -0.25, 0.0f,    1.0f, 0.0f, //右下
        0.5, 0.25, -0.0f,    1.0f, 1.0f, //右上
        -0.5, 0.25, 0.0f,    0.0f, 1.0f, //左上
        
        0.5, -0.25, 0.0f,    1.0f, 0.0f, //右下
        -0.5, 0.25, 0.0f,    0.0f, 1.0f, //左上
        -0.5, -0.25, 0.0f,   0.0f, 0.0f, //左下
    };
    //翻转图片
//    GLfloat vertexData[] = {
//        //顶点坐标            纹理坐标
//        0.5, -0.25, 0.0f,    0.0f, 1.0f, //右下
//        0.5, 0.25, -0.0f,    0.0f, 0.0f, //右上
//        -0.5, 0.25, 0.0f,    1.0f, 0.0f, //左上
//
//        0.5, -0.25, 0.0f,    0.0f, 1.0f, //右下
//        -0.5, 0.25, 0.0f,    1.0f, 0.0f, //左上
//        -0.5, -0.25, 0.0f,   1.0f, 1.0f, //左下
//    };
    //2.开辟顶点缓存区
    //(1).创建顶点缓存区标识符ID
    GLuint bufferID;
    glGenBuffers(1, &bufferID);
    //(2).绑定顶点缓存区.(明确作用)
    glBindBuffer(GL_ARRAY_BUFFER, bufferID);
    //(3).将顶点数组的数据copy到顶点缓存区中(GPU显存中) GL_STATIC_DRAW:不经常变化的图片使用这个
    glBufferData(GL_ARRAY_BUFFER, sizeof(vertexData), vertexData, GL_STATIC_DRAW);
    
    //打开属性通道,默认是关闭的
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    //上传顶点数据到显存
    /*
     参数列表:
     index,指定要修改的顶点属性的索引值
     size, 每次读取数量。（如position是由3个（x,y,z）组成，而颜色是4个（r,g,b,a）,纹理则是2个.）
     type,指定数组中每个组件的数据类型。可用的符号常量有GL_BYTE, GL_UNSIGNED_BYTE, GL_SHORT,GL_UNSIGNED_SHORT, GL_FIXED, 和 GL_FLOAT，初始值为GL_FLOAT。
     normalized,指定当被访问时，固定点数据值是否应该被归一化（GL_TRUE）或者直接转换为固定点值（GL_FALSE）
     stride,指定连续顶点属性之间的偏移量。如果为0，那么顶点属性会被理解为：它们是紧密排列在一起的。初始值为0
     ptr指定一个指针，指向数组中第一个顶点属性的第一个组件。初始值为0
     */
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(GLfloat) * 5, (GLfloat *)NULL + 0);
    //纹理坐标数据
    glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
    glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, sizeof(GLfloat) * 5, (GLfloat *)NULL + 3);
    
}

-(void)setUpTexture{
    //1.获取纹理图片路径
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"miao" ofType:@"jpg"];
    
    //2.设置纹理参数
    //纹理坐标原点是左下角,但是图片显示原点应该是左上角.
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:@(1),GLKTextureLoaderOriginBottomLeft, nil];
    
    GLKTextureInfo *textureInfo = [GLKTextureLoader textureWithContentsOfFile:filePath options:options error:nil];
    
    //3.使用苹果GLKit 提供GLKBaseEffect 完成着色器工作(顶点/片元)
    _cEffect = [[GLKBaseEffect alloc]init];
    _cEffect.texture2d0.enabled = GL_TRUE;
    _cEffect.texture2d0.name = textureInfo.name;
}
#pragma mark - GLKViewDelegate
//在这里绘制视图的内容
- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect{
    glClear(GL_COLOR_BUFFER_BIT);
    [_cEffect prepareToDraw];
    /**
     *第一个参数:绘制方式,es2.0之后有以下方式
                GL_POINTS、GL_LINES、GL_LINE_LOOP、GL_LINE_STRIP、GL_TRIANGLES、GL_TRIANGLE_STRIP、GL_TRIANGLE_FAN
     *第二个参数:从哪个顶点开始绘制
     *第三个参数:顶点数
     */
    glDrawArrays(GL_TRIANGLES, 0, 6);
}


@end
