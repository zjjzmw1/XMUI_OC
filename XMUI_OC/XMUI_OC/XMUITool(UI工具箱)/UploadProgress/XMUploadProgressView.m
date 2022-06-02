//
//  XMUploadProgressView.m
//  XMUI_OC
//
//  Created by ext.zhangmingwei1 on 2022/6/2.
//

#import "XMUploadProgressView.h"

@interface XMUploadProgressView()

/// 容器
@property (nonatomic, strong) UIView        *contentV;
/// 中心点的拍照图标
@property (nonatomic, strong) UIImageView   *iconImgV;
/// 上传的图片
@property (nonatomic, strong) UIImageView   *imageV;
/// 蒙层
@property (nonatomic, strong) UIView        *maskV;
/// 上传状态的label
@property (nonatomic, strong) UILabel       *statusLbl;
/// 状态图标
@property (nonatomic, strong) UIImageView   *statusImgV;
/// 关闭按钮
@property (nonatomic, strong) UIButton      *closeBtn;

@end

@implementation XMUploadProgressView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    [self addSubview:self.contentV];
    [self.contentV addSubview:self.iconImgV];
    [self.contentV addSubview:self.imageV];
    [self.contentV addSubview:self.maskV];
    [self.contentV addSubview:self.statusLbl];
    [self.contentV addSubview:self.statusImgV];
    [self addSubview:self.closeBtn];
    
    self.contentV.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    self.iconImgV.frame = CGRectMake((frame.size.width - 18)/2.0, (frame.size.height - 16)/2.0, 18, 16);
    self.imageV.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    self.maskV.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    self.statusLbl.frame = CGRectMake(0, frame.size.height - 20, frame.size.width, 20);
    self.statusImgV.frame = CGRectMake((frame.size.width - 30)/2.0, frame.size.height/2.0 - 30, 30, 30);
    self.closeBtn.frame = CGRectMake(frame.size.width - 15, -15, 30, 30);
    
    // 默认刷新数据
    [self reloadDataWithStatus:XMUploadProgressStatusNone selectImage:nil];
    
    return self;
}

#pragma mark - 刷新数据、更新样式

/// 刷新数据
/// @param status 上传图片的状态
/// @param selectImage 当前选择的图片，未上传： nil
- (void)reloadDataWithStatus:(XMUploadProgressStatus)status selectImage:(nullable UIImage *)selectImage {
    self.imageV.image = selectImage;
    if (self.imageV.image == nil) { // 未选择图片
        self.maskV.hidden = YES;
        self.statusLbl.hidden = YES;
        self.statusImgV.hidden = YES;
        self.closeBtn.hidden = YES;
        return;
    } else { // 选择了图片
        self.maskV.hidden = NO;
        self.statusLbl.hidden = NO;
        self.statusImgV.hidden = NO;
        self.closeBtn.hidden = NO;
    }
    if (status == XMUploadProgressStatusLoading) { // 上传中
        self.statusLbl.hidden = NO;
        self.statusImgV.hidden = YES;
        self.maskV.hidden = NO;
        self.statusLbl.frame = CGRectMake(0, (self.frame.size.height - 20)/2.0, self.frame.size.width, 20);
        self.statusLbl.text = @"上传中...";
    } else if (status == XMUploadProgressStatusError) { // 失败
        self.statusLbl.hidden = NO;
        self.statusImgV.hidden = NO;
        self.maskV.hidden = NO;
        self.statusLbl.frame = CGRectMake(0, self.statusImgV.frame.size.height + self.statusImgV.frame.origin.y + 12, self.frame.size.width, 20);
        self.statusLbl.text = @"上传失败";
    } else { // 成功、或者未知状态
        self.statusLbl.hidden = YES;
        self.statusImgV.hidden = YES;
        self.maskV.hidden = YES;
    }
}

/// 删除图片
- (void)deleAction {
    self.imageV.image = nil;
    [self reloadDataWithStatus:XMUploadProgressStatusNone selectImage:nil];
    if (self.deleteImageSuccessBlock) {
        self.deleteImageSuccessBlock();
    }
}

#pragma mark - 懒加载
- (UIView *)contentV {
    if (!_contentV) {
        _contentV = [[UIView alloc] init];
        _contentV.backgroundColor = [XMUploadProgressView colorFromHexString:@"#F7F8FA"];
        _contentV.clipsToBounds = YES;
    }
    return _contentV;
}

- (UIImageView *)iconImgV {
    if (!_iconImgV) {
        _iconImgV = [[UIImageView alloc] init];
        _iconImgV.image = [UIImage imageNamed:@"photo_icon"];
    }
    return _iconImgV;
}

- (UIImageView *)imageV {
    if (!_imageV) {
        _imageV = [[UIImageView alloc] init];
        _imageV.backgroundColor = [UIColor clearColor];
        _imageV.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _imageV;
}

- (UIView *)maskV {
    if (!_maskV) {
        _maskV = [[UIView alloc] init];
        _maskV.backgroundColor = [XMUploadProgressView colorFromHexString:@"#000000" alpha:0.5];
    }
    return _maskV;
}

- (UILabel *)statusLbl {
    if (!_statusLbl) {
        _statusLbl = [[UILabel alloc] init];
        _statusLbl.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
        _statusLbl.textColor = [UIColor whiteColor];
        _statusLbl.textAlignment = NSTextAlignmentCenter;
        _statusLbl.text = @"上传中...";
    }
    return _statusLbl;
}

- (UIImageView *)statusImgV {
    if (!_statusImgV) {
        _statusImgV = [[UIImageView alloc] init];
        _statusImgV.image = [UIImage imageNamed:@"error_icon"];
    }
    return _statusImgV;
}

- (UIButton *)closeBtn {
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeBtn setImage:[UIImage imageNamed:@"close_icon"] forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(deleAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
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

#pragma mark - 扩大当前view的点击区域
#pragma mark - override super method
-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    // 如果 边界值无变化  失效 隐藏 或者透明 直接返回
    if (UIEdgeInsetsEqualToEdgeInsets(UIEdgeInsetsMake(-15, -15, -15, -15), UIEdgeInsetsZero) || (self.userInteractionEnabled == NO) || self.hidden || self.alpha == 0 ) {
        return [super pointInside:point withEvent:event];
    } else {
        CGRect relativeFrame = self.bounds;
        CGRect hitFrame = UIEdgeInsetsInsetRect(relativeFrame, UIEdgeInsetsMake(-15, -15, -15, -15));
        return CGRectContainsPoint(hitFrame, point);
    }
}


@end
