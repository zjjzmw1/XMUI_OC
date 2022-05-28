//
//  DemoBaseVC.m
//  XMUI_OC
//
//  Created by ext.zhangmingwei1 on 2022/5/28.
//

#import "DemoBaseVC.h"

@interface DemoBaseVC ()

@end

@implementation DemoBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // 默认隐藏自带导航栏
    self.fd_prefersNavigationBarHidden = YES;
    // 展示自己的导航栏
    self.customNaviView = [XMCustomNaviView getInstanceWithTitle:@""];
    self.customNaviView.lineImgV.hidden = NO;
    [self.view addSubview:self.customNaviView];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
