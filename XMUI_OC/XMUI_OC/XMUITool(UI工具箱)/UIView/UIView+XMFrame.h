//
//  UIView+XMFrame.h
//  XMUI_OC
//
//  Created by ext.zhangmingwei1 on 2022/5/31.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (XMFrame)

@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize  size;
@property (nonatomic, assign) CGFloat top;
/// 便利获取  frame.origin.x
@property (nonatomic, assign) CGFloat left;
/// 便利获取  frame.origin.y + frame.size.height
@property (nonatomic, assign) CGFloat bottom;
/// 便利获取  frame.origin.x + frame.size.width
@property (nonatomic, assign) CGFloat right;
/// 便利获取  frame.size.width
@property (nonatomic, assign) CGFloat width;
/// 便利获取  frame.size.height
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

@property (nonatomic, assign) CGSize boundsSize;
@property (nonatomic, assign) CGFloat boundsWidth;
@property (nonatomic, assign) CGFloat boundsHeight;

@property (nonatomic, readonly) CGRect contentBounds;
@property (nonatomic, readonly) CGPoint contentCenter;

@end

NS_ASSUME_NONNULL_END
