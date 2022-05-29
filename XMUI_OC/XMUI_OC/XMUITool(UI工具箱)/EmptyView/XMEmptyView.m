//
//  XMEmptyView.m
//  XMUI_OC
//
//  Created by ext.zhangmingwei1 on 2022/5/29.
//

#import "XMEmptyView.h"

@interface XMEmptyView()

/// 当前空页面的size
@property (nonatomic, assign) CGSize        currentSize;

@end

@implementation XMEmptyView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.currentSize = frame.size;
    /// 用frame的方式，防止个别项目没用 masonry,或者用的其他第三方的布局。 frame通吃.
    
    // 提示文案
    self.tipLbl = [[UILabel alloc] init];
    self.tipLbl.font = [UIFont boldSystemFontOfSize:16];
    self.tipLbl.textColor = [UIColor blackColor];
    self.tipLbl.backgroundColor = [UIColor clearColor];
    [self addSubview:self.tipLbl];
    self.tipLbl.numberOfLines = 0;
    self.tipLbl.textAlignment = NSTextAlignmentCenter;
    // 重试的文字
    self.retryLbl = [[UILabel alloc] init];
    self.retryLbl.font = [UIFont boldSystemFontOfSize:15];
    self.retryLbl.textColor = [UIColor redColor];
    self.retryLbl.backgroundColor = [UIColor clearColor];
    [self addSubview:self.retryLbl];
    self.retryLbl.numberOfLines = 0;
    self.retryLbl.textAlignment = NSTextAlignmentCenter;

    [self.retryLbl setUserInteractionEnabled:YES];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAction)];
    [self.retryLbl addGestureRecognizer:tap];
    
    return self;
}

#pragma mark - 点击回调方法
- (void)clickAction {
    self.cliccBlock();
}

/// 刷新显示空页面的内容
/// @param tipStr 提示文字
/// @param retryStr  重试的文字
- (void)reloadWithTipStr:(NSString *)tipStr retryStr:(NSString *)retryStr {
    self.tipLbl.text = tipStr;
    self.retryLbl.text = retryStr;
    // 提示文字的位置更新
    self.tipLbl.frame = CGRectMake(15, self.currentSize.height/3.0 , self.frame.size.width - 30, 50);
    [self.tipLbl sizeToFit];
    self.tipLbl.centerX = self.centerX - self.left;
    // 重试文字的位置更新
    self.retryLbl.frame = CGRectMake(15, self.tipLbl.bottom + 10 , self.frame.size.width - 30, 40);
    [self.retryLbl sizeToFit];
    self.retryLbl.centerX = self.centerX - self.left;
}


@end
