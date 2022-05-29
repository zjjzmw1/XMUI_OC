//
//  UITextField+XMTool.h
//  艺库
//
//  Created by zhangmingwei on 2019/7/10.
//  Copyright © 2019 YiKuNetwork. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (XMTool)

/// 默认文字的颜色
@property (nonatomic, strong) UIColor *placeholderColor;

/// 便利方法获取 UITextField
/// @param leftSpace 左边间隙
/// @param placeholderColor placeholder颜色
/// @param textColor textColor  文字颜色
+ (UITextField *)getInstancWithLeftSpace:(CGFloat)leftSpace placeholderColor:(UIColor *)placeholderColor textColor:(UIColor *)textColor;

@end

NS_ASSUME_NONNULL_END
