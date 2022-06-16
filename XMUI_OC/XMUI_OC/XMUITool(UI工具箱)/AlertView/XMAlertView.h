//
//  XMAlertView.h
//  XMUI_OC
//
//  Created by ext.zhangmingwei1 on 2022/5/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 自定义AlertView
@interface XMAlertView : UIView

/// 确定按钮点击
@property (nonatomic, copy) void (^clickSubmitBlock) (void);
/// 取消按钮点击
@property (nonatomic, copy) void (^clickCancelBlock) (void);


/// 自定义弹框 初始化
/// @param titleStr 标题，没有就传 nil
/// @param contentStr 内容文字（支持长文滚动），没有就传 nil
/// @param cancelStr 左边按钮，没有就传 nil
/// @param submitStr 右边按钮，没有传 nil
+ (XMAlertView *)initWithTitle:(nullable NSString *)titleStr contentStr:(nullable NSString *)contentStr cancelStr:(nullable NSString *)cancelStr submitStr:(nullable NSString *)submitStr;

/// 弹出方法
- (void)showAction;

@end

NS_ASSUME_NONNULL_END
