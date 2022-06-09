//
//  ViewController.m
//  XMUI_OC
//
//  Created by ext.zhangmingwei1 on 2022/5/26.
//

#import "ViewController.h"
#import "UITableView+XMTool.h"
#import "XMSizeMacro.h"
#import "XMToast.h"

#import "XMTabBarVC.h"
#import "DemoToastVC.h"
#import "DemoLabelVC.h"
#import "DemoPopMenuVC.h"
#import "DemoButtonVC.h"
#import "DemoTextFieldVC.h"
#import "DemoEmptyVC.h"
#import "DemoTextViewVC.h"
#import "DemoViewVC.h"
#import "DemoImageVC.h"
#import "DemoAlertVC.h"
#import "DemoSignVC.h"
#import "DemoToolVC.h"
#import "DemoUploadProgressVC.h"
#import "DemoTimerVC.h"
#import "DemoCircleProgressVC.h"
#import "DemoImageLabelVC.h"
#import "DemoSortBarVC.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView       *tableView;
@property (nonatomic, strong) NSMutableArray    *dataArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self.customNaviView setTitleStr:@"自定义导航栏"];
    
    [self.customNaviView setBackBtnImage:nil title:@"显示"];
    [self.customNaviView setRightBtnImage:nil title:@"隐藏"];
    [self.customNaviView setBackBlock:^{
        [[XMTabBarVC defaultManager] showPointMarkIndex:2];
    }];
    [self.customNaviView setRightBlock:^{
        [[XMTabBarVC defaultManager] hideMarkIndex:2];
        [[XMTabBarVC defaultManager] hideMarkIndex:1];
    }];
    
    self.dataArr = [NSMutableArray arrayWithArray:@[@"XMTool",@"XMToast",@"XMSortBarView",@"UILabel",@"UIButton",@"XMPopMenu",@"UITextField",@"XMEmptyView",@"XMTextView",@"UIView",@"UIImage",@"XMAlertView",@"XMSignView",@"ProgressView",@"XMCircleProgressView",@"XMTimer",@"XMImageLabelView"]];
    self.tableView = [UITableView instanceWithType:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.frame = CGRectMake(0, kNaviStatusBarH_XM, kScreenWidth_XM, kScreenHeight_XM - kNaviStatusBarH_XM - kTabBarH_XM);
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    if (self.dataArr.count > indexPath.row) {
        cell.textLabel.text = self.dataArr[indexPath.row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    UIViewController *vc;
    NSString *vcString;
    if (self.dataArr.count > indexPath.row) {
        vcString = self.dataArr[indexPath.row];
    }

    if ([vcString isEqualToString:@"XMToast"]) {
        vc = [DemoToastVC new];
    }
    if ([vcString isEqualToString:@"XMSortBarView"]) {
        vc = [DemoSortBarVC new];
    }
    if ([vcString isEqualToString:@"UILabel"]) {
        vc = [DemoLabelVC new];
    }
    if ([vcString isEqualToString:@"XMPopMenu"]) {
        vc = [DemoPopMenuVC new];
    }
    if ([vcString isEqualToString:@"UIButton"]) {
        vc = [DemoButtonVC new];
    }
    if ([vcString isEqualToString:@"UITextField"]) {
        vc = [DemoTextFieldVC new];
    }
    if ([vcString isEqualToString:@"XMEmptyView"]) {
        vc = [DemoEmptyVC new];
    }
    if ([vcString isEqualToString:@"XMTextView"]) {
        vc = [DemoTextViewVC new];
    }
    if ([vcString isEqualToString:@"UIView"]) {
        vc = [DemoViewVC new];
    }
    if ([vcString isEqualToString:@"UIImage"]) {
        vc = [DemoImageVC new];
    }
    if ([vcString isEqualToString:@"XMAlertView"]) {
        vc = [DemoAlertVC new];
    }
    if ([vcString isEqualToString:@"XMSignView"]) {
        vc = [DemoSignVC new];
    }
    if ([vcString isEqualToString:@"XMTool"]) {
        vc = [DemoToolVC new];
    }
    if ([vcString isEqualToString:@"ProgressView"]) {
        vc = [DemoUploadProgressVC new];
    }
    if ([vcString isEqualToString:@"XMCircleProgressView"]) {
        vc = [DemoCircleProgressVC new];
    }
    if ([vcString isEqualToString:@"XMTimer"]) {
        vc = [DemoTimerVC new];
    }
    if ([vcString isEqualToString:@"XMImageLabelView"]) {
        vc = [DemoImageLabelVC new];
    }
    
    [[XMTabBarVC defaultManager] showBadgeMark:54 index:1];

    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
