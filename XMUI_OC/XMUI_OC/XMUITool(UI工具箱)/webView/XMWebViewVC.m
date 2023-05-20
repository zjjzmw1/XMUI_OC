//
//  XMWebViewVC.m
//  XMUI_OC
//
//  Created by zhangmingwei on 2023/5/20.
//

#import "XMWebViewVC.h"
#import "XMWebViewManager.h"

@interface XMWebViewVC ()<WKNavigationDelegate, WKUIDelegate>

@property (nonatomic, strong) WKWebView *webView;
/// 进度条
@property (weak, nonatomic) CALayer *progresslayer;

@end

@implementation XMWebViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.webView = [[XMWebViewManager defalutManager] getWebView:self.urlString needCache:self.needCacheFlag];
    [self.view addSubview:self.webView];
    [self configWebView];
    [self.webView reload];
    __weak typeof(self) wSelf = self;
    // 右边刷新按钮
    [self.customNaviView setRightBtnImage:nil title:@"回首页"];
    [self.customNaviView setRightBlock:^{
        WKBackForwardListItem *listItem = [wSelf.webView backForwardList].backList.firstObject;
        if (listItem) {
            [wSelf.webView goToBackForwardListItem:listItem];
        } else {
            [wSelf.webView goBack];
        }
    }];
}

//移除监听
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    // 不移除会引起崩溃
    if ([self.webView observationInfo]) {
        [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
        [self.webView removeObserver:self forKeyPath:@"title"];
    }
}
// 配置网页
- (void)configWebView {
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    // 添加监听
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [self.webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    //进度条
    UIView *progress = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth_XM, 3)];
    progress.backgroundColor = [UIColor clearColor];
    [self.webView addSubview:progress];
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, 0, 0, 3);
    layer.backgroundColor = [UIColor blueColor].CGColor;
    [progress.layer addSublayer:layer];
    self.progresslayer = layer;

}

#pragma mark - 网页加载完成的回调
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    // NSURLRequestReturnCacheDataElseLoad 优先从本地拿数据，但是如果没有本地cache，则请求源数据
    NSLog(@"当前url===%@",webView.URL.absoluteString);
}

#pragma mark - 进度条、title等监听
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"estimatedProgress"]) { // 进度条监听
        if ([change[@"new"] floatValue] < [change[@"old"] floatValue]) { // 防止到退
            return;
        }
        self.progresslayer.opacity = 1;
        self.progresslayer.frame = CGRectMake(0, 0, kScreenWidth_XM * [change[@"new"] floatValue], 3);
        if ([change[@"new"] floatValue] == 1) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progresslayer.opacity = 0;
            });
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progresslayer.frame = CGRectMake(0, 0, 0, 3);
            });
        }
    } else if ([keyPath isEqualToString:@"title"]) { // 标题监听
        if (object == self.webView) {
            if (self.webView.title.length > 0) {
                [self.customNaviView setTitleStr:self.webView.title];
            }
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

/// 清除上个页面的缓存 - 防止展示上个网页的内容
//- (void)clearAction:(WKWebView *)webV {
//    [webV evaluateJavaScript:@"window.document.body.remove();" completionHandler:^(id _Nullable, NSError * _Nullable error) {
//
//    }];
//}

@end
