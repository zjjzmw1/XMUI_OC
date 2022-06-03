//
//  DemoToolVC.m
//  XMUI_OC
//
//  Created by ext.zhangmingwei1 on 2022/6/2.
//

#import "DemoToolVC.h"
#import "XMTool.h"
#import "XMToast.h"
#import "XMToolMacro.h"
#import "XMTimer.h"

@interface DemoToolVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView       *tableView;
@property (nonatomic, strong) NSMutableArray    *dataArr;

@end

@implementation DemoToolVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.customNaviView setTitleStr:@"DemoToolVC"];
    
    self.dataArr = [NSMutableArray arrayWithArray:@[@"关闭全局定时器",@"获取当前VC",@"移除某一个VC",@"拨打电话",@"当前版本号",@"当前构建版本",@"用户是否在中国内地",@"XMLocationTrans -「火星、GPS、地球」转换",@"runtime-NSObect/NSArray/NSDictionary保护"]];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.tableView registerClass:[UITableViewCell self] forCellReuseIdentifier:@"UITableViewCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }

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
        if ([cell.textLabel.text hasPrefix:@"当前版本号"]) {
            cell.textLabel.text = [NSString stringWithFormat:@"当前版本号：%@",kCurrentVersionStr_XM];
        }
        if ([cell.textLabel.text hasPrefix:@"当前构建版本"]) {
            cell.textLabel.text = [NSString stringWithFormat:@"当前构建版本：%@",kCurrentBuidVersionStr_XM];
        }
        if ([cell.textLabel.text hasPrefix:@"用户是否在中国内地"]) {
            cell.textLabel.text = [NSString stringWithFormat:@"用户是否在中国内地：%d",kArea_In_China_mainland_XM];
        }
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
    if ([vcString isEqualToString:@"关闭全局定时器"]) {
        [[XMTimer defaultManager] xm_cancelTimerWithName:kGlobalTimerName];
    }
    if ([vcString isEqualToString:@"获取当前VC"]) {
        NSString *lastStr = NSStringFromClass([XMTool getCurrentVC].class);
         [XMToast showTextToCenter:lastStr];
    }
    if ([vcString isEqualToString:@"移除某一个VC"]) {
        // 根据需求，选一个vc
        UIViewController *tempVC = [XMTool getCurrentVC].navigationController.viewControllers.lastObject;
        [XMTool removeVC:tempVC];
    }
    if ([vcString isEqualToString:@"拨打电话"]) {
        [XMTool callPhoneAction:@"18010125752"];
    }
    
}




@end
