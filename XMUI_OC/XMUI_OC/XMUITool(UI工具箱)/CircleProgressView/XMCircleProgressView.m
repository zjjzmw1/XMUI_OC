//
//  XMCircleProgressView.m
//  XMUI_OC
//
//  Created by ext.zhangmingwei1 on 2022/6/5.
//

#import "XMCircleProgressView.h"

@interface XMCircleProgressView()

/// 背景的 layer
@property (nonatomic, strong) CAShapeLayer *backLayer;
/// 进度的 layer
@property (nonatomic, strong) CAShapeLayer *progressLayer;

/// 起点
@property (nonatomic, assign) CGFloat       currentStartAngle;
/// 终点
@property (nonatomic, assign) CGFloat       currentEndAngle;
/// 是否是顺时针
@property (nonatomic, assign) BOOL          currentClockwise;

@end

@implementation XMCircleProgressView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    self.currentStartAngle = M_PI;
    self.currentEndAngle = M_PI + M_PI*2;
    self.currentClockwise = YES;
    
    [self updatePath];
    
    return self;
}

/// 更新 layer 路径
- (void)updatePath {
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(width * 0.5, height * 0.5) radius:width * 0.5 startAngle:self.currentStartAngle endAngle:self.currentEndAngle clockwise:self.currentClockwise];
    self.backLayer.path = path.CGPath;
    self.progressLayer.path = path.CGPath;
}

/// 更新起始点 --- 默认是：「从9点方向顺时针转一圈」
/// @param startAngle 起点：默认是：M_PI
/// @param endAngle 终点：默认是：M_PI + M_PI*2
/// @parm clockwise  YES：顺时针
- (void)updateStartAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle clockwise:(BOOL)clockwise {
    self.currentStartAngle = startAngle;
    self.currentEndAngle = endAngle;
    self.currentClockwise = clockwise;
    [self updatePath];
}

/// 刷新进度
- (void)setProgress:(CGFloat)progress {
    if (progress <= 0) {
        _progress = 0;
    } else if (progress >= 1) {
        _progress = 1;
    } else {
        _progress = progress;
    }
    self.progressLayer.strokeEnd = _progress;
    // 更新进度
    [self updatePath];
}

/// 设置 layer的宽度、颜色、类型
- (void)updateLayerProperty:(CAShapeLayer *)layer withColor:(UIColor *)color {
    layer.lineWidth = 5;
    layer.lineCap = kCALineCapRound;
    layer.strokeColor = color.CGColor;
}

#pragma mark - 懒加载
- (CAShapeLayer *)backLayer {
    if (!_backLayer) {
        CAShapeLayer *backLayer = [CAShapeLayer layer];
        backLayer.fillColor = [UIColor clearColor].CGColor;
        [self updateLayerProperty:backLayer withColor:[UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0]]; // 背景颜色
        [self.layer insertSublayer:backLayer atIndex:0];
        _backLayer = backLayer;
    }
    return _backLayer;
}

- (CAShapeLayer *)progressLayer {
    if (!_progressLayer) {
        CAShapeLayer *progressLayer = [CAShapeLayer layer];
        progressLayer.fillColor = [UIColor clearColor].CGColor;
        [self updateLayerProperty:progressLayer withColor:[UIColor redColor]]; // 进度颜色
        [self.layer addSublayer:progressLayer];
        _progressLayer = progressLayer;
    }
    return _progressLayer;
}

@end
