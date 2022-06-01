//
//  XMSignView.h
//  XMUI_OC
//
//  Created by ext.zhangmingwei1 on 2022/5/31.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 签名view
@interface XMSignView : UIView

/// 是否正在显示
@property (nonatomic, assign) BOOL  isShowing;

/// 签名完成的图片回调
@property (nonatomic, strong) void (^finishImageDataBlock)(XMSignView *, UIImage *image);

/// 展示横屏签名view
- (void)showAction;

@end

NS_ASSUME_NONNULL_END
