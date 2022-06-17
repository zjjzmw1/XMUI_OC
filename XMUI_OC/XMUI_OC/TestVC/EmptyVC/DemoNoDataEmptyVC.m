//
//  DemoNoDataEmptyVC.m
//  XMUI_OC
//
//  Created by ext.zhangmingwei1 on 2022/6/17.
//

#import "DemoNoDataEmptyVC.h"
#import "XMNoDataEmptyView.h"
#import "XMToast.h"
#import "UIImage+XMTool.h"

@interface DemoNoDataEmptyVC ()

@end

@implementation DemoNoDataEmptyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.customNaviView setTitleStr:@"XMNoDataEmptyView"];
    
    XMNoDataEmptyView *emptyView = [[XMNoDataEmptyView alloc] init];
    [self.view addSubview:emptyView];
    UIImage *tempImg = [UIImage imageWithColor:[UIColor lightGrayColor] size:CGSizeMake(100, 100)];
    [emptyView showWithTipString:@"暂无数据，请稍后重试" emptyImage:tempImg];
    [emptyView setClickBlock:^{
        [XMToast showTextToCenter:@"点击刷新"];
    }];
}



@end
