//
//  XMCustomNaviView.h
//  XMUI_OC
//
//  Created by ext.zhangmingwei1 on 2022/5/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 自定义的导航栏 View
@interface XMCustomNaviView : UIView

/// 返回按钮点击事件
@property (nonatomic, copy) void (^backBlock)(void);
/// 右边按钮点击事件
@property (nonatomic, copy) void (^rightBlock)(void);

/// 返回按钮
@property (nonatomic, strong) UIButton      *backBtn;
/// 标题
@property (nonatomic, strong) UILabel       *titleLbl;
/// 右边按钮
@property (nonatomic, strong) UIButton      *rightBtn;
/// 底部横线 默认隐藏
@property (nonatomic, strong) UIImageView   *lineImgV;

/**
 获取自定义导航栏
 */
+ (instancetype)getInstanceWithTitle:(nullable NSString *)titleStr;

/// 设置标题
- (void)setTitleStr:(nullable NSString *)titleStr;
/// 设置返回按钮的  图片和标题
- (void)setBackBtnImage:(nullable UIImage *)img title:(nullable NSString *)titleStr;
/// 设置右边按钮的  图片和标题
- (void)setRightBtnImage:(nullable UIImage *)img title:(nullable NSString *)titleStr;
/// 是否展示底部横线
- (void)showBottomLine:(BOOL)isShow;

@end

NS_ASSUME_NONNULL_END
