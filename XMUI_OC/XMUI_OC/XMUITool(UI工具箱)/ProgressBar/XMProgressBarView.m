//
//  XMProgressBarView.m
//  XMUI_OC
//
//  Created by ext.zhangmingwei1 on 2022/6/2.
//

#import "XMProgressBarView.h"

typedef enum  {
    ProgressGradientType_TopToBottom = 0,         // 从上到小
    ProgressGradientType_LeftToRight = 1,         // 从左到右
    ProgressGradientType_TopLeftToBottomRight = 2,    // 左上到右下
    ProgressGradientType_TopRightToBottomLeft = 3,    // 右上到左下
} ProgressGradientType;

@interface XMProgressBarView()

/// 进度条背景图片
@property (nonatomic, strong) UIImageView   *barBgImageV;
/// 进度图片
@property (nonatomic, strong) UIImageView   *progressImgV;
/// 进度Label
@property (nonatomic, strong) UILabel       *progressLbl;

/// 进度背景色
@property (nonatomic, strong) UIImage       *progressBigImage;

@end

@implementation XMProgressBarView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    [self addSubview:self.barBgImageV];
    [self.barBgImageV addSubview:self.progressImgV];
    [self addSubview:self.progressLbl];
    
    self.barBgImageV.frame = CGRectMake(0, 0, frame.size.width, 10);
    self.progressImgV.frame = CGRectMake(0, 0, frame.size.width, 10);
    self.progressLbl.frame = CGRectMake(self.barBgImageV.frame.size.width + 10, 0, 20, 0);
    
    [self reloadDataWithProgress:0];
    
    return self;
}

/// 刷新进度条进度
/// @param progress  「0 -- 1」 CGFloat类型
- (void)reloadDataWithProgress:(CGFloat)progress {
    self.progressLbl.text = [NSString stringWithFormat:@"%.0f%%",progress*100];
    [self.progressLbl sizeToFit];
    CGFloat labelWidth = self.progressLbl.frame.size.width;
    CGFloat labelHeight = self.progressLbl.frame.size.height;
    if (labelHeight < 10) {
        labelHeight = 10;
    }
    CGFloat barWidth = self.frame.size.width - labelWidth - 10;
    self.barBgImageV.frame = CGRectMake(0, 0, barWidth, 10);
    self.progressImgV.frame = CGRectMake(0, 0, barWidth * progress, 10);
    self.progressLbl.frame = CGRectMake(barWidth + 10, (10 - labelHeight)/2.0, labelWidth, labelHeight);
}

#pragma mark - 懒加载

- (UIImageView *)barBgImageV {
    if (!_barBgImageV) {
        _barBgImageV = [[UIImageView alloc] init];
        _barBgImageV.backgroundColor = [XMProgressBarView colorFromHexString:@"#F5F6F7"];
        _barBgImageV.layer.masksToBounds = YES;
        _barBgImageV.layer.cornerRadius = 5;
    }
    return _barBgImageV;
}

- (UIImageView *)progressImgV {
    if (!_progressImgV) {
        _progressImgV = [[UIImageView alloc] init];
        _progressImgV.layer.masksToBounds = YES;
        _progressImgV.layer.cornerRadius = 5;
        //设置progressImgV填充类型
        _progressImgV.contentMode = UIViewContentModeScaleToFill;
        _progressImgV.image = self.progressBigImage;
    }
    return _progressImgV;
}

- (UILabel *)progressLbl {
    if (!_progressLbl) {
        _progressLbl = [[UILabel alloc] init];
        _progressLbl.font = [UIFont systemFontOfSize:13 weight:UIFontWeightMedium];
        _progressLbl.textColor = [XMProgressBarView colorFromHexString:@"#666666"];
        _progressLbl.text = @"0%";
    }
    return _progressLbl;
}

- (UIImage *)progressBigImage {
    if(!_progressBigImage){
        _progressBigImage =[XMProgressBarView getImageFromColors:@[[XMProgressBarView colorFromHexString:@"#FA6419"],[XMProgressBarView colorFromHexString:@"#FA2C19"]] ByGradientType:ProgressGradientType_LeftToRight size:CGSizeMake(self.frame.size.width, 10)];
        }
    return _progressBigImage;
}

#pragma mark - 方便的获取16进制的颜色，不引起其他类目，避免耦合性太高。

+ (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    hexString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner scanHexInt:&rgbValue];
    return [[self class] colorWithR:((rgbValue & 0xFF0000) >> 16) G:((rgbValue & 0xFF00) >> 8) B:(rgbValue & 0xFF) A:1.0];
}

+ (UIColor *)colorFromHexString:(NSString *)hexString alpha:(CGFloat)alpha{
    unsigned rgbValue = 0;
    hexString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner scanHexInt:&rgbValue];
    
    return [[self class] colorWithR:((rgbValue & 0xFF0000) >> 16) G:((rgbValue & 0xFF00) >> 8) B:(rgbValue & 0xFF) A:alpha];
}

+ (UIColor *)colorWithR:(CGFloat)red G:(CGFloat)green B:(CGFloat)blue A:(CGFloat)alpha {
    return [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:alpha];
}

#pragma mark - 根据色值 获取渐变 UIImage -- 为了高内聚、低耦合

/// 根据色值 获取渐变 UIImage
/// @param colors  颜色数组
/// @param gradientType 渐变的方向
/// @param size 大小
+ (UIImage *)getImageFromColors:(NSArray *)colors ByGradientType:(ProgressGradientType)gradientType size:(CGSize)size {
    NSMutableArray *ar = [NSMutableArray array];
    for (UIColor *c in colors) {
        [ar addObject:(id)c.CGColor];
    }
    UIGraphicsBeginImageContextWithOptions(size, YES, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef refColorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    CGGradientRef gradient = CGGradientCreateWithColors(refColorSpace, (CFArrayRef)ar, NULL);
    CGPoint start;
    CGPoint end;
    switch (gradientType) {
        case 0:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(0.0, size.height);
            break;
            
        case 1:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(size.width, 0.0);
            break;
            
        case 2:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(size.width, size.height);
            break;
            
        case 3:
            start = CGPointMake(size.width, 0.0);
            end = CGPointMake(0.0, size.height);
            break;
            
        default:
            break;
    }
    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    UIGraphicsEndImageContext();
    
    return image;
}

@end
