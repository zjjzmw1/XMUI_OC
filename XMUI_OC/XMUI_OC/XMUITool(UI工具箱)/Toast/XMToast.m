//
//  XMToast.m
//  XMUI_OC
//
//  Created by ext.zhangmingwei1 on 2022/5/26.
//

#import "XMToast.h"
#import "XMSizeMacro.h"

@interface XMToast()

/// 内容view
@property (nonatomic, strong) UIView    *contentV;
/// 提示文字label
@property (nonatomic, strong) UILabel   *titleLbl;
/// 定时器
@property (nonatomic, strong) NSTimer   *timer;

@end

@implementation XMToast

+ (instancetype)sharedInstance {
    static XMToast *single = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        single = [[XMToast alloc] init];
    });
    return single;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = NO;
        if (self.superview == nil) {
            [[UIApplication sharedApplication].keyWindow addSubview:self];
        }
        if (self.superview == nil) {
            [[UIApplication sharedApplication].windows.lastObject addSubview:self];
        }

        [self addSubview:self.contentV];
        [self addSubview:self.titleLbl];
        
    }
    return self;
}

/// 上下居中弹出存文字 toast 「默认1.5s后消失，文字长的话，会适当延迟消失时间」
/// @param text  弹出文字
+ (void)showTextToCenter:(NSString *)text {
    [XMToast showText:text positionType:XMToastPositionTypeCenter];
}

/// 弹出存文字 toast 「默认1.5s后消失，文字长的话，会适当延迟消失时间」
/// @param text 弹出文字
/// @param positionType  居中 还是 底部
+ (void)showText:(NSString *)text positionType:(XMToastPositionType)positionType {
    [[XMToast sharedInstance].timer invalidate];
    [XMToast sharedInstance].timer = nil;
    [[XMToast sharedInstance] removeFromSuperview]; // 只移除自己，不移除字视图。
    [XMToast sharedInstance].alpha = 1.0;
    if (text.length <= 0) {
        return;
    }
    if ([XMToast sharedInstance].superview == nil) {
        [[UIApplication sharedApplication].keyWindow addSubview:[XMToast sharedInstance]];
    }
    if ([XMToast sharedInstance].superview == nil) {
        [[UIApplication sharedApplication].windows.lastObject addSubview:[XMToast sharedInstance]];
    }
    [XMToast sharedInstance].frame = [XMToast sharedInstance].superview.frame;
    [XMToast sharedInstance].userInteractionEnabled = NO;
    
    // 添加行间距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5];
    [paragraphStyle setLineBreakMode:NSLineBreakByWordWrapping];
    [paragraphStyle setAlignment:NSTextAlignmentCenter];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
    [XMToast sharedInstance].titleLbl.attributedText = attributedString;
    
    [XMToast sharedInstance].titleLbl.frame = CGRectMake(0, 0, kScreenWidth_XM - 60 * 2, 0);
    [[XMToast sharedInstance].titleLbl sizeToFit];
    
    // 文字距离背景的间隙
    CGFloat topMargin = 16.0f; // 上间距
    CGFloat sideMargin = 20.0f; // 左右间距
    CGFloat bottomMargin = 16.0f; // 下间距
    CGFloat contentW = [XMToast sharedInstance].titleLbl.frame.size.width + sideMargin * 2.0;
    if (contentW < 150) {
        contentW = 150;
    }
    [XMToast sharedInstance].titleLbl.textAlignment = NSTextAlignmentCenter;
    [XMToast sharedInstance].contentV.layer.cornerRadius = 10;
    
    [XMToast sharedInstance].titleLbl.center = [XMToast sharedInstance].center;
    [XMToast sharedInstance].contentV.frame = CGRectMake([XMToast sharedInstance].titleLbl.frame.origin.x - sideMargin, [XMToast sharedInstance].titleLbl.frame.origin.y - topMargin, [XMToast sharedInstance].titleLbl.frame.size.width + sideMargin * 2.0, [XMToast sharedInstance].titleLbl.frame.size.height + topMargin + bottomMargin);
    if (positionType == XMToastPositionTypeBottom) { // 底部位置
        [XMToast sharedInstance].titleLbl.frame = CGRectMake([XMToast sharedInstance].titleLbl.frame.origin.x, kScreenHeight_XM - [XMToast sharedInstance].titleLbl.frame.size.height - 60 - kSafeAreaBottom_XM, [XMToast sharedInstance].titleLbl.frame.size.width, [XMToast sharedInstance].titleLbl.frame.size.height);
        [XMToast sharedInstance].contentV.frame = CGRectMake([XMToast sharedInstance].titleLbl.frame.origin.x - sideMargin, [XMToast sharedInstance].titleLbl.frame.origin.y - topMargin, [XMToast sharedInstance].titleLbl.frame.size.width + sideMargin * 2.0, [XMToast sharedInstance].titleLbl.frame.size.height + topMargin + bottomMargin);
    }
    
    float delayTime = 1.5;
    if (text.length > 10) {
        delayTime = 1.8;
    }
    if (text.length > 15) { // 再多的字就不合理了
        delayTime = 2.0;
    }
    // 默认1.5s后隐藏
    [XMToast sharedInstance].timer = [NSTimer scheduledTimerWithTimeInterval:delayTime target:[XMToast sharedInstance] selector:@selector(hiddenAction) userInfo:nil repeats:NO];
    [[NSRunLoop currentRunLoop] addTimer:[XMToast sharedInstance].timer forMode:NSRunLoopCommonModes];

}

/// 隐藏 toast
- (void)hiddenAction {
    [self.timer invalidate];
    self.timer = nil;
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - 懒加载

- (UIView *)contentV {
    if (!_contentV) {
        _contentV = [[UIView alloc] init];
        _contentV.layer.masksToBounds = YES;
        _contentV.layer.cornerRadius = 8;
        _contentV.backgroundColor = [UIColor colorWithRed:5/255.0 green:5/255.0 blue:5/255.0 alpha:0.8];
        _contentV.alpha = 1.0;
        _contentV.userInteractionEnabled = NO;
    }
    return _contentV;
}

- (UILabel *)titleLbl {
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] init];
        _titleLbl.textColor = [UIColor whiteColor];
        _titleLbl.font = [UIFont systemFontOfSize:14];
        _titleLbl.textAlignment = NSTextAlignmentCenter;
        _titleLbl.numberOfLines = 0;
    }
    return _titleLbl;
}

@end

