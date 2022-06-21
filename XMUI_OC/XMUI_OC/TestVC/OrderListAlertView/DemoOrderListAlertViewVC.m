//
//  DemoOrderListAlertViewVC.m
//  XMUI_OC
//
//  Created by ext.zhangmingwei1 on 2022/6/20.
//

#import "DemoOrderListAlertViewVC.h"
#import "OrderListAlertView.h"

@interface DemoOrderListAlertViewVC ()

@property (nonatomic, assign) NSInteger     currentOrderStatusRow;
@property (nonatomic, strong) NSArray       *dataArr;

@end

@implementation DemoOrderListAlertViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.customNaviView setTitleStr:@"OrderListAlertView"];
    self.dataArr = @[@"全部",@"已完成",@"未完成",@"已过期"];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    OrderListAlertView *alertV = [[OrderListAlertView alloc] init];
    alertV.currentSelectRow = self.currentOrderStatusRow;
    alertV.dataArray = self.dataArr;
    [alertV showAction];
    __weak typeof(self) weakSelf = self;
    [alertV setClickSubmitBlock:^(NSInteger row, NSString *titleStr) {
        weakSelf.currentOrderStatusRow = row;
        NSLog(@"选中了====%ld,%@",(long)row,titleStr);
    }];

}

@end
