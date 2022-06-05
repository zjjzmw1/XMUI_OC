//
//  UILabel+GradientLayer.m
//  XMUI_OC
//
//  Created by ext.zhangmingwei1 on 2022/6/6.
//

#import "UILabel+GradientLayer.h"

@implementation UILabel (GradientLayer)

/// 添加渐变色文字 - 设置文字后再调用
- (void)addGradientTextAction {
    if (self.superview == nil) {
        return;
    }
    self.backgroundColor = [UIColor clearColor];
    [self.superview layoutIfNeeded];
    [self sizeToFit];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    [self.superview.layer addSublayer:gradientLayer];
    gradientLayer.frame = self.frame;
    [gradientLayer setColors:[NSArray arrayWithObjects:(id)[UIColor yellowColor].CGColor,(id)[UIColor redColor].CGColor, nil]];
    // 渐变色方向
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);
    gradientLayer.mask = self.layer;
    self.frame = gradientLayer.bounds;
    // 如果需要闪烁的渐变色。需要：利用定时器，快速的切换渐变颜色，就有文字颜色变化效果
}
/*
 
 cadisplaylink *link = [cadisplaylink displaylinkwithtarget:self selector:@selector(textcolorchange)];

 [link addtorunloop:[nsrunloop mainrunloop] formode:nsdefaultrunloopmode];  // 随机颜色方法
 -(uicolor *)randomcolor{        cgfloat r = arc4random_uniform(256) / 255.0;        cgfloat g = arc4random_uniform(256) / 255.0;        cgfloat b = arc4random_uniform(256) / 255.0;        return [uicolor colorwithred:r green:g blue:b alpha:1];
 }  // 定时器触发方法
 -(void)textcolorchange {
    _gradientlayer.colors = @[(id)[self randomcolor].cgcolor,
                 (id)[self randomcolor].cgcolor,
                 (id)[self randomcolor].cgcolor,
                 (id)[self randomcolor].cgcolor,
               (id)[self randomcolor].cgcolor];
 }
 
 */

@end
