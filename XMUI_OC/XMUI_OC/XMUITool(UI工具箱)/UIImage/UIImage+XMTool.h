//
//  UIImage+XMTool.h
//  艺库
//
//  Created by zhangmingwei on 2019/7/11.
//  Copyright © 2019 YiKuNetwork. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (XMTool)

typedef enum  {
    GradientType_TopToBottom = 0,         // 从上到小
    GradientType_LeftToRight = 1,         // 从左到右
    GradientType_TopLeftToBottomRight = 2,    // 左上到右下
    GradientType_TopRightToBottomLeft = 3,    // 右上到左下
} GradientType;


/// 根据色值 获取渐变 UIImage
/// @param colors  颜色数组
/// @param gradientType 渐变的方向
/// @param size 大小
+ (UIImage *)getImageFromColors:(NSArray *)colors ByGradientType:(GradientType)gradientType size:(CGSize)size;

+ (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize;

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

/// 获取图片的主色调
-(UIColor*)mostColor;

///  获取启动闪屏图
+ (UIImage *)getTheLaunchImage;

/// 获得某个范围内的屏幕图像 -- 原图需要考虑scale
+ (UIImage *)imageFromView:(UIView *)view atFrame:(CGRect)rect;

/// 从图片正中心拉伸图片获取新图 -- 四周不被拉伸
+ (UIImage *)getNewImageFromCenterWithOriginImage:(UIImage *)originImage;

@end

NS_ASSUME_NONNULL_END
