//
//  DemoImageLabelVC.m
//  XMUI_OC
//
//  Created by ext.zhangmingwei1 on 2022/6/7.
//

#import "DemoImageLabelVC.h"
#import "XMImageLabelView.h"

#import "XMToast.h"

@interface DemoImageLabelVC ()

@property (nonatomic, strong) XMImageLabelView  *imgLblView1;
@property (nonatomic, strong) XMImageLabelView  *imgLblView2;
@property (nonatomic, strong) XMImageLabelView  *imgLblView3;

@property (nonatomic, strong) XMImageLabelView  *imgLblView4;
@property (nonatomic, strong) XMImageLabelView  *imgLblView5;

@end

@implementation DemoImageLabelVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.imgLblView1 = [[XMImageLabelView alloc] initWithFrame:CGRectMake(50, 150, 100, 60)];
    [self.view addSubview:self.imgLblView1];
    [self.imgLblView1 reloadDataWithImage:[UIImage imageNamed:@"photo_icon"] textString:@"拍照" type:XMImageLabelType_ImageTop];
    self.imgLblView1.backgroundColor = [UIColor lightGrayColor];

    
    self.imgLblView2 = [[XMImageLabelView alloc] initWithFrame:CGRectMake(200, 150, 50, 50)];
    [self.view addSubview:self.imgLblView2];
    [self.imgLblView2 reloadDataWithImage:[UIImage imageNamed:@"photo_icon"] textString:@"拍照" type:XMImageLabelType_ImageTop];
    self.imgLblView2.backgroundColor = [UIColor lightGrayColor];

    
    self.imgLblView3 = [[XMImageLabelView alloc] initWithFrame:CGRectMake(50, 300, 20, 20)];
    [self.view addSubview:self.imgLblView3];
    [self.imgLblView3 reloadDataWithImage:[UIImage imageNamed:@"photo_icon"] textString:@"拍照" type:XMImageLabelType_ImageTop];
    self.imgLblView3.backgroundColor = [UIColor lightGrayColor];

    
    self.imgLblView4 = [[XMImageLabelView alloc] initWithFrame:CGRectMake(50, 400, 20, 60)];
    [self.view addSubview:self.imgLblView4];
    [self.imgLblView4 reloadDataWithImage:[UIImage imageNamed:@"photo_icon"] textString:@"拍照" type:XMImageLabelType_LabelTop];
    self.imgLblView4.backgroundColor = [UIColor lightGrayColor];
    
    self.imgLblView4 = [[XMImageLabelView alloc] initWithFrame:CGRectMake(200, 400, 20, 20)];
    [self.view addSubview:self.imgLblView4];
    [self.imgLblView4 reloadDataWithImage:[UIImage imageNamed:@"photo_icon"] textString:@"拍照" type:XMImageLabelType_LabelTop];
    self.imgLblView4.backgroundColor = [UIColor lightGrayColor];

    self.imgLblView1.clickBlock = ^{
        [XMToast showTextToCenter:@"点击了"];
    };
    self.imgLblView2.clickBlock = ^{
        [XMToast showTextToCenter:@"点击了"];
    };
    self.imgLblView3.clickBlock = ^{
        [XMToast showTextToCenter:@"点击了"];
    };
    self.imgLblView4.clickBlock = ^{
        [XMToast showTextToCenter:@"点击了"];
    };
    self.imgLblView4.clickBlock = ^{
        [XMToast showTextToCenter:@"点击了"];
    };

}


@end
