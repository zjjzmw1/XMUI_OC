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

#import "UILabel+GradientLayer.h"

@interface DemoLabelVC ()

@property (nonatomic, strong) UILabel   *lbl1;

@property (nonatomic, strong) UILabel   *lbl2;

@property (nonatomic, strong) UILabel   *lbl3;

@property (nonatomic, strong) UILabel   *lbl4;

@property (nonatomic, strong) UILabel   *lbl5;

@property (nonatomic, strong) UILabel   *lbl6;


@end

@implementation DemoLabelVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.customNaviView setTitleStr:@"UILabel+XMTool"];
    
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
    
    self.lbl4 = [UILabel getLabelWithFont:[UIFont systemFontOfSize:15] textColor:[UIColor redColor]];
    [self.view addSubview:self.lbl4];
    self.lbl4.xm_contentInsets = UIEdgeInsetsMake(15, 10, 15, 10);
    self.lbl4.backgroundColor = [UIColor lightGrayColor];
    self.lbl4.frame = CGRectMake(20, self.lbl3.bottom + 20, kScreenWidth_XM - 40, 80);
    self.lbl4.text = @"长文不换行的不能设置sizeToFit 宽高都要设置。。。。frame的高度会把上下边距的覆盖了，左右边距还OK。";
    
    self.lbl5 = [UILabel getLabelWithFont:[UIFont systemFontOfSize:12] textColor:[UIColor redColor]];
    [self.view addSubview:self.lbl5];
    self.lbl5.xm_contentInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    self.lbl5.backgroundColor = [UIColor lightGrayColor];
    self.lbl5.frame = CGRectMake(20, self.lbl4.bottom + 20, 200, 20);
    self.lbl5.text = @"frame实现最大宽度的长文撒大哥放";
    [self.lbl5 sizeToFit];
    if (self.lbl5.frame.size.width > 200) {
        self.lbl5.frame = CGRectMake(20, self.lbl4.bottom + 20, 200, 20);
    }
    
    self.lbl6 = [UILabel getLabelWithFont:[UIFont systemFontOfSize:16] textColor:[UIColor redColor]];
    [self.view addSubview:self.lbl6];
    self.lbl6.xm_contentInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    self.lbl6.backgroundColor = [UIColor grayColor];
    self.lbl6.frame = CGRectMake(20, self.lbl5.bottom + 20, 200, 20);
    self.lbl6.text = @"实现最大宽度";
    [self.lbl6 sizeToFit];
    if (self.lbl6.frame.size.width > 200) {
        self.lbl6.frame = CGRectMake(20, self.lbl5.bottom + 20, 200, 20);
    }
    
    // 添加渐变色
    [self.lbl6 addGradientTextAction];
}


@end
