//
//  XMTool.h
//  XMUI_OC
//
//  Created by ext.zhangmingwei1 on 2022/6/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 封装通用的常见方法 - 「提升开发效率」
@interface XMTool : NSObject

/// 获取当前屏幕显示的VC
+ (nullable UIViewController *)getCurrentVC;

/// 移除掉navigationController栈中某一个VC
/// @param currentVC 需要移除的VC
+ (void)removeVC:(UIViewController *)currentVC;

/// 获取本地视频的缓存大小。---- 这里可以根据自己项目存储的位置选择修改。
+ (float)getLocalVideoCache_Bytes;

/// 根据 byte的大小，返回 多少GB /MB/KB/B
+ (NSString *)getFileSizeStringFromBytes_XM:(uint64_t)byteSize;

/// 清除网页WKWebView缓存 WKWebsiteDataStore
+ (void)clearWKWebViewCache;

/// 拨打电话
/// @param phoneString 电话号码字符串
+ (void)callPhoneAction:(NSString *)phoneString;

@end

NS_ASSUME_NONNULL_END
