//
//  UIView+XMTool.m
//  艺库
//
//  Created by zhangmingwei on 2019/7/11.
//  Copyright © 2019 YiKuNetwork. All rights reserved.
//

#import "UIView+XMTool.h"
#import <objc/runtime.h>

static char kDTActionHandlerTapBlockKey;
static char kDTActionHandlerTapGestureKey;
static char kDTActionHandlerLongPressBlockKey;
static char kDTActionHandlerLongPressGestureKey;

@implementation UIView (XMTool)

- (UIViewController *)viewController
{
    UIResponder *next = self.nextResponder;
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        
        next = next.nextResponder;
    } while (next != nil);
    
    return nil;
}


- (void)setTapActionWithBlock:(void (^)(void))block {
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *gesture = objc_getAssociatedObject(self, &kDTActionHandlerTapGestureKey);
    
    if (!gesture) {
        gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(__handleActionForTapGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &kDTActionHandlerTapGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    
    objc_setAssociatedObject(self, &kDTActionHandlerTapBlockKey, block, OBJC_ASSOCIATION_COPY);
}

- (void)__handleActionForTapGesture:(UITapGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateRecognized) {
        void (^ action)(void) = objc_getAssociatedObject(self, &kDTActionHandlerTapBlockKey);
        
        if (action) {
            action();
        }
    }
}

- (void)setLongPressActionWithBlock:(void (^)(void))block {
    UILongPressGestureRecognizer *gesture = objc_getAssociatedObject(self, &kDTActionHandlerLongPressGestureKey);
    
    if (!gesture) {
        gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(__handleActionForLongPressGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &kDTActionHandlerLongPressGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    
    objc_setAssociatedObject(self, &kDTActionHandlerLongPressBlockKey, block, OBJC_ASSOCIATION_COPY);
}

- (void)__handleActionForLongPressGesture:(UITapGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateBegan) {
        void (^ action)(void) = objc_getAssociatedObject(self, &kDTActionHandlerLongPressBlockKey);
        
        if (action) {
            action();
        }
    }
}


- (void)layoutSubviews {
    //    self.layer.frame = self.bounds;
}

/**
 *  添加UIView的四个角的任意角的圆角 需要对设置圆角的view添加frame，否则不行
 *
 *  @param angle    圆角的大小
 *  @param corners  设置哪个角为圆角
 */
- (void)addRectCorner:(float)angle corners:(UIRectCorner)corners {
    // 设置圆角，需要view有frame
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(angle, angle)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

/**
 *  给View添加黑色阴影和圆角 - 四个边都有阴影  Tip~!!!!! 这种添加阴影的话，不能用高性能的圆角了。
 *
 *  @param shadowColor      阴影颜色
 *  @param corner           view的圆角
 */
- (void)addShadowWithColor:(UIColor *)shadowColor corner:(float)corner {
    if (corner > 0) { // 避免view的其他地方有圆角，这里传入0，把圆角弄没了。
        self.layer.cornerRadius = corner;
    }
    self.layer.masksToBounds = YES;             // 和下面一句的顺序不能错
    self.clipsToBounds = NO;
    self.layer.shadowOffset = CGSizeMake(0, 1); // 阴影的偏移 （扩散大于偏移就能达到四个边都有阴影）
    self.layer.shadowRadius = 1;                // 阴影的扩散程度
    self.layer.shadowColor = shadowColor.CGColor;
    self.layer.shadowOpacity = 0.7;           // 阴影的透明度
}

/// 创建一条横线 : 横线的frame，和颜色
+ (UIView *)getLineViewWithFrame:(CGRect)frame color:(UIColor *)color {
    UIView *line = [[UIView alloc] initWithFrame:frame];
    line.backgroundColor = color;
    return line;
}

/*
 如果更改了一个图层的AnchorPoint，那么这个图层会发送位移。原因不表，看看文档便知。问题是发生位移之后，我们怎么将位移修复回来
 */
/// 设置某个视图的锚点 ------ （动画执行完，别忘了把锚点改为默认值 (0.5，0.5)）
- (void)setAnchorPoint:(CGPoint)anchorPoint {
    CGPoint oldOrigin = self.frame.origin;
    self.layer.anchorPoint = anchorPoint;
    CGPoint newOrigin = self.frame.origin;
    CGPoint transition;
    transition.x = newOrigin.x - oldOrigin.x;
    transition.y = newOrigin.y - oldOrigin.y;
    self.center = CGPointMake(self.center.x - transition.x, self.center.y - transition.y);
}

/// 获取渐变的layer
/// @param colorArr 渐变的颜色数组
/// @param startP 渐变色的开始位置比如：CGPointMake(0.5, 0.0)
/// @param endP 渐变色的结束位置比如：CGPointMake(0.5, 1.0)
/// @param layerSize 渐变色的大小

+ (CAGradientLayer *)getGradientLayerWithColorArray:(NSArray *)colorArr startPoint:(CGPoint)startP endPoint:(CGPoint)endP size:(CGSize)layerSize {
    CAGradientLayer *gradentLayer = [CAGradientLayer layer];
    gradentLayer.frame = CGRectMake(0, 0, layerSize.width, layerSize.height);
    gradentLayer.startPoint = startP;
    gradentLayer.endPoint = endP;
    NSMutableArray *lastArr = [NSMutableArray array];
    for (int i = 0; i < colorArr.count; i++) {
        UIColor *color = colorArr[i];
        [lastArr addObject:(__bridge id)color.CGColor];
    }
    gradentLayer.colors = lastArr;
    gradentLayer.locations = @[@(0), @(1.0f)];
    return gradentLayer;
}


@end
