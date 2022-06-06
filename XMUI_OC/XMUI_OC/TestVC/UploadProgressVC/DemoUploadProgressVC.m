//
//  DemoUploadProgressVC.m
//  XMUI_OC
//
//  Created by ext.zhangmingwei1 on 2022/6/2.
//

#import "DemoUploadProgressVC.h"

#import "XMUploadProgressView.h" // 上传图片的状态view
#import "XMProgressBarView.h"   // 进度条 + 文字
@interface DemoUploadProgressVC ()

@property (nonatomic, strong) XMUploadProgressView  *uploadView1;
@property (nonatomic, strong) XMUploadProgressView  *uploadView2;
@property (nonatomic, strong) XMUploadProgressView  *uploadView3;
@property (nonatomic, strong) XMUploadProgressView  *uploadView4;

@property (nonatomic, strong) XMProgressBarView     *progressBarV1;
@property (nonatomic, strong) XMProgressBarView     *progressBarV2;
@property (nonatomic, strong) XMProgressBarView     *progressBarV3;


@property (nonatomic, strong) XMProgressBarView     *progressBarV4;
@property (nonatomic, strong) XMProgressBarView     *progressBarV5;
@property (nonatomic, strong) XMProgressBarView     *progressBarV6;
@end

@implementation DemoUploadProgressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.customNaviView setTitleStr:@"图片上传状态"];
    
    self.uploadView1 = [[XMUploadProgressView alloc] initWithFrame:CGRectMake(50, 150, 100, 100)];
    [self.view addSubview:self.uploadView1];
    [self.uploadView1 reloadDataWithStatus:XMUploadProgressStatusNone selectImage:nil];
    
    self.uploadView2 = [[XMUploadProgressView alloc] initWithFrame:CGRectMake(222, 150, 100, 100)];
    [self.view addSubview:self.uploadView2];
    [self.uploadView2 reloadDataWithStatus:XMUploadProgressStatusError selectImage:[UIImage imageNamed:@"test_image"]];

    self.uploadView3 = [[XMUploadProgressView alloc] initWithFrame:CGRectMake(50, 350, 100, 100)];
    [self.view addSubview:self.uploadView3];
    [self.uploadView3 reloadDataWithStatus:XMUploadProgressStatusLoading selectImage:[UIImage imageNamed:@"test_image"]];

    self.uploadView4 = [[XMUploadProgressView alloc] initWithFrame:CGRectMake(222, 350, 100, 100)];
    [self.view addSubview:self.uploadView4];
    [self.uploadView4 reloadDataWithStatus:XMUploadProgressStatusSuccess selectImage:[UIImage imageNamed:@"test_image"]];

    self.uploadView1.deleteImageSuccessBlock = ^{
        NSLog(@"删除了。。。111");
    };
    self.uploadView2.deleteImageSuccessBlock = ^{
        NSLog(@"删除了。。。22");
    };
    self.uploadView3.deleteImageSuccessBlock = ^{
        NSLog(@"删除了。。。33");
    };
    self.uploadView4.deleteImageSuccessBlock = ^{
        NSLog(@"删除了。。44");
    };

    // 进度条
    self.progressBarV1 = [[XMProgressBarView alloc] initWithFrame:CGRectMake(50, self.uploadView4.bottom + 60, kScreenWidth_XM - 100, 20)];
    [self.view addSubview:self.progressBarV1];
    [self.progressBarV1 reloadDataWithProgress:0];
    
    self.progressBarV2 = [[XMProgressBarView alloc] initWithFrame:CGRectMake(50, self.uploadView4.bottom + 100, kScreenWidth_XM - 100, 20)];
    [self.view addSubview:self.progressBarV2];
    [self.progressBarV2 reloadDataWithProgress:0.66];

    self.progressBarV3 = [[XMProgressBarView alloc] initWithFrame:CGRectMake(50, self.uploadView4.bottom + 150, kScreenWidth_XM - 100, 20)];
    [self.view addSubview:self.progressBarV3];
    [self.progressBarV3 reloadDataWithProgress:1];
    
    
    
    // 进度条
    self.progressBarV4 = [[XMProgressBarView alloc] initWithFrame:CGRectMake(50, self.progressBarV3.bottom + 20, kScreenWidth_XM - 100, 20)];
    [self.view addSubview:self.progressBarV4];
    [self.progressBarV4 reloadOtherDataWithProgress:0];
    
    self.progressBarV5 = [[XMProgressBarView alloc] initWithFrame:CGRectMake(50, self.progressBarV4.bottom + 20, kScreenWidth_XM - 100, 20)];
    [self.view addSubview:self.progressBarV5];
    [self.progressBarV5 reloadOtherDataWithProgress:0.66];

    self.progressBarV6 = [[XMProgressBarView alloc] initWithFrame:CGRectMake(50, self.progressBarV5.bottom + 20, kScreenWidth_XM - 100, 20)];
    [self.view addSubview:self.progressBarV6];
    [self.progressBarV6 reloadOtherDataWithProgress:1];

    
    
    

}


@end
