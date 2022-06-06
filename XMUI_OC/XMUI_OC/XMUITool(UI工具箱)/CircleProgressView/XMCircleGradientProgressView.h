//
//  XMCircleGradientProgressView.h
//  XMUI_OC
//
//  Created by ext.zhangmingwei1 on 2022/6/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 圆环渐变进度条
@interface XMCircleGradientProgressView : UIView

/// 刷新进度 「0 -- 1」
@property (nonatomic, assign) CGFloat           progress;
/// 动画更新进度 - 0 不展示动画
@property (nonatomic, assign) CFTimeInterval    animationDuration;

/// 更新起始点 --- 默认是：「从6点方向顺时针转一圈」
/// @param startAngle 起点：默认是：M_PI/2
/// @param endAngle 终点：默认是：M_PI/2 + M_PI*2
/// @parm clockwise  YES：顺时针
- (void)updateStartAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle clockwise:(BOOL)clockwise;

@end

NS_ASSUME_NONNULL_END
