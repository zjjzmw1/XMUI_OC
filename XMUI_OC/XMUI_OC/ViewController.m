//
//  ViewController.m
//  XMUI_OC
//
//  Created by ext.zhangmingwei1 on 2022/5/26.
//

#import "ViewController.h"
#import "UITableView+XMTool.h"
#import "XMSizeMacro.h"
#import "XMCustomNaviView.h"
#import "XMToast.h"
#import "ToastVC.h"     // 吐司demo
#import "JDBMCartViewController.h"
#import "DemoLabelVC.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView       *tableView;
@property (nonatomic, strong) NSMutableArray    *dataArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Home";
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self.navigationController setNavigationBarHidden:YES];
    XMCustomNaviView *naviV = [XMCustomNaviView getInstanceWithTitle:@"自定义导航栏"];
    [naviV setBackBtnImage:nil title:nil];
    [naviV setRightBtnImage:nil title:@"更多"];
    [naviV setRightBlock:^{
        NSLog(@"点击右边");
        [XMToast showText:@"打了个科技" positionType:XMToastPositionTypeCenter];
    }];
    naviV.lineImgV.hidden = NO;
    [self.view addSubview:naviV];
    
    self.dataArr = [NSMutableArray arrayWithArray:@[@"XMToast",@"UILabel",@"UIButton",@"购物车"]];
    self.tableView = [UITableView instanceWithType:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.frame = CGRectMake(0, kNaviStatusBarH_XM, kScreenWidth_XM, kScreenHeight_XM - kNaviStatusBarH_XM);
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
    
    if (indexPath.row == 0) {
        vc = [ToastVC new];
    }
    if (indexPath.row == 1) {
        vc = [DemoLabelVC new];
    }
    if (indexPath.row == 3) {
        vc = [JDBMCartViewController new];
    }
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
