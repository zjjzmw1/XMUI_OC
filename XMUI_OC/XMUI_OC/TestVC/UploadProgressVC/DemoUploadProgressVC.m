//
//  DemoUploadProgressVC.m
//  XMUI_OC
//
//  Created by ext.zhangmingwei1 on 2022/6/2.
//

#import "DemoUploadProgressVC.h"
#import "XMUploadProgressView.h"

@interface DemoUploadProgressVC ()

@property (nonatomic, strong) XMUploadProgressView  *uploadView1;
@property (nonatomic, strong) XMUploadProgressView  *uploadView2;
@property (nonatomic, strong) XMUploadProgressView  *uploadView3;
@property (nonatomic, strong) XMUploadProgressView  *uploadView4;

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

}


@end
