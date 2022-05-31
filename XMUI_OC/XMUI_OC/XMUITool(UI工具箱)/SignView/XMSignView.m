//
//  XMSignView.m
//  XMUI_OC
//
//  Created by ext.zhangmingwei1 on 2022/5/31.
//

#import "XMSignView.h"
#import "XMCanvasView.h"

@interface WJCanvasView : UIView

@property (strong, nonatomic) UIButton *enterBtn;
@property (strong, nonatomic) UIButton *resetlBtn;
@property (strong, nonatomic) UIButton *closeBtn;
@property (nonatomic, strong) XMCanvasView *signatureView;
@property (nonatomic, strong) void (^imageDataBlock)(UIImage *image);
@property (nonatomic, strong) void (^hiddenActionBlock)(void);
@property (strong, nonatomic) UIView *navView;
@property (nonatomic, strong) UILabel *titleLabel;
@end


@interface XMSignView ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *callbackView;
//@property (nonatomic, strong) UILabel *callbackLabel;
@property (nonatomic, strong) WJCanvasView *canvasView;
@property (nonatomic, assign) BOOL isCanvas;
@property (nonatomic, strong) UILabel *starLabel;

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

#pragma mark - public method

- (void)setCallbackImageUrl:(NSString *)url {
//    if (url) {
//        [self.callbackView yy_setImageWithURL:[NSURL URLWithString:url]
//                                placeholder:nil
//                                    options:YYWebImageOptionIgnoreFailedURL
//                                    manager:[YYWebImageManager sharedManager]
//                                   progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//
//        } transform:^UIImage * _Nullable(UIImage * _Nonnull image, NSURL * _Nonnull url) {
//            UIImage *rotatedImage = [UIImage imageWithCGImage:image.CGImage scale:1.0f orientation:UIImageOrientationUp];
//            return rotatedImage;
//        } completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
//            self.callbackView.image = image;
//            self.callbackView.hidden = NO;
//            self.callbackImage = image;
//        }];
//    }
//
//    NSString *title = @"签字";
//    NSMutableAttributedString *mutAtt = [[NSMutableAttributedString alloc] initWithString:title attributes: @{NSForegroundColorAttributeName: [UIColor redColor],NSFontAttributeName : [UIFont systemFontOfSize:14}];
//    self.titleLabel.attributedText = mutAtt;
}

#pragma mark - private method

- (void)onTapSignatureAction {
    if (!_isCanvas) {
        if (self.onClickViewBlock) {
            self.onClickViewBlock(NO);
        }
        if (!_canvasView) {
            __weak typeof(self) weakSelf = self;
            // 横屏的签名view
            _canvasView = [[WJCanvasView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width)];

            _canvasView.imageDataBlock = ^(UIImage *image) {
                UIImage *rotatedImage = [UIImage imageWithCGImage:image.CGImage scale:1.0f orientation:UIImageOrientationUp];
                weakSelf.callbackView.hidden = NO;
                weakSelf.callbackView.image = rotatedImage;
                weakSelf.callbackImage = rotatedImage;
                if (weakSelf.imageDataBlock) {
                    weakSelf.imageDataBlock(weakSelf, rotatedImage);
                }
            };
            _canvasView.hiddenActionBlock = ^() {
                if (weakSelf.onClickViewBlock) {
                    weakSelf.onClickViewBlock(YES);
                    weakSelf.isCanvas = NO;
                }
            };
            [[UIApplication sharedApplication].keyWindow addSubview:self.canvasView];
            self.canvasView.center = self.canvasView.superview.center; // 居中
        }
        _canvasView.hidden = NO;
        // 旋转90度
        self.canvasView.transform = CGAffineTransformIdentity;
        [UIView animateWithDuration:0.2 animations:^{
            self.canvasView.transform = CGAffineTransformMakeRotation(M_PI/2.0);
        } completion:^(BOOL finished) {
            
        }];
    } else {
        _canvasView.hidden = YES;
    }
}

