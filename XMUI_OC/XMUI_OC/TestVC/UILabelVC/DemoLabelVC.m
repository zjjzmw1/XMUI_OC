//
//  DemoLabelVC.m
//  XMUI_OC
//
//  Created by ext.zhangmingwei1 on 2022/5/27.
//

#import "DemoLabelVC.h"
#import "UIView+XMTool.h"
#import "XMSizeMacro.h"
#import "UILabel+XMTool.h"
#import "XMCustomNaviView.h"

@interface DemoLabelVC ()

@property (nonatomic, strong) UILabel   *lbl1;

@property (nonatomic, strong) UILabel   *lbl2;

@property (nonatomic, strong) UILabel   *lbl3;


@end

@implementation DemoLabelVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController setNavigationBarHidden:YES];
    XMCustomNaviView *naviV = [XMCustomNaviView getInstanceWithTitle:@"UILabel"];
    naviV.lineImgV.hidden = NO;
    [self.view addSubview:naviV];
    
    
    self.lbl1 = [UILabel getLabelWithFont:[UIFont systemFontOfSize:15] textColor:[UIColor redColor]];
    [self.view addSubview:self.lbl1];
    self.lbl1.backgroundColor = [UIColor lightGrayColor];
    self.lbl1.text = @"快捷创建label";
    self.lbl1.frame = CGRectMake(20, kNaviStatusBarH_XM + 20, kScreenWidth_XM - 40, 0);
    [self.lbl1 sizeToFit];

    
    self.lbl2 = [UILabel getLabelWithFont:[UIFont systemFontOfSize:15] textColor:[UIColor redColor]];
    [self.view addSubview:self.lbl2];
    self.lbl2.xm_contentInsets = UIEdgeInsetsMake(15, 10, 15, 10);
    self.lbl2.backgroundColor = [UIColor lightGrayColor];
    self.lbl2.text = @"多行上下左右边距的: 快捷创建label xm_contentInsets = UIEdgeInsetsMake(15, 10, 15, 10)快捷创建lab快捷创建lab快捷创建lab";
    self.lbl2.frame = CGRectMake(20, self.lbl1.bottom + 20, kScreenWidth_XM - 40, 0);
    self.lbl2.numberOfLines = 0;
    [self.lbl2 sizeToFit];

    
    self.lbl3 = [UILabel getLabelWithFont:[UIFont systemFontOfSize:15] textColor:[UIColor redColor]];
    [self.view addSubview:self.lbl3];
    self.lbl3.xm_contentInsets = UIEdgeInsetsMake(15, 10, 15, 10);
    self.lbl3.backgroundColor = [UIColor lightGrayColor];
    self.lbl3.frame = CGRectMake(20, self.lbl2.bottom + 20, kScreenWidth_XM - 40, 0);
    self.lbl3.numberOfLines = 0;
    [self.lbl3 setText:@"带行间距 6 的并且带上下左右边距的。。。。。。。多行上下左右边距的: 快捷创建label xm_contentInsets = UIEdgeInsetsMake(15, 10, 15, 10)快捷创建lab快捷创建lab快捷创建lab" lineSpacing:6];
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
