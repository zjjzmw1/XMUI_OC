//
//  ToastVC.m
//  XMUI_OC
//
//  Created by ext.zhangmingwei1 on 2022/5/26.
//

#import "DemoToastVC.h"
#import "XMCustomNaviView.h"
#import "UITableView+XMTool.h"
#import "XMSizeMacro.h"

#import "XMToast.h"

@interface DemoToastVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView       *tableView;
@property (nonatomic, strong) NSMutableArray    *dataArr;

@end

@implementation DemoToastVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self.navigationController setNavigationBarHidden:YES];
    XMCustomNaviView *naviV = [XMCustomNaviView getInstanceWithTitle:@"Toast"];
    naviV.lineImgV.hidden = NO;
    [self.view addSubview:naviV];
    
    self.dataArr = [NSMutableArray arrayWithArray:@[@"S 短文案",@"S 合理的中等长度",@" S 不合理的长文案长文案长文案长文案长文案长文案长文案长文案长文案长文案长文案长文案长文案",@"短文案",@"合理的中等长度",@"不合理的长文案长文案长文案长文案长文案长文案长文案长文案长文案长文案长文案长文案长文案"]];
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
    
    if (self.dataArr.count > indexPath.row) {
        NSString *str = self.dataArr[indexPath.row];
        if (indexPath.row < 3) {
            [XMToast showText:str positionType:XMToastPositionTypeCenter];
        } else {
            [XMToast showText:str positionType:XMToastPositionTypeBottom];
        }
    }
}

@end
