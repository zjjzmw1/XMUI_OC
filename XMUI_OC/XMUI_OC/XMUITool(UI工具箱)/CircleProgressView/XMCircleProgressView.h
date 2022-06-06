//
//  XMCircleProgressView.h
//  XMUI_OC
//
//  Created by ext.zhangmingwei1 on 2022/6/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/*
 clockwise: YES是顺时针
 0弧度：最右侧的位置
 top    : 1.5PI
 left   : 1PI
 bottom : 0.5PI
 right  : 0PI
 */

/// 圆形进度 view
@interface XMCircleProgressView : UIView

/// 刷新进度 「0 -- 1」
@property (nonatomic, assign) CGFloat progress;
/// 动画更新进度 - 0 不展示动画
@property (nonatomic, assign) CFTimeInterval    animationDuration;

/// 更新起始点 --- 默认是：「从9点方向顺时针转一圈」
/// @param startAngle 起点：默认是：M_PI
/// @param endAngle 终点：默认是：M_PI + M_PI*2
/// @parm clockwise  YES：顺时针
- (void)updateStartAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle clockwise:(BOOL)clockwise;

@end

NS_ASSUME_NONNULL_END
