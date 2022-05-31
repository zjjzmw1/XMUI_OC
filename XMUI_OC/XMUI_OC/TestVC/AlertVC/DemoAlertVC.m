//
//  DemoAlertVC.m
//  XMUI_OC
//
//  Created by ext.zhangmingwei1 on 2022/5/30.
//

#import "DemoAlertVC.h"
#import "XMAlertView.h"
#import "UITableView+XMTool.h"
#import "XMToast.h"

@interface DemoAlertVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView       *tableView;
@property (nonatomic, strong) NSMutableArray    *dataArr;

@end

@implementation DemoAlertVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.customNaviView setTitleStr:@"XMAlertView"];
    
    self.dataArr = [NSMutableArray arrayWithArray:@[@"标题、内容、2按钮",@"标题、内容、1按钮",@"标题、1按钮",@"内容、1按钮",@"标题、长内容、1按钮",@"长内容、2按钮"]];
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
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.dataArr.count > indexPath.row) {
        cell.textLabel.text = self.dataArr[indexPath.row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    XMAlertView *alerV;
    if (indexPath.row == 0) {
        alerV = [XMAlertView initWithTitle:@"确认要删除这 2 种商品吗？" contentStr:@"删除后将从你的记录里消失，无法找回打翻了；攻击力卡的设计规范；立刻打火锅鸡了；但是发" cancelStr:@"取消" submitStr:@"确定"];
    }
    if (indexPath.row == 1) {
        alerV = [XMAlertView initWithTitle:@"确认要删除这 2 种商品吗？" contentStr:@"删除后将从你的记录里消失，无法找回打翻了；攻击力卡的设计规范；立刻打火锅鸡了；但是发" cancelStr:nil submitStr:@"确定"];
    }
    if (indexPath.row == 2) {
        alerV = [XMAlertView initWithTitle:@"确认要删除这 2 种商品吗？" contentStr:nil cancelStr:nil submitStr:@"确定"];
    }
    if (indexPath.row == 3) {
        alerV = [XMAlertView initWithTitle:nil contentStr:@"删除后将从你的记录里消失，无法找回打翻了；攻击力卡的设计规范；立刻打火锅鸡了；但是发" cancelStr:nil submitStr:@"确定"];
    }
    if (indexPath.row == 4) {
        alerV = [XMAlertView initWithTitle:@"确认要删除这 2 种商品吗？" contentStr:@"删除后将从你的记录里消失，无法找回打翻了；攻击力卡的设计规范；立刻打火锅鸡了；但是发删除后将从你的记录里消失，无法找回打翻了；攻击力卡的设计规范；立刻打火锅鸡删除后将从你的记录里消失，无法找回打翻了；攻击力卡的设计规范；立刻打火锅鸡删除后将从你的记录里消失，无法找回打翻了；攻击力卡的设计规范；立刻打火锅鸡删除后将从你的记录里消失，无法找回打翻了；攻击力卡的设计规范；立刻打火锅鸡删除后将从你的记录里消失，无法找回打翻了；攻击力卡的设计规范；立刻打火锅鸡删除后将从你的记录里消失，无法找回打翻了；攻击力卡的设计规范；立刻打火锅鸡了；但是发删除后将从你的记录里消失，无法找回打翻了；攻击力卡的设计规范；立刻打火锅鸡删除后将从你的记录里消失，无法找回打翻了；攻击力卡的设计规范；立刻打火锅鸡删除后将从你的记录里消失，无法找回打翻了；攻击力卡的设计规范；立刻打火锅鸡删除后将从你的记录里消失，无法找回打翻了；攻击力卡的设计规范；立刻打火锅鸡删除后将从你的记录里消失，无法找回打翻了；攻击力卡的设计规范；立刻打火锅鸡删除后将从你的记录里消失，无法找回打翻了；攻击力卡的设计规范；立刻打火锅鸡删除后将从你的记录里消失，无法找回打翻了；攻击力卡的设计规范；立刻打火锅鸡删除后将从你的记录里消失，无法找回打翻了；攻击力卡的设计规范；立刻打火锅鸡删除后将从你的记录里消失，无法找回打翻了；攻击力卡的设计规范；立刻打火锅鸡删除后将从你的记录里消失，无法找回打翻了；攻击力卡的设计规范；立刻打火锅鸡删除后将从你的记录里消失，无法找回打翻了；攻击力卡的设计规范；立刻打火锅鸡删除后将从你的记录里消失，无法找回打翻了；攻击力卡的设计规范；立刻打火锅鸡删除后将从你的记录里消失，无法找回打翻了；攻击力卡的设计规范；立刻打火锅鸡删除后将从你的记录里消失，无法找回打翻了；攻击力卡的设计规范；立刻打火锅鸡删除后将从你的记录里消失，无法找回打翻了；攻击力卡的设计规范；立刻打火锅鸡后将从你的记录里消失，无法找回打翻了；攻击力卡的设计规范；立刻打火锅鸡删除后将从你的记录里消失，无法找回打翻了；攻击力卡的设计规范；立刻打火锅鸡删除后将从你的记录里消失，无法找回打翻了；攻击力卡的设计规范；立刻打火锅鸡删除后将从你的记录里消失，无法找回打翻了；攻击力卡的设计规范；立刻打火锅鸡删除后将从你的记录里消失，无法找回打翻了；攻击力卡的设计规范；立刻打火锅鸡删除后将从你的记录里消失，无法找回打翻了；攻击力卡的设计规范；立刻打火锅鸡删除后将从你的记录里消失，无法找回打翻了；攻击力卡的设计规范；立刻打火锅鸡删除后将从你的记录里消失，无法找回打翻了；攻击力卡的设计规范；立刻打火锅鸡删除后将从你的记录里消失，无法找回打翻了；攻击力卡的设计规范；立刻打火锅鸡删除后将从你的记录里消失，无法找回打翻了；攻击力卡的设计规范；立刻打火锅鸡" cancelStr:nil submitStr:@"确定"];
    }
    if (indexPath.row == 5) {
        alerV = [XMAlertView initWithTitle:nil contentStr:@"删除后将从你的记录里消失，无法找回打翻了；攻击力卡的设计规范；立刻打火锅鸡了；但是发删除后将从你的记录里消失，无法找回打翻了；攻击力卡的设计规范；立刻打火锅鸡删除后将从你的记录里消失，无法找回打翻了；攻击力卡的设计规范；立刻打火锅鸡删除后将从你的记录里消失，无法找回打翻了；攻击力卡的设计规范；立刻打火锅鸡删除后将从你的记录里消失，无法找回打翻了；攻击力卡的设计规范；立刻打火锅鸡删除后将从你的记录里消失，无法找回打翻了；攻击力卡的设计规范；立刻打火锅鸡删除后将从你的记录里消失，无法找回打翻了；攻击力卡的设计规范；立刻打火锅鸡删除后将从你的记录里消失，无法找回打翻了；攻击力卡的设计规范；立刻打火锅鸡删除后将从你的记录里消失，无法找回打翻了；攻击力卡的设计规范；立刻打火锅鸡删除后将从你的记录里消失，无法找回打翻了；攻击力卡的设计规范；立刻打火锅鸡删除后将从你的记录里消失，无法找回打翻了；攻击力卡的设计规范；立刻打火锅鸡删除后将从你的记录里消失，无法找回打翻后将从你的记录里消失，无法找回打翻了；攻击力卡的设计规范；立刻打火锅鸡了；但是发删除后将从你的记录里消失，无法找回打翻了；攻击力卡的设计规范；立刻打火锅鸡删除后将从你的记录里消失，无法找回打翻了；攻击力卡的设计规范；立刻打火锅鸡删除后将从你的记录里消失，无法找回打翻了；攻击力卡的设计规范；立刻打火锅鸡删除后将从你的记录里消失，无法找回打翻了；攻击力卡的设计规范；立刻打火锅鸡删除后将从你的记录里消失，无法找回打翻了；攻击力卡的设计规范；立刻打火锅鸡删除后将从你的记录里消失，无法找回打翻了；攻击力卡的设计规范；立刻打火锅鸡删除后将从你的记录里消失，无法找回打翻了；攻击力卡的设计规范；立刻打火锅鸡删除后将从你的记录里消失，无法找回打翻了；攻击力卡的设计规范；立刻打火锅鸡删除后将从你的记录里消失，无法找回打翻了；攻击力卡的设计规范；立刻打火锅鸡删除后将从你的记录里消失，无法找回打翻了；攻击力卡的设计规范；立刻打火锅鸡删除后将从你的记录里消失，无法找回打翻了；攻击力卡的设计规范；立刻打火锅鸡删除后将从你的记录里消失，无法找回打翻了；攻击力卡的设计规范；立刻打火锅鸡删除后将从你的记录里消失，无法找回打翻了；攻击力卡的设计规范；立刻打火锅鸡删除后将从你的记录里消失，无法找回打翻了；攻击力卡的设计规范；立刻打火锅鸡删除后将从你的记录里消失，无法找回打翻了；攻击力卡的设计规范；立刻打火锅鸡了；攻击力卡的设计规范；立刻打火锅鸡删除后将从你的记录里消失，无法找回打翻了；攻击力卡的设计规范；立刻打火锅鸡删除后将从你的记录里消失，无法找回打翻了；攻击力卡的设计规范；立刻打火锅鸡删除后将从你的记录里消失，无法找回打翻了；攻击力卡的设计规范；立刻打火锅鸡删除后将从你的记录里消失，无法找回打翻了；攻击力卡的设计规范；立刻打火锅鸡" cancelStr:@"取消" submitStr:@"确定"];
    }
    
    [alerV setClickCancelBlock:^{
        [XMToast showText:@"点击取消" positionType:XMToastPositionTypeCenter];
    }];
    
    [alerV setClickSubmitBlock:^{
        [XMToast showText:@"点击确定" positionType:XMToastPositionTypeCenter];
    }];
    
    [alerV showAction];

}

@end
