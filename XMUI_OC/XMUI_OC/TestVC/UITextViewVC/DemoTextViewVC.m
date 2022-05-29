//
//  DemoTextViewVC.m
//  XMUI_OC
//
//  Created by ext.zhangmingwei1 on 2022/5/29.
//

#import "DemoTextViewVC.h"
#import "XMTextView.h"

@interface DemoTextViewVC ()

@property (nonatomic, strong) XMTextView    *textV;

@end

@implementation DemoTextViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.customNaviView setTitleStr:@"XMTextView"];
    
    self.textV = [[XMTextView alloc] initWithFrame: CGRectMake(50, 150, 200, 100)];
    [self.view addSubview:self.textV];
    self.textV.placeholder = @"请输入内容";
    self.textV.placeholerFont = [UIFont systemFontOfSize:16];
    self.textV.font = [UIFont systemFontOfSize:16];
    self.textV.textColor = [UIColor redColor];
    self.textV.placeholderColor = [UIColor grayColor];
    self.textV.backgroundColor = [UIColor blueColor];
//    self.textV.contentInset = UIEdgeInsetsMake(10, 10, 10, 10);
}



@end
