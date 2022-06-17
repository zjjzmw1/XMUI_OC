//
//  XMNoDataEmptyView.h
//  XMUI_OC
//
//  Created by zhangmingwei on 2022/6/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 空页面 - 「上面图片、中间文字、下面刷新按钮」
@interface XMNoDataEmptyView : UIView

/// 距离顶部的空隙 -- 默认是： 215
@property (nonatomic, assign) CGFloat       topSpace;

/// 空图片
@property (nonatomic, strong) UIImageView   *emptyImageView;
/// 空文案提示
@property (nonatomic, strong) UILabel       *emptyTipLabel;
/// 空重试按钮
@property (nonatomic, strong) UIButton      *emptyRefreshButton;

/// 点击刷新回调
@property (nonatomic, copy) void (^clickBlock)(void);


/// 刷新空页面数据
/// @param tipStr 提示文案
/// @param emptyImage 空图片，没有就传nil
- (void)showWithTipString:(NSString *)tipStr emptyImage:(nullable UIImage *)emptyImage;

/// 隐藏
- (void)hiddenAction;

@end

NS_ASSUME_NONNULL_END
