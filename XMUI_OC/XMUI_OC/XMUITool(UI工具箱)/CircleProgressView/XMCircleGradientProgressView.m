//
//  XMCircleGradientProgressView.m
//  XMUI_OC
//
//  Created by ext.zhangmingwei1 on 2022/6/5.
//

#import "XMCircleGradientProgressView.h"

@interface XMCircleGradientProgressView()

/// 背景的 layer
@property (nonatomic, strong) CAShapeLayer *backLayer;
/// 进度的 layer -- 前半部分
@property (nonatomic, strong) CAShapeLayer *progressLayer1;
/// 进度的 layer -- 前后半部分
@property (nonatomic, strong) CAShapeLayer *progressLayer2;
/// 渐变色 layer - 「前半边」
@property (nonatomic, strong) CAGradientLayer *gradientLayer1;
/// 渐变色 layer - 「后半边」
@property (nonatomic, strong) CAGradientLayer *gradientLayer2;

/// 起点
@property (nonatomic, assign) CGFloat       currentStartAngle;
/// 终点
@property (nonatomic, assign) CGFloat       currentEndAngle;
/// 是否是顺时针
@property (nonatomic, assign) BOOL          currentClockwise;
/// 线的宽度
@property (nonatomic, assign) CGFloat       lineWidth;

@end

@implementation XMCircleGradientProgressView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    self.currentStartAngle = M_PI/2;
    self.currentEndAngle = M_PI/2 + M_PI*2;
    self.currentClockwise = YES;
    self.lineWidth = 5.0;
        
    [self.layer addSublayer:self.backLayer];
    [self.layer addSublayer:self.progressLayer];
    [self.layer addSublayer:self.progressLayer2];
    [self.layer addSublayer:self.gradientLayer1];
    [self.layer addSublayer:self.gradientLayer2];
    
    [self updatePath];
    
    return self;
}

/// 更新 layer 路径
- (void)updatePath {
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    CGFloat offset = (self.currentEndAngle - self.currentStartAngle)/2.0;
    // 半径减去线的宽度
    // 总路径 - 背景用
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(width * 0.5, height * 0.5) radius:width * 0.5 - self.lineWidth/2.0 startAngle:self.currentStartAngle endAngle:self.currentEndAngle clockwise:self.currentClockwise];
    // 前半部分
    UIBezierPath *path1 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(width * 0.5, height * 0.5) radius:width * 0.5 - self.lineWidth/2.0 startAngle:self.currentStartAngle endAngle:self.currentEndAngle - offset clockwise:self.currentClockwise];
    // 后半部分
//    UIBezierPath *path2 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(width * 0.5, height * 0.5) radius:width * 0.5 - self.lineWidth/2.0 startAngle:self.currentStartAngle + offset endAngle:self.currentEndAngle clockwise:self.currentClockwise];
    UIBezierPath *path2 = [UIBezierPath bezierPath];
    [path2 addArcWithCenter:CGPointMake(width * 0.5, height * 0.5) radius:width * 0.5 - self.lineWidth/2.0 startAngle:self.currentStartAngle + offset endAngle:self.currentEndAngle clockwise:self.currentClockwise];

    self.backLayer.path = path.CGPath;
    
    self.progressLayer1.path = path1.CGPath;
    self.progressLayer2.path = path2.CGPath;
    // 渐变颜色
    self.gradientLayer1.mask = self.progressLayer1;
    self.gradientLayer2.mask = self.progressLayer2;
    
    if (self.animationDuration > 0) {
        [self showAnimationWithDuration:self.animationDuration];
    }
}

/// 更新起始点 --- 默认是：「从6点方向顺时针转一圈」
/// @param startAngle 起点：默认是：M_PI/2
/// @param endAngle 终点：默认是：M_PI/2 + M_PI*2
/// @parm clockwise  YES：顺时针
- (void)updateStartAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle clockwise:(BOOL)clockwise {
    self.currentStartAngle = startAngle;
    self.currentEndAngle = endAngle;
    self.currentClockwise = clockwise;
    [self updatePath];
}

