//
//  DemoTextFieldVC.m
//  XMUI_OC
//
//  Created by ext.zhangmingwei1 on 2022/5/29.
//

#import "DemoTextFieldVC.h"
#import "UITextField+XMTool.h"

#import "XMToast.h"

@interface DemoTextFieldVC ()<UITextFieldDelegate>

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
    // 最多长度的限制
    self.textField.delegate = self;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.textField resignFirstResponder];
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField.text.length + string.length > 8) { // 假如最多展示8个字符
        [XMToast showTextToCenter:@"最多输入8个字符"];
        return NO;
    }
    return YES;
}

@end
