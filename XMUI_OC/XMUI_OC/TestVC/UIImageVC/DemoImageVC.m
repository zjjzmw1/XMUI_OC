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

}


@end
