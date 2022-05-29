//
//  DemoTextFieldVC.m
//  XMUI_OC
//
//  Created by ext.zhangmingwei1 on 2022/5/29.
//

#import "DemoTextFieldVC.h"
#import "UITextField+XMTool.h"

@interface DemoTextFieldVC ()

@property (nonatomic, strong) UITextField   *textField;

@end

@implementation DemoTextFieldVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.customNaviView setTitleStr:@"UITextField+XMTool"];
    
    self.textField = [UITextField getInstancWithLeftSpace:8 placeholderColor:[UIColor lightGrayColor] textColor:[UIColor blackColor]];
    [self.view addSubview:self.textField];
    self.textField.frame = CGRectMake(50, 200, 200, 40);
    self.textField.placeholder = @"用户名";
    self.textField.backgroundColor = [UIColor redColor];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.textField resignFirstResponder];
}



@end
