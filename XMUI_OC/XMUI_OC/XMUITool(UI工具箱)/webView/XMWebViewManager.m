//
//  XMWebViewManager.m
//  XMUI_OC
//
//  Created by zhangmingwei on 2023/5/20.
//
// NSURLRequestUseProtocolCachePolicy：默认策略，具体的缓存逻辑和协议的声明有关，如果协议没有声明，不需要每次重新验证cache。    如果请求协议头为no-cache，则表现为直接从后台请求数据


#import "XMWebViewManager.h"

@interface XMWebViewManager()

/// 预加载的数组
@property (nonatomic, strong) NSMutableArray    *preloadArray;

@end

@implementation XMWebViewManager

+ (instancetype)defalutManager {
    static XMWebViewManager *webviewManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        webviewManager = [[XMWebViewManager alloc] init];
        webviewManager.preloadArray = [NSMutableArray array];
    });
    return webviewManager;
}

#pragma mark - 获取webView (优先用缓存、否则创建一个新的)
/// 根据url获取webview - 优先用缓存、否则创建一个新的
/// - Parameters:
///   - urlString: 网址
///   - needCache: 是否需要缓存 （缓存后，下次秒开网页）
- (WKWebView *)getWebView:(NSString *)urlString needCache:(BOOL)needCache {
    WKWebView *webV = nil;
    for (NSDictionary *dict in self.preloadArray) {
        if ([dict[@"url"] isEqualToString:urlString]) {
            webV = dict[@"webview"];
        }
    }
    if (!webV) { // 未获取到缓存，就创建新的
        webV = [self createWebViewWithUrlString:urlString needCache:needCache];
    }
    if (webV.URL == nil) {
        [self addRequestWithUrlString:urlString needCache:needCache webView:webV];
    }
    return webV;
}

/// 初始化网页
- (WKWebView *)createWebViewWithUrlString:(NSString *)urlString needCache:(BOOL)needCache {
    if (!urlString || urlString.length <= 0) {
        return nil;
    }
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    WKWebView *webV = [[WKWebView alloc] initWithFrame:CGRectMake(0, kNaviStatusBarH_XM, kScreenWidth_XM, kScreenHeight_XM - kNaviStatusBarH_XM) configuration:config];
    [self addRequestWithUrlString:urlString needCache:needCache webView:webV];
    return webV;
}

/// 添加网页请求
- (void)addRequestWithUrlString:(NSString *)urlString needCache:(BOOL)needCache webView:(WKWebView *)webV {
    NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30];
    [webV loadRequest:req];
    if (needCache) {
        NSMutableDictionary *urlWebViewDict = [NSMutableDictionary dictionary];
        [urlWebViewDict setValue:webV forKey:@"webview"];
        [urlWebViewDict setValue:urlString forKey:@"url"];
        [self addCacheWithDict:urlWebViewDict];
    }
}

#pragma mark - 批量预加载网页方法
- (void)preloadWebViewWithUrlArray:(NSArray *)urlArray {
    for (NSString *urlString in urlArray) {
        [self createWebViewWithUrlString:urlString needCache:YES];
    }
}

/// 添加缓存
/// - Parameter dict: 包含URL和webView的字典
- (void)addCacheWithDict:(NSDictionary *)dict {
    BOOL isExistFlag = NO;
    for (int i = 0; i < self.preloadArray.count; i++) {
        NSDictionary *urlwebDict = self.preloadArray[i];
        if ([urlwebDict[@"url"] isEqualToString:dict[@"url"]]) {
            isExistFlag = YES;
            [self.preloadArray removeObjectAtIndex:i];
            [self.preloadArray addObject:dict]; // 把新添加的放到最后
        }
    }
    if (!isExistFlag) {
        // 最多添加10个缓存的webview
        if (self.preloadArray.count < 10) {
            [self.preloadArray addObject:dict];
        } else {
            [self.preloadArray replaceObjectAtIndex:0 withObject:dict];
        }
    }
}

@end
