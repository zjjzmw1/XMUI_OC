//
//  TestFlutterVC.m
//  XMUI_OC
//
//  Created by zhangmingwei on 2022/11/10.
//

#import "TestFlutterVC.h"
@import UIKit;
@import Flutter;
#import "AppDelegate.h"

@interface TestFlutterVC ()

@property (nonatomic,strong) FlutterEngine *flutterEngine;

@end

@implementation TestFlutterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.customNaviView setTitleStr:@"测试flutter项目"];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    // Make a button to call the showFlutter function when pressed.
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(showFlutter)
     forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Show Flutter!" forState:UIControlStateNormal];
    button.backgroundColor = UIColor.blueColor;
    button.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
    [self.view addSubview:button];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button2 addTarget:self action:@selector(showFlutter2)
     forControlEvents:UIControlEventTouchUpInside];
    [button2 setTitle:@"Show Flutter 2" forState:UIControlStateNormal];
    button2.backgroundColor = UIColor.blueColor;
    button2.frame = CGRectMake(80.0, 300.0, 160.0, 40.0);
    [self.view addSubview:button2];
    
    // ios项目添加flutter页面
    self.flutterEngine = [[FlutterEngine alloc] initWithName:@"engine1"];
    // Runs the default Dart entrypoint with a default Flutter route.
    [self.flutterEngine run];
    // Used to connect plugins (only if you have plugins with iOS platform code).
    [GeneratedPluginRegistrant registerWithRegistry:self.flutterEngine];
}

- (void)showFlutter {
    FlutterEngine *flutterEngine =
        ((AppDelegate *)UIApplication.sharedApplication.delegate).flutterEngine;
    FlutterViewController *flutterViewController =
        [[FlutterViewController alloc] initWithEngine:flutterEngine nibName:nil bundle:nil];
    [self presentViewController:flutterViewController animated:YES completion:nil];
}

- (void)showFlutter2 {
    FlutterEngine *flutterEngine = self.flutterEngine;
    FlutterViewController *flutterViewController =
        [[FlutterViewController alloc] initWithEngine:flutterEngine nibName:nil bundle:nil];
    [self.navigationController pushViewController:flutterViewController animated:YES];
}

@end
