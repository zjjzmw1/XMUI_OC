//
//  DemoTimerVC.m
//  XMUI_OC
//
//  Created by ext.zhangmingwei1 on 2022/6/3.
//

#import "DemoTimerVC.h"
#import "XMTimer.h"

#import "XMToast.h"

@interface DemoTimerVC ()

@property (nonatomic, strong) UIButton  *btn1;
@property (nonatomic, strong) UIButton  *btn2;

@property (nonatomic, strong) XMTimer   *myTimer;

@end

@implementation DemoTimerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.customNaviView setTitleStr:@"XMTimer"];

    self.btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.btn1];
    self.btn1.frame = CGRectMake(0, 150, kScreenWidth_XM, 50);
    [self.btn1 setTitle:@"全局定时器，需要手动销毁" forState:UIControlStateNormal];
    [self.btn1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.btn1 addTarget:self action:@selector(totalTimerAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.btn2];
    self.btn2.frame = CGRectMake(0, 250, kScreenWidth_XM, 50);
    [self.btn2 setTitle:@"临时定时器、随着页面自动销毁" forState:UIControlStateNormal];
    [self.btn2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.btn2 addTarget:self action:@selector(myTimerAction) forControlEvents:UIControlEventTouchUpInside];

    
}

#pragma mark - 全局定时器，需要手动销毁
- (void)totalTimerAction {
    // 3s后开始调用直到 [[XMTimer defaultManager] xm_cancelTimerWithName：]
    [[XMTimer defaultManager] xm_scheduleGCDTimerWithName:kGlobalTimerName interval:3 queue:dispatch_get_main_queue() repeats:YES action:^{
        NSLog(@"当前页面可以正常销毁，但是定时器不会自动销毁，需要手动调用xm_cancel方法");
        [XMToast showTextToCenter:@"全局定时器-3s"];
    }];
}

#pragma mark - 临时定时器、随着页面自动销毁
- (void)myTimerAction {
    // 3s后开始调用直到 当前页面销毁
    self.myTimer = [[XMTimer alloc] init];
    [self.myTimer xm_scheduleGCDTimerWithName:@"myTime2" interval:3 queue:dispatch_get_main_queue() repeats:YES action:^{
        NSLog(@"当前页面可以正常销毁，定时器也会自动销毁");
        [XMToast showTextToCenter:@"临时定时器-3s"];
    }];
}

@end
