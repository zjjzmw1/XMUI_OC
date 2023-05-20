//
//  XMWebViewManager.h
//  XMUI_OC
//
//  Created by zhangmingwei on 2023/5/20.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMWebViewManager : NSObject

+ (instancetype)defalutManager;

/// 批量预加载网页
/// - Parameter urlArray: 需要预加载的网址数组
- (void)preloadWebViewWithUrlArray:(NSArray *)urlArray;

/// 根据url获取webview - 优先用缓存、否则创建一个新的
/// - Parameters:
///   - urlString: 网址
///   - needCache: 是否需要缓存 （缓存后，下次秒开网页）
- (WKWebView *)getWebView:(NSString *)urlString needCache:(BOOL)needCache;

@end

NS_ASSUME_NONNULL_END