/// 刷新进度
- (void)setProgress:(CGFloat)progress {
    CGFloat progress1 = progress * 2.0; // 前半部分进度
    CGFloat progress2 = progress - 0.5; // 后半部分进度
    if (progress1 < 0) {
        progress1 = 0;
    } else if (progress1 > 1) {
        progress1 = 1;
    }
    if (progress2 < 0) {
        progress2 = 0;
    }
    if (progress2 > 1) {
        progress2 = 1;
    }
    self.progressLayer.strokeEnd = progress1;
    self.progressLayer2.strokeEnd = progress2/0.5;
    // 更新进度
    [self updatePath];
}

/// 设置 layer的宽度、颜色、类型
- (void)updateLayerProperty:(CAShapeLayer *)layer withColor:(UIColor *)color {
    layer.lineWidth = self.lineWidth;
    layer.lineCap = kCALineCapRound;
    layer.strokeColor = color.CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
}

- (void)showAnimationWithDuration:(CFTimeInterval)duraton {
    // 线条 动画效果
    // 上半部分动画
    CABasicAnimation *pathAnima = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnima.duration = duraton/2.0; // 动画时间
    pathAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    pathAnima.fromValue = [NSNumber numberWithFloat:0.0f]; // 开始点
    pathAnima.toValue = [NSNumber numberWithFloat:self.progressLayer1.strokeEnd]; // 结束点
    pathAnima.fillMode = kCAFillModeForwards;
    pathAnima.removedOnCompletion = NO;
    [self.progressLayer1 addAnimation:pathAnima forKey:@"strokeEnd"];
    // 下半部分动画
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = duraton;
    CABasicAnimation *pathAnima2 = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnima2.duration = duraton/2.0; // 动画时间
    pathAnima2.fromValue = [NSNumber numberWithFloat:0.0f]; // 开始点
    pathAnima2.toValue = [NSNumber numberWithFloat:0.0f]; // 结束点
    CABasicAnimation *pathAnima3 = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnima3.duration = duraton/2.0; // 动画时间
    pathAnima3.beginTime = duraton/2.0;
    pathAnima3.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    pathAnima3.fromValue = [NSNumber numberWithFloat:0.0f]; // 开始点
    pathAnima3.toValue = [NSNumber numberWithFloat:self.progressLayer2.strokeEnd]; // 结束点
    pathAnima3.fillMode = kCAFillModeForwards;
    pathAnima3.removedOnCompletion = NO;
    group.animations = @[pathAnima2, pathAnima3];
    [self.progressLayer2 addAnimation:group forKey:@"strokeEnd"];
    
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
    if (!_progressLayer1) {
        CAShapeLayer *progressLayer1 = [CAShapeLayer layer];
        progressLayer1.fillColor = [UIColor clearColor].CGColor;
        [self updateLayerProperty:progressLayer1 withColor:[UIColor redColor]]; // 进度颜色
        _progressLayer1 = progressLayer1;
    }
    return _progressLayer1;
}

- (CAShapeLayer *)progressLayer2 {
    if (!_progressLayer2) {
        CAShapeLayer *progressLayer2 = [CAShapeLayer layer];
        progressLayer2.fillColor = [UIColor clearColor].CGColor;
        [self updateLayerProperty:progressLayer2 withColor:[UIColor redColor]]; // 进度颜色
        _progressLayer2 = progressLayer2;
    }
    return _progressLayer2;
}

- (CAGradientLayer *)gradientLayer1 {
    if (!_gradientLayer1) {
        _gradientLayer1 =  [CAGradientLayer layer];
        _gradientLayer1.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
        [_gradientLayer1 setColors:[NSArray arrayWithObjects:(id)[UIColor yellowColor].CGColor,(id)[UIColor colorWithRed:230/255.0 green:70/255.0 blue:30/255.0 alpha:1.0].CGColor,(id)[UIColor redColor].CGColor, nil]];
    }
    return _gradientLayer1;
}

- (CAGradientLayer *)gradientLayer2 {
    if (!_gradientLayer2) {
        _gradientLayer2 =  [CAGradientLayer layer];
        _gradientLayer2.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
        [_gradientLayer2 setColors:[NSArray arrayWithObjects:(id)[UIColor yellowColor].CGColor,(id)[UIColor colorWithRed:30/255.0 green:70/255.0 blue:230/255.0 alpha:1.0].CGColor,(id)[UIColor blueColor].CGColor, nil]];
    }
    return _gradientLayer2;
}

@end
