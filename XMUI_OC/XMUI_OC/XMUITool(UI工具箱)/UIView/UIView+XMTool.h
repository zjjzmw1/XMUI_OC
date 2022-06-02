//
//  UIView+XMTool.h
//  艺库
//
//  Created by zhangmingwei on 2019/7/11.
//  Copyright © 2019 YiKuNetwork. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (XMTool)

- (UIViewController *)viewController;

- (void)setTapActionWithBlock:(void (^)(void))block;
- (void)setLongPressActionWithBlock:(void (^)(void))block;

/**
 *  添加UIView的四个角的任意角的圆角 需要对设置圆角的view添加frame，否则不行
 *
 *  @param angle    圆角的大小
 *  @param corners  设置哪个角为圆角
 */
- (void)addRectCorner:(float)angle corners:(UIRectCorner)corners;

/**
 *  给View添加黑色阴影和圆角 - 四个边都有阴影  Tip~!!!!! 这种添加阴影的话，不能用高性能的圆角了。
 *
 *  @param shadowColor      阴影颜色
 *  @param corner           view的圆角
 */
- (void)addShadowWithColor:(UIColor *)shadowColor corner:(float)corner;

/// 创建一条横线 : 横线的frame，和颜色
+ (UIView *)getLineViewWithFrame:(CGRect)frame color:(UIColor *)color;

/*
 如果更改了一个图层的AnchorPoint，那么这个图层会发送位移。原因不表，看看文档便知。问题是发生位移之后，我们怎么将位移修复回来
 */
/// 设置某个视图的锚点 ------ （动画执行完，别忘了把锚点改为默认值 (0.5，0.5)）
- (void)setAnchorPoint:(CGPoint)anchorPoint;

/// 获取渐变的layer
/// @param colorArr 渐变的颜色数组
/// @param startP 渐变色的开始位置比如：CGPointMake(0.5, 0.0)
/// @param endP 渐变色的结束位置比如：CGPointMake(0.5, 1.0)
/// @param layerSize 渐变色的大小

+ (CAGradientLayer *)getGradientLayerWithColorArray:(NSArray *)colorArr startPoint:(CGPoint)startP endPoint:(CGPoint)endP size:(CGSize)layerSize;

@end

NS_ASSUME_NONNULL_END
