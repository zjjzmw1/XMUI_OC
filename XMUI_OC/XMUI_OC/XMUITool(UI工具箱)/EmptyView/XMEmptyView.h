//
//  XMEmptyView.h
//  XMUI_OC
//
//  Created by ext.zhangmingwei1 on 2022/5/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMEmptyView : UIView

/// 上面一行的提示文字 - 例如：“数据加载失败”
@property (nonatomic, strong) UILabel       *tipLbl;
/// 下面一行的点击重试的文字 - 例如："点击重试"
@property (nonatomic, strong) UILabel       *retryLbl;


/// 点击回调
@property (nonatomic, copy) void (^cliccBlock)(void);


/// 刷新显示空页面的内容
/// @param tipStr 提示文字
/// @param retryStr  重试的文字
- (void)reloadWithTipStr:(NSString *)tipStr retryStr:(NSString *)retryStr;

@end

NS_ASSUME_NONNULL_END
