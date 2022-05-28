//
//  DemoButtonVC.m
//  XMUI_OC
//
//  Created by ext.zhangmingwei1 on 2022/5/28.
//

#import "DemoButtonVC.h"

#import "UIButton+XMTool.h"
#import "XMToast.h"

@interface DemoButtonVC ()

@property (nonatomic, strong) UIButton  *btn1;
@property (nonatomic, strong) UIButton  *btn2;
@property (nonatomic, strong) UIButton  *btn3;
@property (nonatomic, strong) UIButton  *btn4;

@property (nonatomic, strong) UIButton  *btn5;
@property (nonatomic, strong) UIButton  *btn6;

@property (nonatomic, strong) UIButton  *btn7;
@property (nonatomic, strong) UIButton  *btn8;



@end

@implementation DemoButtonVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.customNaviView setTitleStr:@"UIButton"];
    
    
    self.btn1 = [UIButton getButtonWithTitle:@"便利按钮不设置宽高" titleColor:[UIColor redColor] font:[UIFont systemFontOfSize:15]];
    [self.view addSubview:self.btn1];
    self.btn1.backgroundColor = [UIColor grayColor];
    self.btn1.frame = CGRectMake(50, kNaviStatusBarH_XM + 50, 0, 0);
    [self.btn1 sizeToFit];
    [self.btn1 setTapActionWithBlock:^{
        [XMToast showText:@"点击了" positionType:XMToastPositionTypeCenter];
    }];
    
    
    self.btn2 = [UIButton getButtonWithTitle:@"扩大区域hitEdgeInsets(-20, -20, -60, -20)" titleColor:[UIColor redColor] font:[UIFont systemFontOfSize:15]];
    [self.view addSubview:self.btn2];
    self.btn2.hitEdgeInsets = UIEdgeInsetsMake(-20, -20, -60, -20);
    self.btn2.backgroundColor = [UIColor grayColor];
    self.btn2.frame = CGRectMake(50, self.btn1.bottom + 50, 0, 0);
    [self.btn2 sizeToFit];
    [self.btn2 setTapActionWithBlock:^{
        [XMToast showText:@"点击了" positionType:XMToastPositionTypeCenter];
    }];
    
    self.btn3 = [UIButton getButtonImageTitleWithImage:[UIImage imageNamed:@"test_icon"] title:@"图片文字" titleColor:[UIColor redColor] spacing:10 alignmentType:imageLeft_wholeCenter aFont:[UIFont systemFontOfSize:15]];
    [self.view addSubview:self.btn3];
    self.btn3.backgroundColor = [UIColor lightGrayColor];
    self.btn3.frame = CGRectMake(50, self.btn2.bottom + 100, 0, 0);
    [self.btn3 sizeToFit];
    
    self.btn4 = [UIButton getButtonImageTitleWithImage:[UIImage imageNamed:@"test_icon"] title:@"文字图片" titleColor:[UIColor redColor] spacing:10 alignmentType:imageRight_wholeCenter aFont:[UIFont systemFontOfSize:15]];
    [self.view addSubview:self.btn4];
    self.btn4.backgroundColor = [UIColor lightGrayColor];
    self.btn4.frame = CGRectMake(50, self.btn3.bottom + 10, 0, 0);
    [self.btn4 sizeToFit];

    self.btn5 = [UIButton getButtonImageTitleWithImage:[UIImage imageNamed:@"test_icon"] title:@"图片文字整体局右" titleColor:[UIColor redColor] spacing:10 alignmentType:imageleft_wholeRight aFont:[UIFont systemFontOfSize:15]];
    [self.view addSubview:self.btn5];
    self.btn5.backgroundColor = [UIColor lightGrayColor];
    self.btn5.frame = CGRectMake(50, self.btn4.bottom + 100, 200, 30);
//    [self.btn5 sizeToFit];
    
    self.btn6 = [UIButton getButtonImageTitleWithImage:[UIImage imageNamed:@"test_icon"] title:@"文字图片整体局右" titleColor:[UIColor redColor] spacing:10 alignmentType:imageRight_wholeRight aFont:[UIFont systemFontOfSize:15]];
    [self.view addSubview:self.btn6];
    self.btn6.backgroundColor = [UIColor lightGrayColor];
    self.btn6.frame = CGRectMake(50, self.btn5.bottom + 10, 200, 30);
//    [self.btn6 sizeToFit];

    self.btn7 = [UIButton getButtonImageTitleWithImage:[UIImage imageNamed:@"test_icon"] title:@"图片文字整体局左" titleColor:[UIColor redColor] spacing:10 alignmentType:imageLeft_wholeLeft aFont:[UIFont systemFontOfSize:15]];
    [self.view addSubview:self.btn7];
    self.btn7.backgroundColor = [UIColor lightGrayColor];
    self.btn7.frame = CGRectMake(50, self.btn6.bottom + 50, 200, 30);
//    [self.btn7 sizeToFit];
    
    self.btn8 = [UIButton getButtonImageTitleWithImage:[UIImage imageNamed:@"test_icon"] title:@"文字图片整体局左" titleColor:[UIColor redColor] spacing:10 alignmentType:imageRight_wholeLeft aFont:[UIFont systemFontOfSize:15]];
    [self.view addSubview:self.btn8];
    self.btn8.backgroundColor = [UIColor lightGrayColor];
    self.btn8.frame = CGRectMake(50, self.btn7.bottom + 10, 200, 30);
//    [self.btn8 sizeToFit];

    
}





@end
