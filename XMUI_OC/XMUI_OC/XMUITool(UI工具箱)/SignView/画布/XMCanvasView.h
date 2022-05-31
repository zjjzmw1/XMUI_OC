//
//  XMCanvasView.h
//  XMUI_OC
//
//  Created by ext.zhangmingwei1 on 2022/5/31.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 核心画布 view
@interface XMCanvasView : UIView

@property (nonatomic, strong) UIColor *lineColor;   //画笔颜色
@property (nonatomic, assign) CGFloat lineWidth;    //画笔宽度
@property (nonatomic, strong) UIImage *backgroundImage; //背景图片

/**
 获取签名图片
 
 @return 签名Image
 */
- (UIImage *)signatureImage;

/**
 撤销上一步绘制
 */
- (void)undoLastDraw;

/**
 恢复上次撤销操作
 */
- (void)redoLastDraw;

/**
 清除所有操作
 */
- (void)clearSignature;

/**
 保存签名
 */
- (void)saveSignature;

@end

NS_ASSUME_NONNULL_END
