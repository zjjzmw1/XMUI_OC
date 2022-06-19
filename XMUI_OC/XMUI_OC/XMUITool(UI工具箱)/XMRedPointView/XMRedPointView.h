//
//  XMRedPointView.h
//  XMUI_OC
//
//  Created by zhangmingwei on 2022/6/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/*
 
 用法例子：
 // frame 为距离父视图的相对位置，宽高会自适应，传 0 就行
 self.redPointV = [[XMRedPointView alloc] initWithFrame:CGRectMake(12, -5, 0, 0)];
 [self.iconView addSubview:self.redPointV];
 [self.redPointV reloadWithCount:2];
 
 */

/// 一个直角、三个圆角的 带数量的小红点气泡
@interface XMRedPointView : UIView

/// 刷新小红点数量
/// @param pointCount  【0：隐藏 】 【大于 99显示 99+】
- (void)reloadWithCount:(NSInteger)pointCount;

/// 刷新小红点数量 -- 大的红点气泡样式
/// @param pointCount  【0：隐藏 】 【大于 99显示 99+】
- (void)reloadBigRedPointWithCount:(NSInteger)pointCount;

@end

NS_ASSUME_NONNULL_END
