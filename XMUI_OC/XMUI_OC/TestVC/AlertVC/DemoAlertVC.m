//
//  DemoAlertVC.m
//  XMUI_OC
//
//  Created by ext.zhangmingwei1 on 2022/5/30.
//

#import "DemoAlertVC.h"
#import "XMAlertView.h"

@interface DemoAlertVC ()

@end

@implementation DemoAlertVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.customNaviView setTitleStr:@"XMAlertView"];
    

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    XMAlertView *alerV = [XMAlertView initWithTitle:@"确认要删除这 2 种商品吗？" contentStr:@"删除后将从你的记录里消失，无法找回打翻了；攻击力卡的设计规范；立刻打火锅鸡了；但是发" cancelStr:@"取消" submitStr:@"删除"];
    [alerV showAction];
}

@end
