//
//  DemoCircleProgressVC.m
//  XMUI_OC
//
//  Created by ext.zhangmingwei1 on 2022/6/5.
//

#import "DemoCircleProgressVC.h"
#import "XMCircleProgressView.h"
#import "XMCircleGradientProgressView.h"

@interface DemoCircleProgressVC ()

@property (nonatomic, strong) XMCircleProgressView  *cicleProgressV1;
@property (nonatomic, strong) XMCircleProgressView  *cicleProgressV2;
@property (nonatomic, strong) XMCircleProgressView  *cicleProgressV3;
@property (nonatomic, strong) XMCircleProgressView  *cicleProgressV4;

// 渐变色
@property (nonatomic, strong) XMCircleGradientProgressView  *gradientV1;
@property (nonatomic, strong) XMCircleGradientProgressView  *gradientV2;
@property (nonatomic, strong) XMCircleGradientProgressView  *gradientV3;
@property (nonatomic, strong) XMCircleGradientProgressView  *gradientV4;


@end

@implementation DemoCircleProgressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.customNaviView setTitleStr:@"XMCircleProgressView"];
    
    
    self.cicleProgressV1 = [[XMCircleProgressView alloc] initWithFrame:CGRectMake(50, 150, 100, 100)];
    [self.view addSubview:self.cicleProgressV1];
    self.cicleProgressV1.progress = 0.0;
    
    self.cicleProgressV2 = [[XMCircleProgressView alloc] initWithFrame:CGRectMake(200, 150, 100, 100)];
    [self.view addSubview:self.cicleProgressV2];
    self.cicleProgressV2.progress = 0.5;

    self.cicleProgressV3 = [[XMCircleProgressView alloc] initWithFrame:CGRectMake(50, 300, 100, 100)];
    [self.view addSubview:self.cicleProgressV3];
    self.cicleProgressV3.progress = 0.9;

    self.cicleProgressV4 = [[XMCircleProgressView alloc] initWithFrame:CGRectMake(200, 300, 100, 100)];
    [self.view addSubview:self.cicleProgressV4];
    self.cicleProgressV4.progress = 1.0;
    // 不是完整的圆  --- 类似仪表板
    CGFloat start = M_PI - 0.25 * M_PI;
    CGFloat end = start + M_PI * 2 - 0.5 * M_PI;
    [self.cicleProgressV4 updateStartAngle:start endAngle:end clockwise:YES];

    
    // 渐变
    
    self.gradientV1 = [[XMCircleGradientProgressView alloc] initWithFrame:CGRectMake(50, 450, 100, 100)];
    [self.view addSubview:self.gradientV1];
    self.gradientV1.progress = 1;

    self.gradientV2 = [[XMCircleGradientProgressView alloc] initWithFrame:CGRectMake(200, 450, 100, 100)];
    [self.view addSubview:self.gradientV2];
    self.gradientV2.progress = 0.9;
    
    self.gradientV3 = [[XMCircleGradientProgressView alloc] initWithFrame:CGRectMake(50, 580, 100, 100)];
    [self.view addSubview:self.gradientV3];
    self.gradientV3.progress = 1;

    self.gradientV4 = [[XMCircleGradientProgressView alloc] initWithFrame:CGRectMake(200, 580, 100, 100)];
    [self.view addSubview:self.gradientV4];
    self.gradientV4.progress = 0.9;
    // 不是完整的圆  --- 类似仪表板
    CGFloat start2 = M_PI - 0.25 * M_PI;
    CGFloat end2 = start2 + M_PI * 2 - 0.5 * M_PI;
    [self.gradientV3 updateStartAngle:start2 endAngle:end2 clockwise:YES];
    [self.gradientV4 updateStartAngle:start2 endAngle:end2 clockwise:YES];


}



@end
