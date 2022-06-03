//
//  DemoBaseVC.m
//  XMUI_OC
//
//  Created by ext.zhangmingwei1 on 2022/5/28.
//

#import "DemoBaseVC.h"

#import "XMToast.h"

@interface DemoBaseVC ()

@end

@implementation DemoBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // 默认隐藏自带导航栏
    self.fd_prefersNavigationBarHidden = YES;
    // 展示自己的导航栏
    self.customNaviView = [XMCustomNaviView getInstanceWithTitle:@""];
    self.customNaviView.lineImgV.hidden = NO;
    [self.view addSubview:self.customNaviView];

}

- (void)dealloc {
    NSLog(@"页面销毁了");
    [XMToast showTextToCenter:[NSString stringWithFormat:@"%@ - %@",NSStringFromClass(self.class),@"页面销毁了"]];
}

@end
