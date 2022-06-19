//
//  XMRedPointView.m
//  XMUI_OC
//
//  Created by zhangmingwei on 2022/6/16.
//

#import "XMRedPointView.h"

@interface XMRedPointView()

/// 小红点 label
@property (nonatomic, strong) UILabel   *redPointLbl;

@end

@implementation XMRedPointView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor whiteColor];
    self.layer.borderWidth = 2.0;
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    [self addSubview:self.redPointLbl];
    return self;
}

/// 刷新小红点数量
/// @param pointCount  【0：隐藏 】 【大于 99显示 99+】
- (void)reloadWithCount:(NSInteger)pointCount {
    if (pointCount > 0) {
        self.hidden = NO;
    } else {
        self.hidden = YES;
    }
    self.redPointLbl.text = [NSString stringWithFormat:@"%ld",(long)pointCount];
    if (pointCount > 99) {
        self.redPointLbl.text = @"99+";
    }
    [self.redPointLbl sizeToFit];
    CGFloat width = self.redPointLbl.width + 11;
    CGFloat height = self.redPointLbl.height + 1;
    if (pointCount > 9) {
        height = self.redPointLbl.height + 2;
    }
    self.redPointLbl.frame = CGRectMake(2, 2, width, height);
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, width + 4, height + 4);
    // 添加三个圆角
    [self addRectCorner:height/2.0 corners:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomRight toView:self.redPointLbl];
    [self addRectCorner:(height + 2)/2.0 corners:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomRight toView:self];

}

/// 刷新小红点数量 -- 大的红点气泡样式
/// @param pointCount  【0：隐藏 】 【大于 99显示 99+】
- (void)reloadBigRedPointWithCount:(NSInteger)pointCount {
    if (pointCount > 0) {
        self.hidden = NO;
    } else {
        self.hidden = YES;
    }
    self.redPointLbl.text = [NSString stringWithFormat:@"%ld",(long)pointCount];
    if (pointCount > 99) {
        self.redPointLbl.text = @"99+";
    }
    [self.redPointLbl sizeToFit];
    CGFloat width = self.redPointLbl.width + 13;
    CGFloat height = self.redPointLbl.height + 6;
    if (pointCount > 9) {
        height = self.redPointLbl.height + 6;
    }
    self.redPointLbl.frame = CGRectMake(2, 2, width, height);
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, width + 4, height + 4);
    // 添加三个圆角
    [self addRectCorner:height/2.0 corners:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomRight toView:self.redPointLbl];
    [self addRectCorner:(height + 2)/2.0 corners:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomRight toView:self];

}


#pragma mark - 为了不依赖其他类，把切圆角的方法，写到这里
/**
 *  添加UIView的四个角的任意角的圆角 需要对设置圆角的view添加frame，否则不行
 *
 *  @param angle    圆角的大小
 *  @param corners  设置哪个角为圆角
 *  @param toView  给哪个view设置圆角
 */
- (void)addRectCorner:(float)angle corners:(UIRectCorner)corners toView:(UIView *)toView {
    // 设置圆角，需要view有frame
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:toView.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(angle, angle)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = toView.bounds;
    maskLayer.path = maskPath.CGPath;
    toView.layer.mask = maskLayer;
}

#pragma mark - 懒加载
- (UILabel *)redPointLbl {
    if (!_redPointLbl) {
        _redPointLbl = [[UILabel alloc] init];
        _redPointLbl.backgroundColor = [UIColor redColor];
        _redPointLbl.textColor = [UIColor whiteColor];
        _redPointLbl.textAlignment = NSTextAlignmentCenter;
        _redPointLbl.font = [UIFont systemFontOfSize:10];
        _redPointLbl.layer.masksToBounds = YES;
    }
    return _redPointLbl;
}


@end
