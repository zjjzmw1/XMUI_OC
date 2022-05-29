//
//  DemoEmptyVC.m
//  XMUI_OC
//
//  Created by ext.zhangmingwei1 on 2022/5/29.
//

#import "DemoEmptyVC.h"
#import "XMEmptyView.h"
#import "XMToast.h"

@interface DemoEmptyVC ()

@property (nonatomic, strong) XMEmptyView   *emptyView;

@end

@implementation DemoEmptyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.customNaviView setTitleStr:@"XMEmptyView"];
    
    self.emptyView = [[XMEmptyView alloc] initWithFrame:CGRectMake(0, kNaviStatusBarH_XM, kScreenWidth_XM, kScreenHeight_XM - kNaviStatusBarH_XM)];
    [self.view addSubview:self.emptyView];
    [self.emptyView reloadWithTipStr:@"网络错误" retryStr:@"请重试"];
    [self.emptyView setCliccBlock:^{
        [XMToast showText:@"点击了" positionType:XMToastPositionTypeCenter];
    }];
    
}


@end
