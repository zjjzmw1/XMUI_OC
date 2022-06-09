//
//  DemoSortBarVC.m
//  XMUI_OC
//
//  Created by ext.zhangmingwei1 on 2022/6/9.
//

#import "DemoSortBarVC.h"
#import "XMSortBarView.h"

@interface DemoSortBarVC ()

@property (nonatomic, strong) XMSortBarView *sortBarView;
@property (nonatomic, strong) UIButton  *testBtn;

@end

@implementation DemoSortBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.customNaviView setTitleStr:@"XMSortBarView"];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    self.testBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.testBtn.frame = CGRectMake(50, 120, 200, 60);
    [self.testBtn setTitle:@"重置筛选" forState:UIControlStateNormal];
    [self.testBtn addTarget:self action:@selector(resetPickAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.testBtn];
    
    
    self.sortBarView = [[XMSortBarView alloc] initWithFrame:CGRectMake(0, 200, [UIScreen mainScreen].bounds.size.width, 44)];
    [self.view addSubview:self.sortBarView];
    // 点击事件
    self.sortBarView.clickButtonBlock = ^(XMSortBarClickType type) {
        if (type == XMSortBarClickType_mutiple) { // 综合
            NSLog(@"综合");
        }
        if (type == XMSortBarClickType_sale) { // 销量
            NSLog(@"销量");
        }
        if (type == XMSortBarClickType_priceAsc) { // 价格升序
            NSLog(@"价格升序");
        }
        if (type == XMSortBarClickType_priceDesc) { // 价格降序
            NSLog(@"价格降序");
        }
        if (type == XMSortBarClickType_newest) { // 最新
            NSLog(@"最新");
        }
        if (type == XMSortBarClickType_sort1) { // 排列方式1
            NSLog(@"排列方式1");
        }
        if (type == XMSortBarClickType_sort2) { // 排列方式2
            NSLog(@"排列方式2");
        }
        if (type == XMSortBarClickType_pick) { // 筛选
            NSLog(@"筛选");
        }
    };
}

- (void)resetPickAction {
    NSLog(@"重置筛选");
    [self.sortBarView resetPickButton];
}

@end
