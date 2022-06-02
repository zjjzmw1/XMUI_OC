//
//  XMProgressBarView.h
//  XMUI_OC
//
//  Created by ext.zhangmingwei1 on 2022/6/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 进度条 + 百分比文字
@interface XMProgressBarView : UIView

/// 刷新进度条进度
/// @param progress  「0 -- 1」 CGFloat类型
- (void)reloadDataWithProgress:(CGFloat)progress;

@end

NS_ASSUME_NONNULL_END
