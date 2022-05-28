//
//  DemoPopMenuVC.m
//  XMUI_OC
//
//  Created by ext.zhangmingwei1 on 2022/5/28.
//

#import "DemoPopMenuVC.h"
#import "XMCustomNaviView.h"

#import "UIView+XMTool.h"
#import "XMSizeMacro.h"
#import "UILabel+XMTool.h"
#import "XMPopMenu.h"

@interface DemoPopMenuVC ()

@property (nonatomic, strong) UILabel   *lbl1;
@property (nonatomic, strong) UILabel   *lbl2;
@property (nonatomic, strong) UILabel   *lbl3;

@property (nonatomic, strong) UILabel   *lbl4;
@property (nonatomic, strong) UILabel   *lbl5;


@end

@implementation DemoPopMenuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController setNavigationBarHidden:YES];
    XMCustomNaviView *naviV = [XMCustomNaviView getInstanceWithTitle:@"XMPopMenu"];
    naviV.lineImgV.hidden = NO;
    [self.view addSubview:naviV];
    
    __weak typeof(self) weakSelf = self;

    self.lbl1 = [UILabel getLabelWithFont:[UIFont systemFontOfSize:15] textColor:[UIColor redColor]];
    [self.view addSubview:self.lbl1];
    self.lbl1.backgroundColor = [UIColor lightGrayColor];
    self.lbl1.text = @"指定位置CGPointMake(200, 200)弹出锚点为（0.5, 0）";
    self.lbl1.frame = CGRectMake(20, kNaviStatusBarH_XM + 20, kScreenWidth_XM - 40, 0);
    [self.lbl1 sizeToFit];
    [self.lbl1 setTapActionWithBlock:^{
        XMPopMenu *popV = [XMPopMenu showAtPoint:CGPointMake(200, 200) titles:@[@"扫一扫",@"添加好友",@"通讯录"] icons:nil menuWidth:120 isShowTriangle:YES arrowLeft:0];
        popV.clickBlock = ^(int selectRow) {
        NSLog(@"点击了第 %d 行",selectRow);
        };
    }];
    
    self.lbl2 = [UILabel getLabelWithFont:[UIFont systemFontOfSize:15] textColor:[UIColor redColor]];
    [self.view addSubview:self.lbl2];
    self.lbl2.backgroundColor = [UIColor lightGrayColor];
    self.lbl2.text = @"依赖于自己弹出";
    self.lbl2.frame = CGRectMake(20, self.lbl1.bottom + 20, kScreenWidth_XM - 40, 0);
    [self.lbl2 sizeToFit];
    [self.lbl2 setTapActionWithBlock:^{
        XMPopMenu *popV = [XMPopMenu showRelyOnView: weakSelf.lbl2 titles:@[@"扫一扫",@"添加好友",@"通讯录"] icons:@[@"back_black",@"back_black",@"back_black"] menuWidth:120 isShowTriangle:YES arrowLeft:0];
        popV.clickBlock = ^(int selectRow) {
        NSLog(@"点击了第 %d 行",selectRow);
        };
    }];

    self.lbl3 = [UILabel getLabelWithFont:[UIFont systemFontOfSize:15] textColor:[UIColor redColor]];
    [self.view addSubview:self.lbl3];
    self.lbl3.backgroundColor = [UIColor lightGrayColor];
    self.lbl3.text = @"依赖于导航栏";
    self.lbl3.frame = CGRectMake(20, self.lbl2.bottom + 20, kScreenWidth_XM - 40, 0);
    [self.lbl3 sizeToFit];
    [self.lbl3 setTapActionWithBlock:^{
        XMPopMenu *popV = [XMPopMenu showRelyOnView: naviV titles:@[@"扫一扫",@"添加好友",@"通讯录"] icons:@[@"back_black",@"back_black",@"back_black"] menuWidth:120 isShowTriangle:YES arrowLeft:0];
        popV.clickBlock = ^(int selectRow) {
        NSLog(@"点击了第 %d 行",selectRow);
        };
    }];

    
    self.lbl4 = [UILabel getLabelWithFont:[UIFont systemFontOfSize:15] textColor:[UIColor redColor]];
    [self.view addSubview:self.lbl4];
    self.lbl4.textAlignment = NSTextAlignmentRight;
    self.lbl4.backgroundColor = [UIColor lightGrayColor];
    self.lbl4.text = @"依赖自己，不带箭头";
    self.lbl4.frame = CGRectMake(220, self.lbl3.bottom + 20, kScreenWidth_XM - 40, 0);
    [self.lbl4 sizeToFit];
    [self.lbl4 setTapActionWithBlock:^{
        XMPopMenu *popV = [XMPopMenu showRelyOnView: weakSelf.lbl4 titles:@[@"扫一扫",@"添加好友",@"通讯录"] icons:nil menuWidth:120 isShowTriangle:NO arrowLeft:0];
        popV.clickBlock = ^(int selectRow) {
        NSLog(@"点击了第 %d 行",selectRow);
        };
    }];
    
    self.lbl5 = [UILabel getLabelWithFont:[UIFont systemFontOfSize:15] textColor:[UIColor redColor]];
    [self.view addSubview:self.lbl5];
    self.lbl5.textAlignment = NSTextAlignmentRight;
    self.lbl5.backgroundColor = [UIColor lightGrayColor];
    self.lbl5.text = @"依赖自己，带箭头";
    self.lbl5.frame = CGRectMake(220, kScreenHeight_XM - 100, kScreenWidth_XM - 40, 0);
    [self.lbl5 sizeToFit];
    [self.lbl5 setTapActionWithBlock:^{
        XMPopMenu *popV = [XMPopMenu showRelyOnView: weakSelf.lbl5 titles:@[@"扫一扫",@"添加好友",@"通讯录"] icons:nil menuWidth:120 isShowTriangle:YES arrowLeft:0];
        popV.clickBlock = ^(int selectRow) {
        NSLog(@"点击了第 %d 行",selectRow);
        };
    }];
}

- (void)dealloc {
    NSLog(@"销毁了。");
}


@end
