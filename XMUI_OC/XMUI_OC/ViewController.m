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
    
    self.dataArr = [NSMutableArray arrayWithArray:@[@"大鱼吃小鱼",@"XMTool",@"XMToast",@"XMSortBarView",@"UILabel",@"UIButton",@"XMPopMenu",@"UITextField",@"XMEmptyView",@"XMNoDataEmptyView",@"XMTextView",@"UIView",@"UIImage",@"XMAlertView",@"XMSignView",@"ProgressView",@"XMCircleProgressView",@"XMTimer",@"XMImageLabelView",@"SPPageMenu",@"DemoCollectionVC",@"DemoRedPointVC",@"OrderListAlertView",@"XMDatePickerView"]];
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

    if ([vcString isEqualToString:@"大鱼吃小鱼"]) {
        vc = [NSClassFromString(@"BigEatSmallVC") new];
    }
    if ([vcString isEqualToString:@"XMToast"]) {
        vc = [self getViewControllerWith:@"DemoToastVC"];
    }
    if ([vcString isEqualToString:@"XMSortBarView"]) {
        vc = [self getViewControllerWith:@"DemoSortBarVC"];
    }
    if ([vcString isEqualToString:@"UILabel"]) {
        vc = [self getViewControllerWith:@"DemoLabelVC"];
    }
    if ([vcString isEqualToString:@"XMPopMenu"]) {
        vc = [self getViewControllerWith:@"DemoPopMenuVC"];
    }
    if ([vcString isEqualToString:@"UIButton"]) {
        vc = [self getViewControllerWith:@"DemoButtonVC"];
    }
    if ([vcString isEqualToString:@"UITextField"]) {
        vc = [self getViewControllerWith:@"DemoTextFieldVC"];
    }
    if ([vcString isEqualToString:@"XMEmptyView"]) {
        vc = [self getViewControllerWith:@"DemoEmptyVC"];
    }
    if ([vcString isEqualToString:@"XMTextView"]) {
        vc = [self getViewControllerWith:@"DemoTextViewVC"];
    }
    if ([vcString isEqualToString:@"UIView"]) {
        vc = [self getViewControllerWith:@"DemoViewVC"];
    }
    if ([vcString isEqualToString:@"UIImage"]) {
        vc = [self getViewControllerWith:@"DemoImageVC"];
    }
    if ([vcString isEqualToString:@"XMAlertView"]) {
        vc = [self getViewControllerWith:@"DemoAlertVC"];
    }
    if ([vcString isEqualToString:@"XMSignView"]) {
        vc = [self getViewControllerWith:@"DemoSignVC"];
    }
    if ([vcString isEqualToString:@"XMTool"]) {
        vc = [self getViewControllerWith:@"DemoToolVC"];
    }
    if ([vcString isEqualToString:@"ProgressView"]) {
        vc = [self getViewControllerWith:@"DemoUploadProgressVC"];
    }
    if ([vcString isEqualToString:@"XMCircleProgressView"]) {
        vc = [self getViewControllerWith:@"DemoCircleProgressVC"];
    }
    if ([vcString isEqualToString:@"XMTimer"]) {
        vc = [self getViewControllerWith:@"DemoTimerVC"];
    }
    if ([vcString isEqualToString:@"XMImageLabelView"]) {
        vc = [self getViewControllerWith:@"DemoImageLabelVC"];
    }
    if ([vcString isEqualToString:@"SPPageMenu"]) {
        vc = [self getViewControllerWith:@"DemoPageMenuVC"];
    }
    if ([vcString isEqualToString:@"DemoCollectionVC"]) {
        vc = [self getViewControllerWith:@"DemoCollectionVC"];
    }
    if ([vcString isEqualToString:@"DemoRedPointVC"]) {
        vc = [self getViewControllerWith:@"DemoRedPointVC"];
    }
    if ([vcString isEqualToString:@"XMNoDataEmptyView"]) {
        vc = [self getViewControllerWith:@"DemoNoDataEmptyVC"];
    }
    if ([vcString isEqualToString:@"OrderListAlertView"]) {
        vc = [self getViewControllerWith:@"DemoOrderListAlertViewVC"];
    }
    if ([vcString isEqualToString:@"XMDatePickerView"]) {
        vc = [self getViewControllerWith:@"DemoDatePickerVC"];
    }
    
    [[XMTabBarVC defaultManager] showBadgeMark:54 index:1];

    
    [self.navigationController pushViewController:vc animated:YES];
}

/// 根据字符串返回 class 类，省去了导入头文件了
- (UIViewController *)getViewControllerWith:(NSString *)classString {
    return [[NSClassFromString(classString) alloc] init];
}


@end
