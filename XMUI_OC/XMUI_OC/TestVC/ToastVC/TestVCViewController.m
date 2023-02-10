//
//  TestVCViewController.m
//  XMUI_OC
//
//  Created by zhangmingwei6 on 2023/2/10.
//

#import "TestVCViewController.h"
#import "XMCustomNaviView.h"
@interface TestVCViewController ()

@end

@implementation TestVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    XMCustomNaviView *customV = [XMCustomNaviView getInstanceWithTitle:@"test"];
    __weak typeof(self) wSelf = self;
    customV.backBlock = ^{
        wSelf.backBlock();
    };
    [self.view addSubview:customV];
    
}

- (void)dealloc {
    NSLog(@"deallllll");
}

@end
