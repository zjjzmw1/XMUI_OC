//
//  UILabel+XMTool.h
//  艺库
//
//  Created by zhangmingwei on 2019/7/11.
//  Copyright © 2019 YiKuNetwork. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (XMTool)

/**
 修改label内容距 `top` `left` `bottom` `right` 边距
 */
@property (nonatomic, assign) UIEdgeInsets xm_contentInsets;

/**
*  获取常用的UILabel
*
*  @param font      UIFont
*  @param textColor UIColor
*
*  @return UILabel
*/
+ (UILabel *)getLabelWithFont:(UIFont *)font textColor:(UIColor *)textColor;

/// 设置多行的行间距
-(void)setText:(NSString*)text lineSpacing:(CGFloat)lineSpacing;

@end

NS_ASSUME_NONNULL_END
