//
//  DemoCircleProgressVC.m
//  XMUI_OC
//
//  Created by ext.zhangmingwei1 on 2022/6/5.
//

#import "DemoCircleProgressVC.h"
#import "XMCircleProgressView.h"

@interface DemoCircleProgressVC ()

@property (nonatomic, strong) XMCircleProgressView  *cicleProgressV1;
@property (nonatomic, strong) XMCircleProgressView  *cicleProgressV2;
@property (nonatomic, strong) XMCircleProgressView  *cicleProgressV3;
@property (nonatomic, strong) XMCircleProgressView  *cicleProgressV4;

@property (nonatomic, strong) XMCircleProgressView  *cicleProgressV5;
@property (nonatomic, strong) XMCircleProgressView  *cicleProgressV6;


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
    
    self.cicleProgressV5 = [[XMCircleProgressView alloc] initWithFrame:CGRectMake(50, 450, 100, 100)];
    [self.view addSubview:self.cicleProgressV5];
    self.cicleProgressV5.progress = 0.25;
    [self.cicleProgressV5 updateStartAngle:1.5 * M_PI endAngle:1.5 * M_PI + M_PI * 2 clockwise:YES];

    self.cicleProgressV6 = [[XMCircleProgressView alloc] initWithFrame:CGRectMake(200, 450, 100, 100)];
    [self.view addSubview:self.cicleProgressV6];
    self.cicleProgressV6.progress = 0.25;
    // 不是完整的圆  --- 类似仪表板
    CGFloat start = M_PI - 0.25 * M_PI;
    CGFloat end = start + M_PI * 2 - 0.5 * M_PI;
    [self.cicleProgressV6 updateStartAngle:start endAngle:end clockwise:YES];

}



@end
