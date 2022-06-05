//
//  UILabel+GradientLayer.h
//  XMUI_OC
//
//  Created by ext.zhangmingwei1 on 2022/6/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 添加渐变色文字的功能
@interface UILabel (GradientLayer)

/// 添加渐变色文字 - 设置文字后再调用
- (void)addGradientTextAction;

@end

NS_ASSUME_NONNULL_END
