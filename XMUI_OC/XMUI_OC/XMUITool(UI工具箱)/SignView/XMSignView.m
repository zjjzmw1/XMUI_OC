//
//  XMSignView.m
//  XMUI_OC
//
//  Created by ext.zhangmingwei1 on 2022/5/31.
//

#import "XMSignView.h"
#import "XMCanvasView.h"

@interface WJCanvasView : UIView

@property (strong, nonatomic) UIButton *submitBtn;
@property (strong, nonatomic) UIButton *cancelBtn;
@property (strong, nonatomic) UIButton *backBtn;
@property (nonatomic, strong) XMCanvasView *signatureView;
@property (nonatomic, strong) void (^imageDataBlock)(UIImage *image);
@property (nonatomic, strong) void (^hiddenActionBlock)(void);
@property (strong, nonatomic) UIView *navView;
@property (nonatomic, strong) UILabel *titleLabel;
@end


@interface XMSignView ()

// 最终返回到上个页面的图片view
@property (nonatomic, strong) UIImageView *callbackView;
@property (nonatomic, strong) WJCanvasView *canvasView;
@property (nonatomic, assign) BOOL isCanvas;

@end

@implementation XMSignView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self initViews];
    }
    return self;
}

- (void)initViews {
    [self addSubview:self.callbackView];
    self.callbackView.frame = CGRectMake((self.frame.size.width - 160)/2.0, (self.frame.size.height - 58)/2.0, 160, 58);
}

/// 展示横屏签名view
- (void)showAction {
    self.isShowing = YES;
    [[XMSignView getCurrentVC] setNeedsStatusBarAppearanceUpdate];
    if (!_isCanvas) {
        if (!_canvasView) {
            __weak typeof(self) weakSelf = self;
            // 横屏的签名view
            _canvasView = [[WJCanvasView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width)];

            _canvasView.imageDataBlock = ^(UIImage *image) {
                UIImage *rotatedImage = [UIImage imageWithCGImage:image.CGImage scale:1.0f orientation:UIImageOrientationUp];
                weakSelf.callbackView.hidden = NO;
                weakSelf.callbackView.image = rotatedImage;
                if (weakSelf.finishImageDataBlock) {
                    weakSelf.finishImageDataBlock(weakSelf, rotatedImage);
                }
            };
            _canvasView.hiddenActionBlock = ^() {
                weakSelf.isCanvas = NO;
                weakSelf.isShowing = NO;
                [[XMSignView getCurrentVC] setNeedsStatusBarAppearanceUpdate];
            };
            [[UIApplication sharedApplication].keyWindow addSubview:self.canvasView];
            self.canvasView.center = self.canvasView.superview.center; // 居中
        }
        _canvasView.hidden = NO;
        // 旋转90度
        self.canvasView.transform = CGAffineTransformIdentity;
        [UIView animateWithDuration:0.2 animations:^{
            self.canvasView.alpha = 1.0;
            self.canvasView.transform = CGAffineTransformMakeRotation(M_PI/2.0);
        } completion:^(BOOL finished) {
            
        }];
    } else {
        _canvasView.hidden = YES;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.width, self.height) byRoundingCorners:UIRectCornerAllCorners  cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = CGRectMake(0, 0, self.width - 10*2, self.height);
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

- (UIView *)callbackView {
    if (!_callbackView) {
        _callbackView = [[UIImageView alloc] init];
        _callbackView.backgroundColor = [UIColor whiteColor];
        _callbackView.contentMode = UIViewContentModeScaleAspectFit;
        _callbackView.hidden = YES;
        _callbackView.layer.masksToBounds = YES;
        _callbackView.layer.cornerRadius = 5;
    }
    return _callbackView;
}

#pragma mark - 获取当前屏幕显示的viewcontroller
+ (nullable UIViewController *)getCurrentVC {
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *currentVC = [XMSignView getCurrentVCFrom:rootViewController];
    return currentVC;
}

+ (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC {
    UIViewController *currentVC;
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        rootVC = [rootVC presentedViewController];
    }
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        currentVC = [XMSignView getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
    } else if ([rootVC isKindOfClass:[UINavigationController class]]) {
        // 根视图为UINavigationController
        currentVC = [XMSignView getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
    } else {
        // 根视图为非导航类
        currentVC = rootVC;
    }
    return currentVC;
}

@end


@implementation WJCanvasView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self initViews];
    }
    return self;
}

/// 取消
- (void)resetAction {
    [_signatureView clearSignature];
}

/// 确定
- (void)enterAction {
    if (self.imageDataBlock) {
        self.imageDataBlock(_signatureView.signatureImage);
    }
    [self dismissAction]; // 这里包含：隐藏、旋转屏幕
}

- (void)dismissAction {
    // -- 恢复竖屏
    [UIView animateWithDuration:0.2 animations:^{
        self.transform = CGAffineTransformIdentity;
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self setHidden:YES];
        if (self.hiddenActionBlock) {
            self.hiddenActionBlock();
        }
    }];
}

#pragma private method

- (void)initViews {
    [self addSubview:self.titleLabel]; // 横屏导航栏标题
    [self addSubview:self.signatureView]; // 画布
    [self addSubview:self.backBtn]; // 返回按钮
    [self addSubview:self.cancelBtn]; // 取消
    [self addSubview:self.submitBtn]; // 确定
     
    self.titleLabel.frame = CGRectMake(0, 0, kScreenHeight_XM, 44);
    self.signatureView.frame = CGRectMake(kStatusBarHeight_XM, 44, kScreenHeight_XM - kStatusBarHeight_XM - kSafeAreaBottom_XM, kScreenWidth_XM - 44);
    self.backBtn.frame = CGRectMake(kStatusBarHeight_XM, 0, 44, 44);
    self.cancelBtn.frame = CGRectMake(kScreenHeight_XM/2.0 - 66 - 40, kScreenWidth_XM - 60, 66, 40);
    self.submitBtn.frame = CGRectMake(kScreenHeight_XM/2.0 + 40, kScreenWidth_XM - 60, 66, 40);
}


#pragma mark - set and get

- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn setTitle:@"重置" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _cancelBtn.backgroundColor = [UIColor redColor];
        _cancelBtn.layer.masksToBounds = YES;
        _cancelBtn.layer.cornerRadius = 6;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resetAction)];
        [_cancelBtn addGestureRecognizer:tap];
    }
    return _cancelBtn;
}

- (UIButton *)submitBtn {
    if (!_submitBtn) {
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_submitBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _submitBtn.backgroundColor = [UIColor blueColor];
        _submitBtn.layer.masksToBounds = YES;
        _submitBtn.layer.cornerRadius = 6;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(enterAction)];
        [_submitBtn addGestureRecognizer:tap];
    }
    return _submitBtn;
}

- (UIButton *)backBtn {
    if (!_backBtn) {
        _backBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_backBtn setImage:[UIImage imageNamed:@"back_black"] forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(dismissAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

- (XMCanvasView *)signatureView {
    if (!_signatureView) {
        _signatureView = [[XMCanvasView alloc] init];
        _signatureView.lineColor = [UIColor blackColor];
        _signatureView.backgroundColor = [UIColor whiteColor];
    }
    return _signatureView;
}

/// 横屏导航栏 标题
-(UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont boldSystemFontOfSize:17];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.text = @"签字";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

@end

