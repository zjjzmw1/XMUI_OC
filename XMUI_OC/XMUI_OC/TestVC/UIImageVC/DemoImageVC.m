//
//  DemoImageVC.m
//  XMUI_OC
//
//  Created by ext.zhangmingwei1 on 2022/5/30.
//

#import "DemoImageVC.h"
#import "UIImage+XMTool.h"

@interface DemoImageVC ()

@property (nonatomic, strong) UIImageView   *imgV1;
@property (nonatomic, strong) UIImageView   *imgV2;

@property (nonatomic, strong) UIImageView   *imgV3;
@property (nonatomic, strong) UIImageView   *imgV4;
@property (nonatomic, strong) UIImageView   *imgV5;

@end

@implementation DemoImageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.customNaviView setTitleStr:@"UIImage+XMTool"];
    
    self.imgV1 = [[UIImageView alloc] initWithFrame:CGRectMake(50, 150, 200, 100)];
    [self.view addSubview:self.imgV1];
    UIImage *img = [UIImage getImageFromColors:@[[UIColor redColor],[UIColor blueColor]] ByGradientType:GradientType_LeftToRight size:CGSizeMake(200, 100)];
    self.imgV1.image = img;
    
    self.imgV2 = [[UIImageView alloc] initWithFrame:CGRectMake(50, self.imgV1.bottom + 50, 200, 100)];
    [self.view addSubview:self.imgV2];
    UIImage *img2 = [UIImage getImageFromColors:@[[UIColor redColor],[UIColor blueColor]] ByGradientType:GradientType_TopLeftToBottomRight size:CGSizeMake(200, 100)];
    self.imgV2.image = img2;
    
    self.imgV3 = [[UIImageView alloc] initWithFrame:CGRectMake(50, self.imgV2.bottom + 50, 100, 50)];
    [self.view addSubview:self.imgV3];
    self.imgV3.image = [UIImage getNewImageFromCenterWithOriginImage:[UIImage imageNamed:@"photo_icon"]];

    self.imgV4 = [[UIImageView alloc] initWithFrame:CGRectMake(50, self.imgV3.bottom + 50, 50, 100)];
    [self.view addSubview:self.imgV4];
    self.imgV4.image = [UIImage getNewImageFromCenterWithOriginImage:[UIImage imageNamed:@"photo_icon"]];

    self.imgV5 = [[UIImageView alloc] initWithFrame:CGRectMake(50, self.imgV4.bottom + 50, 20, 18)];
    [self.view addSubview:self.imgV5];
    self.imgV5.image = [UIImage getNewImageFromCenterWithOriginImage:[UIImage imageNamed:@"photo_icon"]];


}


@end
