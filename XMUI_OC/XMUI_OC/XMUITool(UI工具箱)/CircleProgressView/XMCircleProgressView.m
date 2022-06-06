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
    
    if (self.animationDuration > 0) {
        [self showAnimationWithDuration:self.animationDuration];
    }
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

- (void)showAnimationWithDuration:(CFTimeInterval)duraton {
    // 线条 动画效果
    // 上半部分动画
    CABasicAnimation *pathAnima = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnima.duration = duraton/2.0; // 动画时间
    pathAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    pathAnima.fromValue = [NSNumber numberWithFloat:0.0f]; // 开始点
    pathAnima.toValue = [NSNumber numberWithFloat:self.progressLayer.strokeEnd]; // 结束点
    pathAnima.fillMode = kCAFillModeForwards;
    pathAnima.removedOnCompletion = NO;
    [self.progressLayer addAnimation:pathAnima forKey:@"strokeEnd"];
    
    /*
     // 如果一个小图标走特定的贝塞尔曲线的话，用 keyframe
     CAKeyframeAnimation* keyFrameAni = [CAKeyframeAnimation animationWithKeyPath:@"position"];
     keyFrameAni.repeatCount = 1;
     keyFrameAni.path = sunPath.CGPath;
     keyFrameAni.duration = 3;
     keyFrameAni.beginTime = CACurrentMediaTime(); // 开始时间：当期那时间秒（绝对值）
     keyFrameAni.fillMode = kCAFillModeForwards;
     keyFrameAni.removedOnCompletion = NO;
     [self.iconImgV.layer addAnimation:keyFrameAni forKey:@"keyFrameAnimation"];
     */
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
