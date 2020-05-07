//
//  RotationImageViewController.m
//  MyProjectModule
//
//  Created by XinXin on 2020/5/7.
//  Copyright © 2020 xinxin. All rights reserved.
//

#import "RotationImageViewController.h"
#import <GLKit/GLKit.h>


typedef struct {
    GLKVector3 positionCoord;   //顶点坐标
    GLKVector2 textureCoord;    //纹理坐标
    GLKVector3 normal;          //法线
} CCVertex;

// 顶点数
static NSInteger const kCoordCount = 36;

@interface RotationImageViewController () <GLKViewDelegate>

@property (nonatomic, strong) GLKView *glkView;
@property (nonatomic, strong) GLKBaseEffect *baseEffect;
@property (nonatomic, assign) CCVertex *vertices;

@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, assign) NSInteger angle;
@property (nonatomic, assign) GLuint vertexBuffer;

@end

@implementation RotationImageViewController

- (void)dealloc {
    
    if ([EAGLContext currentContext] == self.glkView.context) {
        [EAGLContext setCurrentContext:nil];
    }
    if (_vertices) {
        free(_vertices);
        _vertices = nil;
    }
    
    if (_vertexBuffer) {
        glDeleteBuffers(1, &_vertexBuffer);
        _vertexBuffer = 0;
    }
    
    //displayLink 失效
    [self.displayLink invalidate];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //1.View背景色
    self.view.backgroundColor = [UIColor blackColor];
   
    //2. OpenGL ES 相关初始化
    [self commonInit];
    
    //3.顶点/纹理坐标数据
    [self vertexDataSetup];
    
    //4. 添加CADisplayLink
    [self addCADisplayLink];

}
-(void) addCADisplayLink{
   
    //CADisplayLink 类似定时器,提供一个周期性调用.属于QuartzCore.framework中.
    //具体可以参考该博客 https://www.cnblogs.com/panyangjun/p/4421904.html
    self.angle = 0;
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(update)];
    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)commonInit {
   
    //1.创建context
     EAGLContext *context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES3];
    //设置当前context
    [EAGLContext setCurrentContext:context];
    
    //2.创建GLKView并设置代理
    CGRect frame = CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.width);
    self.glkView = [[GLKView alloc] initWithFrame:frame context:context];
    self.glkView.backgroundColor = [UIColor clearColor];
    self.glkView.delegate = self;
    
    //3.使用深度缓存
    self.glkView.drawableDepthFormat = GLKViewDrawableDepthFormat24;
    //默认是(0, 1)，这里用于翻转 z 轴，使正方形朝屏幕外
    //glDepthRangef(1, 0);
    
    //4.将GLKView 添加self.view 上
    [self.view addSubview:self.glkView];

    //5.获取纹理图片
    NSString *imagePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"miao.jpeg"];
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    
    //6.设置纹理参数
    NSDictionary *options = @{GLKTextureLoaderOriginBottomLeft : @(YES)};
    GLKTextureInfo *textureInfo = [GLKTextureLoader textureWithCGImage:[image CGImage]
                                                               options:options
                                                                 error:NULL];
  
    //7.使用baseEffect
    self.baseEffect = [[GLKBaseEffect alloc] init];
    self.baseEffect.texture2d0.name = textureInfo.name;
    self.baseEffect.texture2d0.target = textureInfo.target;

}

