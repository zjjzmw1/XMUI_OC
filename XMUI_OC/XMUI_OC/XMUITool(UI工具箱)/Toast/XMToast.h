//
//  XMToast.h
//  XMUI_OC
//
//  Created by ext.zhangmingwei1 on 2022/5/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    XMToastPositionTypeCenter,
    XMToastPositionTypeBottom
} XMToastPositionType;

@interface XMToast : UIView

/// 弹出存文字 toast 「默认1.5s后消失，文字长的话，会适当延迟消失时间」
+ (void)showText:(NSString *)text positionType:(XMToastPositionType)positionType;

@end

NS_ASSUME_NONNULL_END
