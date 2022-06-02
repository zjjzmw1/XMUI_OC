//
//  DemoToolVC.m
//  XMUI_OC
//
//  Created by ext.zhangmingwei1 on 2022/6/2.
//

#import "DemoToolVC.h"
#import "XMTool.h"
#import "XMToast.h"

@interface DemoToolVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView       *tableView;
@property (nonatomic, strong) NSMutableArray    *dataArr;

@end

@implementation DemoToolVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.customNaviView setTitleStr:@"DemoToolVC"];
    
    self.dataArr = [NSMutableArray arrayWithArray:@[@"获取手机剩余内存",@"获取当前VC",@"移除某一个VC"]];
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
    if ([vcString isEqualToString:@"获取手机剩余内存"]) {
       NSString *lastStr = [XMTool getFileSizeStringFromBytes_XM:[XMTool getMyPhoneFree_Bytes]];
        [XMToast showTextToCenter:lastStr];
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
    
}




@end
