//
//  TestWebListVC.m
//  XMUI_OC
//
//  Created by zhangmingwei on 2023/5/20.
//

#import "TestWebListVC.h"

#import "UITableView+XMTool.h"
#import "XMSizeMacro.h"

#import "XMTabBarVC.h"
#import "XMWebViewVC.h"

@interface TestWebListVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView       *tableView;
@property (nonatomic, strong) NSMutableArray    *dataArr;

@end

@implementation TestWebListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self.customNaviView setTitleStr:@"网站列表"];
        
    self.dataArr = [NSMutableArray arrayWithArray:@[@"腾讯新闻",@"微博热搜",@"梨视频",@"知乎热榜",@"百度翻译",@"百度搜索",@"汇率"]];
    self.tableView = [UITableView instanceWithType:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.frame = CGRectMake(0, kNaviStatusBarH_XM, kScreenWidth_XM, kScreenHeight_XM - kNaviStatusBarH_XM - kTabBarH_XM);
    [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSString *titleString;
    if (self.dataArr.count > indexPath.row) {
        titleString = self.dataArr[indexPath.row];
    }
    XMWebViewVC *webVC = [XMWebViewVC new];
    webVC.needCacheFlag = YES;
    if ([titleString containsString:@"腾讯新闻"]) {
        webVC.urlString = @"https://xw.qq.com/?f=c_news#news";
    }
    if ([titleString containsString:@"微博热搜"]) {
        webVC.urlString = @"https://s.weibo.com/top/summary?cate=realtimehot";
    }
    if ([titleString containsString:@"梨视频"]) {
        webVC.urlString = @"https://www.pearvideo.com/popular";
    }
    if ([titleString containsString:@"知乎"]) {
        webVC.urlString = @"https://www.zhihu.com/billboard";
    }
    if ([titleString containsString:@"百度翻译"]) {
        webVC.urlString = @"https://fanyi.baidu.com";
    }
    if ([titleString containsString:@"百度搜索"]) {
        webVC.urlString = @"https://m.baidu.com";
    }
    if ([titleString containsString:@"汇率"]) {
        webVC.urlString = @"https://m.baidu.com/s?word=人民币汇率";
    }

    [self.navigationController pushViewController:webVC animated:YES];
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


/// 根据字符串返回 class 类，省去了导入头文件了
- (UIViewController *)getViewControllerWith:(NSString *)classString {
    return [[NSClassFromString(classString) alloc] init];
}


@end

