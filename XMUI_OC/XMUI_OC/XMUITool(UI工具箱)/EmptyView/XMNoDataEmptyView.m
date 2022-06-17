//
//  XMNoDataEmptyView.m
//  XMUI_OC
//
//  Created by zhangmingwei on 2022/6/17.
//

#import "XMNoDataEmptyView.h"

@implementation XMNoDataEmptyView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    // 用frame的方式，防止个别项目没用 masonry,或者用的其他第三方的布局。 frame通吃.
    self.topSpace = 215;
    // 默认隐藏
    [self hiddenAction];
    if (frame.size.width == 0 || frame.size.height == 0) { // 用户未设置，就全屏
        self.frame = CGRectMake(0, kNaviStatusBarH_XM, kScreenWidth_XM, kScreenHeight_XM - kNaviStatusBarH_XM);
    }
    [self addSubview:self.emptyImageView];
    [self addSubview:self.emptyTipLabel];
    [self addSubview:self.emptyRefreshButton];
            
    return self;
}

#pragma mark - 点击回调方法
- (void)clickAction {
    if (self.clickBlock) {
        self.clickBlock();
    }
}

/// 刷新空页面数据
/// @param tipStr 提示文案
/// @param emptyImage 空图片，没有就传nil
- (void)showWithTipString:(NSString *)tipStr emptyImage:(nullable UIImage *)emptyImage {
    self.emptyImageView.image = emptyImage;
    self.emptyTipLabel.text = tipStr;
    [self.emptyTipLabel sizeToFit];
    self.hidden = NO;
    [self.superview bringSubviewToFront:self];
    // 刷新frame
    [self reloadFrameAction];
}

/// 隐藏
- (void)hiddenAction {
    self.hidden = YES;
}

- (void)setTopSpace:(CGFloat)topSpace {
    _topSpace = topSpace;
    // 刷新frame
    [self reloadFrameAction];
}

/// 刷新frame
- (void)reloadFrameAction {
    UIImage *emptyImage = self.emptyImageView.image;
    self.emptyImageView.frame = CGRectMake((self.frame.size.width - emptyImage.size.width)/2, self.topSpace, emptyImage.size.width, emptyImage.size.height);
    if (emptyImage.size.width > 0) { // 有图
        self.emptyTipLabel.frame = CGRectMake(20, self.emptyImageView.bottom + 12, self.frame.size.width - 40, 20);
    } else { // 没图
        self.emptyTipLabel.frame = CGRectMake(20, self.topSpace, self.frame.size.width - 40, 20);
    }
    self.emptyRefreshButton.frame = CGRectMake((self.frame.size.width - 100)/2.0, self.emptyTipLabel.bottom + 18, 100, 28);
}

#pragma mark - 懒加载

- (UIImageView *)emptyImageView {
    if (!_emptyImageView) {
        _emptyImageView = [[UIImageView alloc] init];
    }
    return _emptyImageView;
}

- (UILabel *)emptyTipLabel {
    if (!_emptyTipLabel) {
        _emptyTipLabel = [[UILabel alloc] init];
        _emptyTipLabel.textAlignment = NSTextAlignmentCenter;
        _emptyTipLabel.numberOfLines = 0;
        _emptyTipLabel.textColor = [UIColor blackColor];
        _emptyTipLabel.font = [UIFont systemFontOfSize:14];
    }
    return _emptyTipLabel;
}

- (UIButton *)emptyRefreshButton {
    if (!_emptyRefreshButton) {
        _emptyRefreshButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_emptyRefreshButton setTitle:@"重试" forState:UIControlStateNormal];
        [_emptyRefreshButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _emptyRefreshButton.titleLabel.font = [UIFont systemFontOfSize:12];
        _emptyRefreshButton.backgroundColor = [UIColor redColor];
        [_emptyRefreshButton addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
        _emptyRefreshButton.layer.masksToBounds = YES;
        _emptyRefreshButton.layer.cornerRadius = 6;
    }
    return _emptyRefreshButton;
}


@end