- (void)initViews {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapSignatureAction)];
    [self addGestureRecognizer:tap];

    [self addSubview:self.titleLabel];
    self.titleLabel.frame = CGRectMake(20, 15, kScreenWidth_XM, 20);
        
    [self addSubview:self.callbackView];
    self.callbackView.frame = CGRectMake(0, self.titleLabel.bottom + 6, 160, 58);
}

#pragma mark - set and get
-(UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = [UIColor blackColor];
        NSString *title = @"签字";
        NSString *tip = @"  仅支持手动签名，不支持键盘输入";
        NSMutableAttributedString *mutAtt = [[NSMutableAttributedString alloc] initWithString:title attributes: @{NSForegroundColorAttributeName: [UIColor redColor],NSFontAttributeName : [UIFont systemFontOfSize:14]}];
        [mutAtt appendAttributedString:[[NSMutableAttributedString alloc] initWithString:tip attributes: @{NSFontAttributeName : [UIFont systemFontOfSize:12], NSForegroundColorAttributeName: [UIColor redColor]}]];
        self.titleLabel.attributedText = mutAtt;
    }
    return _titleLabel;
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
    }
    return _callbackView;
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

#pragma event action

- (void)resetAction {
    [_signatureView clearSignature];
}

- (void)dismissAction {
    [self setHidden:YES];
    if (self.hiddenActionBlock) {
        self.hiddenActionBlock();
    }
}

- (void)enterAction {
    [_signatureView saveSignature];
    if (self.imageDataBlock) {
        self.imageDataBlock(_signatureView.signatureImage);
    }
    [self dismissAction]; // 这里包含：隐藏、旋转屏幕
}


#pragma private method

- (void)initViews {
    [self addSubview:self.navView];
    [self addSubview:self.signatureView];
    [self addSubview:self.resetlBtn];
    [self addSubview:self.enterBtn];
    [self addSubview:self.closeBtn];
    [self addSubview:self.titleLabel];
    
    self.navView.frame = CGRectMake(0, 0, kScreenHeight_XM, 44);
    self.closeBtn.frame = CGRectMake(50, 50, 60, 30);
    self.titleLabel.frame = CGRectMake(0, 0, kScreenHeight_XM, 44);

//    [self.signatureView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self).offset(12);
//        make.bottom.and.right.equalTo(self).offset(-12);
//        make.top.equalTo(self.navView.mas_bottom).offset(12);
//    }];
    self.signatureView.frame = CGRectMake(12, self.navView.bottom + 12, kScreenHeight_XM - 24, kScreenWidth_XM - 24);
    
    self.resetlBtn.frame = CGRectMake(60, kScreenWidth_XM - 100, self.closeBtn.width, self.closeBtn.height);

    self.enterBtn.frame = CGRectMake(self.resetlBtn.right + 100, self.closeBtn.top, self.closeBtn.width, self.closeBtn.height);
}


#pragma mark - set and get

- (UIButton *)resetlBtn {
    if (!_resetlBtn) {
        _resetlBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_resetlBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_resetlBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resetAction)];
        [_resetlBtn addGestureRecognizer:tap];
    }
    return _resetlBtn;
}

- (UIButton *)enterBtn {
    if (!_enterBtn) {
        _enterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_enterBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_enterBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(enterAction)];
        [_enterBtn addGestureRecognizer:tap];
    }
    return _enterBtn;
}

- (UIButton *)closeBtn {
    if (!_closeBtn) {
        _closeBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_closeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_closeBtn setImage:[UIImage imageNamed:@"back_black"] forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(dismissAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}

- (XMCanvasView *)signatureView {
    if (!_signatureView) {
        _signatureView = [[XMCanvasView alloc] init];
        _signatureView.lineColor = [UIColor blackColor];
        _signatureView.backgroundColor = [UIColor whiteColor];
    }
    return _signatureView;
}


- (UIView *)navView {
    if (!_navView) {
        _navView = [[UIView alloc] init];
        _navView.backgroundColor = [UIColor whiteColor];
    }
    return _navView;
}

-(UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:17];
        _titleLabel.textColor = [UIColor redColor];
        _titleLabel.text = @"签字";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

@end

