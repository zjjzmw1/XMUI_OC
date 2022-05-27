//
//  JDBMCartViewController.m
//  JDBMCartModule
//
//  Created by zhengminghui on 2022/5/23.
//

#import "JDBMCartViewController.h"
#import "JDBMChangePageView.h"
#import "JDBMPrototypeViewController.h"
#import "JDBMPurchaseViewController.h"
//#import <WJOACommonModule/GlobalMacro.h>
//#import <WJOACommonModule/UIFont+JDFont.h>
//#import <JDTMasonry/Masonry.h>
//#import <JDTYYCategoriesModule/YYCategories.h>
#import "JDBMCartTopView.h"
#import "JDBMHoverCartViewController.h"
//#import "SCShopCartCustomConfigManager.h"

#import "XMCustomNaviView.h"
#import "XMSizeMacro.h"

@interface JDBMCartViewController ()<JDBMHoverPageViewControllerDelegate>
@property (assign, nonatomic) NSInteger cartType;
@property (nonatomic,strong) JDBMCartTopView *topView;
@property (assign, nonatomic) BOOL isFromTab;

// 常规采购车
@property (strong, nonatomic) JDBMPrototypeViewController *purchaseVC;
// 样机购物车
@property (strong, nonatomic) JDBMPrototypeViewController *prototypeVC;


@property (strong, nonatomic) JDBMChangePageView *changeView;
@property(nonatomic, strong) JDBMHoverPageViewController *hoverPageViewController;
@end

@implementation JDBMCartViewController

- (instancetype) initWithCartType:(NSInteger)cartType isFromTab:(BOOL)isFromTab {
    if (self = [super init]) {
        [self initDataWithType:cartType isFromTab:isFromTab];
    }
    return self;
}

- (instancetype)init {
    if (self = [self initWithCartType:1 isFromTab:NO]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self handleCallback];
//    [self.topView updateMsgCount:3];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)initDataWithType:(NSInteger)cartType isFromTab:(BOOL)isFromTab{

    self.isFromTab = isFromTab;
    self.cartType = 1;
}

- (void)initUI {
//    [self initNavView];
    [self initChangeView];
    [self initMainView];
}

//- (void)initNavView {
////    [self setUpNaviViewWithType:JDNavigationBarTypeNone];
//
//    XMCustomNaviView *naviV = [XMCustomNaviView getInstanceWithTitle:@"购物车导航栏"];
//    [naviV setBackBtnImage:nil title:nil];
//    [naviV setRightBtnImage:nil title:@"更多"];
//    [naviV setRightBlock:^{
//        NSLog(@"点击右边");
//    }];
//    naviV.lineImgV.hidden = NO;
//    [self.view addSubview:naviV];
//}

- (void)initMainView {
    
    /// 添加子控制器
    NSMutableArray *viewControllers = [NSMutableArray array];
    [viewControllers addObject:self.purchaseVC];
    [viewControllers addObject:self.prototypeVC];
     /// 添加分页控制器
    self.hoverPageViewController = [JDBMHoverPageViewController viewControllers:viewControllers headerView:self.topView pageTitleView:self.changeView];
    self.hoverPageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 44);
    self.hoverPageViewController.view.backgroundColor = [UIColor blueColor];
    self.hoverPageViewController.delegate = self;
    [self addChildViewController:self.hoverPageViewController];
    [self.view addSubview:self.hoverPageViewController.view];
    self.navigationController.navigationBarHidden = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(testAction:) name:@"kChangeNaviV" object:nil];
}

- (void)testAction:(NSNotification *)notifi {
//    if ([notifi.object intValue] == 0) {
//        self.topView.frame = CGRectMake(0, 0, kScreenWidth_XM, kNaviStatusBarH_XM);
//    } else {
//        self.topView.frame = CGRectMake(0, -kNaviStatusBarH_XM, kScreenWidth_XM, kNaviStatusBarH_XM);
//    }
}

- (void)initChangeView {
    
  //  [self.view addSubview:self.changeView];
    NSMutableArray * arrData = [NSMutableArray arrayWithCapacity:2];
    [arrData addObject:@{@"tag":@"1",@"title":@"常规商品"}];
    [arrData addObject:@{@"tag":@"2",@"title":@"样机商品"}];
    [self.changeView showViewWithData:arrData];
}

#pragma mark 处理函数

- (void)handleCallback {
    __weak typeof(self) weakSelf = self;
    self.changeView.tagCallBack = ^(NSInteger tag) {
        [weakSelf.hoverPageViewController moveToAtIndex:tag - 1 animated:YES];
    };
}

#pragma mark lazy loading

- (XMCustomNaviView *)topView {
    if (!_topView) {

        _topView = [XMCustomNaviView getInstanceWithTitle:@"地址栏"];
//        _topView.titleLbl.frame = CGRectMake(0, 0, kScreenWidth_XM, 144);
        _topView.backgroundColor = [UIColor grayColor];
//        [_topView setBackBtnImage:nil title:nil];
    }
    return _topView;
}

- (JDBMChangePageView *)changeView {
    if (!_changeView) {
        _changeView =  [[JDBMChangePageView alloc] initWithFrame:CGRectMake(0, kNaviStatusBarH_XM, kScreenWidth_XM, 44) data:nil];
        _changeView.backgroundColor  = [UIColor redColor];
    }
    return _changeView;
}


- (JDBMPrototypeViewController *)purchaseVC {
    if (!_purchaseVC) {
        NSDictionary *config = @{
            @"topOffset": @(0),
            @"isCustomNav": @(YES),
            @"isOpen": @(YES),
            @"topMargin": @(0),
            @"hiddenNav":@(YES)
        };
//        [[SCShopCartCustomConfigManager sharedManager] resetCurrentConfigData:config];
       
        _purchaseVC = [[JDBMPrototypeViewController alloc] init];
    }
    return _purchaseVC;
}

- (JDBMPrototypeViewController *)prototypeVC {
    if (!_prototypeVC) {
        _prototypeVC = [JDBMPrototypeViewController new];
    }
    return _prototypeVC;
}
#pragma mark - JDBMCartTopViewDelegate

// 点击返回按钮
- (void)clickedBackBtnInCartTopView:(JDBMCartTopView *)cartTopView {
    [self.navigationController popViewControllerAnimated:YES];
    
}
// 点击编辑按钮
- (void)clickedEditBtnInCartTopView:(JDBMCartTopView *)cartTopView {
    NSLog(@"clickedEditBtnInCartTopView");
    
}
// 点击更多按钮
- (void)clickedMoreBtnInCartTopView:(JDBMCartTopView *)cartTopView {
    NSLog(@"clickedMoreBtnInCartTopView");
}
// 迪点击地址
- (void)clickedAddressInCartTopView:(JDBMCartTopView *)cartTopView {
    NSLog(@"clickedAddressInCartTopView");
}
@end
