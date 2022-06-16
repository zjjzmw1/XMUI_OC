//
//  DemoRedPointVC.m
//  XMUI_OC
//
//  Created by ext.zhangmingwei1 on 2022/6/16.
//

#import "DemoRedPointVC.h"
#import "XMRedPointView.h"

@interface DemoRedPointVC ()

@end

@implementation DemoRedPointVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.customNaviView setTitleStr:@"小红点"];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    XMRedPointView *redPointV = [[XMRedPointView alloc] initWithFrame:CGRectMake(50, 100, 0, 0)];
    [self.view addSubview:redPointV];
    [redPointV reloadWithCount:2];
    
    XMRedPointView *redPointV2 = [[XMRedPointView alloc] initWithFrame:CGRectMake(50, 200, 0, 0)];
    [self.view addSubview:redPointV2];
    [redPointV2 reloadWithCount:0];
    
    XMRedPointView *redPointV3 = [[XMRedPointView alloc] initWithFrame:CGRectMake(150, 100, 0, 0)];
    [self.view addSubview:redPointV3];
    [redPointV3 reloadWithCount:34];

    XMRedPointView *redPointV4 = [[XMRedPointView alloc] initWithFrame:CGRectMake(150, 200, 0, 0)];
    [self.view addSubview:redPointV4];
    [redPointV4 reloadWithCount:233];
}


@end
