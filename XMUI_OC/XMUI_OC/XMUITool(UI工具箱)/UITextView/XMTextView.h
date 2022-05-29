//
//  XMTextView.h
//  XMUI_OC
//
//  Created by ext.zhangmingwei1 on 2022/5/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

// contentInset 自带内边距。「修复placeholder和光标不对齐的bug」
@interface XMTextView : UITextView

/// 类似UITextField的默认的文字。
@property (nonatomic, strong) NSString  *placeholder;
/// 默认文字的颜色
@property (nonatomic, strong) UIColor   *placeholderColor;
/// 默认文字 font
@property (nonatomic, strong) UIFont    *placeholerFont;

@end

NS_ASSUME_NONNULL_END
