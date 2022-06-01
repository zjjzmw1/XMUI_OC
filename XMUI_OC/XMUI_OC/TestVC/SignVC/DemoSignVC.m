//
//  DemoSignVC.m
//  XMUI_OC
//
//  Created by ext.zhangmingwei1 on 2022/5/31.
//

#import "DemoSignVC.h"
#import "XMSignView.h"

@interface DemoSignVC ()

/// 开始签名的按钮
@property (nonatomic, strong)  UIButton *signBtn;
/// 签名的view
@property (nonatomic, strong) XMSignView    *signView;

@end

@implementation DemoSignVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.customNaviView setTitleStr:@"签名"];
    // 开始签名的入口
    self.signBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.signBtn];
    [self.signBtn setTitle:@"开始签名" forState:UIControlStateNormal];
    [self.signBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.signBtn addTarget:self action:@selector(clickSignAction) forControlEvents:UIControlEventTouchUpInside];
    self.signBtn.frame = CGRectMake(20, 140, kScreenWidth_XM - 40, 40);
    // 签名view
    self.signView = [[XMSignView alloc] initWithFrame:CGRectMake(50, 300, kScreenWidth_XM - 100, 104)];
    self.signView.backgroundColor = [UIColor blueColor];
    __weak typeof(self) weakSelf = self;
    self.signView.finishImageDataBlock = ^(XMSignView *signatureView,UIImage * _Nonnull image) {
        NSLog(@"返回最新的签名image %@", image);
    };
    [self.view addSubview:self.signView];

}

- (void)clickSignAction {
    [self.signView showAction];
}

- (BOOL)prefersStatusBarHidden {
    return self.signView.isShowing;
}

@end
