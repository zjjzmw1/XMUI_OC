//
//  XMImageLabelView.h
//  XMUI_OC
//
//  Created by ext.zhangmingwei1 on 2022/6/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum {
    XMImageLabelType_ImageTop   =   0,  // 图片上、文字下
    XMImageLabelType_LabelTop   =   1,  // 文字上、图片下
}XMImageLabelType;

/*
 共两步：「titleLbl有默认字体样式，想更改的话，可以在这两步之间更改字体」
 第一步：alloc initWithFrame  「高度越高，图片和文字的间隙越大」
 第二步：reloadDataWithTitle
 */
/// 上面图标、下面文字的  view
@interface XMImageLabelView : UIView

/// 图标
@property (nonatomic, strong) UIImageView   *iconImgV;
/// 文字
@property (nonatomic, strong) UILabel       *titleLbl;

/// 点击整个view的回调
@property (nonatomic, copy) void (^clickBlock) (void);

/// 刷新数据
/// @param image 图标
/// @param text 文字
- (void)reloadDataWithImage:(UIImage *)image textString:(NSString *)text type:(XMImageLabelType)type;

@end

NS_ASSUME_NONNULL_END