-(void)vertexDataSetup
{
    /*
     解释一下:
     这里我们不复用顶点，使用每 3 个点画一个三角形的方式，需要 12 个三角形，则需要 36 个顶点
     以下的数据用来绘制以（0，0，0）为中心，边长为 1 的立方体
     */
    
    //8. 开辟顶点数据空间(数据结构SenceVertex 大小 * 顶点个数kCoordCount)
    self.vertices = malloc(sizeof(CCVertex) * kCoordCount);
    
    // 前面
    self.vertices[0] = (CCVertex){{-0.5, 0.5, 0.5},  {0, 1}};//前面左上角
    self.vertices[1] = (CCVertex){{-0.5, -0.5, 0.5}, {0, 0}};//前面左下角
    self.vertices[2] = (CCVertex){{0.5, 0.5, 0.5},   {1, 1}};//前面右上角
    
    self.vertices[3] = (CCVertex){{-0.5, -0.5, 0.5}, {0, 0}};//前面左下角
    self.vertices[4] = (CCVertex){{0.5, 0.5, 0.5},   {1, 1}};//前面右上角
    self.vertices[5] = (CCVertex){{0.5, -0.5, 0.5},  {1, 0}};//前面右下角
    
    // 上面
    self.vertices[6] = (CCVertex){{0.5, 0.5, 0.5},    {1, 1}};
    self.vertices[7] = (CCVertex){{-0.5, 0.5, 0.5},   {0, 1}};
    self.vertices[8] = (CCVertex){{0.5, 0.5, -0.5},   {1, 0}};
    self.vertices[9] = (CCVertex){{-0.5, 0.5, 0.5},   {0, 1}};
    self.vertices[10] = (CCVertex){{0.5, 0.5, -0.5},  {1, 0}};
    self.vertices[11] = (CCVertex){{-0.5, 0.5, -0.5}, {0, 0}};
    
    // 下面
    self.vertices[12] = (CCVertex){{0.5, -0.5, 0.5},    {1, 1}};
    self.vertices[13] = (CCVertex){{-0.5, -0.5, 0.5},   {0, 1}};
    self.vertices[14] = (CCVertex){{0.5, -0.5, -0.5},   {1, 0}};
    self.vertices[15] = (CCVertex){{-0.5, -0.5, 0.5},   {0, 1}};
    self.vertices[16] = (CCVertex){{0.5, -0.5, -0.5},   {1, 0}};
    self.vertices[17] = (CCVertex){{-0.5, -0.5, -0.5},  {0, 0}};
    
    // 左面
    self.vertices[18] = (CCVertex){{-0.5, 0.5, 0.5},    {1, 1}};
    self.vertices[19] = (CCVertex){{-0.5, -0.5, 0.5},   {0, 1}};
    self.vertices[20] = (CCVertex){{-0.5, 0.5, -0.5},   {1, 0}};
    self.vertices[21] = (CCVertex){{-0.5, -0.5, 0.5},   {0, 1}};
    self.vertices[22] = (CCVertex){{-0.5, 0.5, -0.5},   {1, 0}};
    self.vertices[23] = (CCVertex){{-0.5, -0.5, -0.5},  {0, 0}};
    
    // 右面
    self.vertices[24] = (CCVertex){{0.5, 0.5, 0.5},    {1, 1}};
    self.vertices[25] = (CCVertex){{0.5, -0.5, 0.5},   {0, 1}};
    self.vertices[26] = (CCVertex){{0.5, 0.5, -0.5},   {1, 0}};
    self.vertices[27] = (CCVertex){{0.5, -0.5, 0.5},   {0, 1}};
    self.vertices[28] = (CCVertex){{0.5, 0.5, -0.5},   {1, 0}};
    self.vertices[29] = (CCVertex){{0.5, -0.5, -0.5},  {0, 0}};
    
    // 后面
    self.vertices[30] = (CCVertex){{-0.5, 0.5, -0.5},   {0, 1}};
    self.vertices[31] = (CCVertex){{-0.5, -0.5, -0.5},  {0, 0}};
    self.vertices[32] = (CCVertex){{0.5, 0.5, -0.5},    {1, 1}};
    self.vertices[33] = (CCVertex){{-0.5, -0.5, -0.5},  {0, 0}};
    self.vertices[34] = (CCVertex){{0.5, 0.5, -0.5},    {1, 1}};
    self.vertices[35] = (CCVertex){{0.5, -0.5, -0.5},   {1, 0}};
    
    //开辟缓存区 VBO 顶点缓冲对象(Vertex Buffer Objects)
    //生成一个VBO对象
    glGenBuffers(1, &_vertexBuffer);
    //设置顶点缓冲对象的缓冲类型是GL_ARRAY_BUFFER，将创建的VBO对象绑定到当前的执行程序上，也可以理解为激活
    glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer);
    GLsizeiptr bufferSizeBytes = sizeof(CCVertex) * kCoordCount;
    //将准备好的顶点数据复制到缓冲的内存中，vertices为顶点数据，GL_STATIC_DRAW表示数据不会改变和几乎不会改变。第三个参数一共有三个选择：GL_STATIC_DRAW 表示数据不会或几乎不会改变、GL_DYNAMIC_DRAW表示数据会被改变很多、GL_STREAM_DRAW 表示数据每次绘制时都会改变。
    glBufferData(GL_ARRAY_BUFFER, bufferSizeBytes, self.vertices, GL_STATIC_DRAW);
    
    //顶点数据
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(CCVertex), NULL + offsetof(CCVertex, positionCoord));
    
    //纹理数据
    glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
    glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, sizeof(CCVertex), NULL + offsetof(CCVertex, textureCoord));
    
}

#pragma mark - GLKViewDelegate
- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    
    //1.开启深度测试
    glEnable(GL_DEPTH_TEST);
    //2.清除颜色缓存区&深度缓存区
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    //3.准备绘制
    [self.baseEffect prepareToDraw];
    
    //4.绘图
    glDrawArrays(GL_TRIANGLES, 0, kCoordCount);
}

#pragma mark - update
- (void)update {
   
    //1.计算旋转度数
    self.angle = (self.angle + 5) % 360;
    //2.修改baseEffect.transform.modelviewMatrix
    self.baseEffect.transform.modelviewMatrix = GLKMatrix4MakeRotation(GLKMathDegreesToRadians(self.angle), 0.3, 1, -0.7);
    //3.重新渲染
    [self.glkView display];
}

@end
