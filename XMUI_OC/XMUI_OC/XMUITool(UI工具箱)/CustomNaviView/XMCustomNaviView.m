//
//  XMCustomNaviView.m
//  XMUI_OC
//
//  Created by ext.zhangmingwei1 on 2022/5/26.
//

#import "XMCustomNaviView.h"
#import "XMSizeMacro.h"

@implementation XMCustomNaviView

/**
 获取自定义导航栏
 */
+ (instancetype)getInstanceWithTitle:(nullable NSString *)titleStr {
    XMCustomNaviView *naviV = [[XMCustomNaviView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, kNaviStatusBarH_XM)];
    [naviV setTitleStr:titleStr];
    return naviV;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor whiteColor];
    // 返回按钮
    self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backBtn.frame = CGRectMake(0, kStatusBarHeight_XM, 60 , kNaviStatusBarH_XM - kStatusBarHeight_XM);
    // 扩大点击区域
//    [self.backBtn setEnlargeEdgeWithTop:10 right:10 bottom:10 left:10];
    [self.backBtn setImage:[UIImage imageNamed:@"back_black"] forState:UIControlStateNormal];
    [self.backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.backBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:self.backBtn];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backAction)];
    [self.backBtn addGestureRecognizer:tap];
    // 标题
    self.titleLbl = [[UILabel alloc] init];
    self.titleLbl.font = [UIFont systemFontOfSize:17 weight:UIFontWeightMedium];
    self.titleLbl.textAlignment = NSTextAlignmentCenter;
    self.titleLbl.textColor = [UIColor blackColor];
    // 这里如果用masnory，具体使用该类的地方，就不能再使用frame了，使用的时候就不那么灵活了。
    self.titleLbl.frame = CGRectMake(75, kStatusBarHeight_XM, kScreenWidth_XM - 150, kNaviStatusBarH_XM - kStatusBarHeight_XM);
    [self addSubview:self.titleLbl];
    // 右边按钮
    self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightBtn.frame = CGRectMake(kScreenWidth_XM - 60, kStatusBarHeight_XM, 60 , kNaviStatusBarH_XM - kStatusBarHeight_XM);
    [self.rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    
    self.rightBtn.hidden = YES;
    // 扩大点击区域
//    [self.rightBtn setEnlargeEdgeWithTop:10 right:10 bottom:10 left:10];
    [self addSubview:self.rightBtn];
    UITapGestureRecognizer *rightTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rightAction)];
    [self.rightBtn addGestureRecognizer:rightTap];
    // 底部横线
    self.lineImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 0.5, kScreenWidth_XM, 0.5)];
    [self addSubview:self.lineImgV];
    self.lineImgV.backgroundColor = [UIColor colorWithRed:100.0/255.0 green:100.0/255.0 blue:100.0/255.0 alpha:0.1];
    self.lineImgV.hidden = YES;
    
    // 如果是首页就隐藏返回按钮
    if ([XMCustomNaviView getCurrentVC].navigationController.viewControllers.count == 1) {
        [self setBackBtnImage:nil title:nil];
    }
    
    return self;
}

/// 设置标题
- (void)setTitleStr:(nullable NSString *)titleStr {
    self.titleLbl.text = titleStr;
}

/// 设置返回按钮的  图片和标题
- (void)setBackBtnImage:(nullable UIImage *)img title:(nullable NSString *)titleStr {
    [self.backBtn setImage:img forState:UIControlStateNormal];
    [self.backBtn setTitle:titleStr forState:UIControlStateNormal];
}

/// 设置右边按钮的  图片和标题
- (void)setRightBtnImage:(nullable UIImage *)img title:(nullable NSString *)titleStr {
    [self.rightBtn setImage:img forState:UIControlStateNormal];
    [self.rightBtn setTitle:titleStr forState:UIControlStateNormal];
    if (img || titleStr.length > 0) {
        self.rightBtn.hidden = NO; // 显示右边按钮
    } else {
        self.rightBtn.hidden = YES; // 隐藏
    }
}

/// 是否展示底部横线
- (void)showBottomLine:(BOOL)isShow {
    self.lineImgV.hidden = !isShow;
}

#pragma mark - 返回按钮点击
- (void)backAction {
    __weak typeof(self) weakSelf = self;
    if (weakSelf.backBlock) {
        weakSelf.backBlock();
    } else { // 不写的话，默认pop出去
        [[XMCustomNaviView getCurrentVC].navigationController popViewControllerAnimated:YES];
        [[XMCustomNaviView getCurrentVC] dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
}

#pragma mark - 右边按钮点击
- (void)rightAction {
    __weak typeof(self) weakSelf = self;
    if (weakSelf.rightBlock) {
        weakSelf.rightBlock();
    }
}


#pragma mark - 获取当前屏幕显示的viewcontroller
+ (nullable UIViewController *)getCurrentVC {
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *currentVC = [XMCustomNaviView getCurrentVCFrom:rootViewController];
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
        currentVC = [XMCustomNaviView getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
    } else if ([rootVC isKindOfClass:[UINavigationController class]]) {
        // 根视图为UINavigationController
        currentVC = [XMCustomNaviView getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
    } else {
        // 根视图为非导航类
        currentVC = rootVC;
    }
    return currentVC;
}

@end
