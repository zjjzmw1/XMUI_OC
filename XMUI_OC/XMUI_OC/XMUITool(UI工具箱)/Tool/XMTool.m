//
//  XMTool.m
//  XMUI_OC
//
//  Created by ext.zhangmingwei1 on 2022/6/2.
//
#import "XMTool.h"
#import <WebKit/WebKit.h>

@implementation XMTool

#pragma mark - 获取当前屏幕显示的VC

/// 获取当前屏幕显示的VC
+ (nullable UIViewController *)getCurrentVC {
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *currentVC = [XMTool getCurrentVCFrom:rootViewController];
    return currentVC;
}

+ (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC {
    UIViewController *currentVC;
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        rootVC = [rootVC presentedViewController];
    }
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        currentVC = [XMTool getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
    } else if ([rootVC isKindOfClass:[UINavigationController class]]) {
        // 根视图为UINavigationController
        currentVC = [XMTool getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
    } else {
        // 根视图为非导航类
        currentVC = rootVC;
    }
    return currentVC;
}

#pragma mark - 移除掉navigationController栈中某一个VC

/// 移除掉navigationController栈中某一个VC
/// @param currentVC 需要移除的VC
+ (void)removeVC:(UIViewController *)currentVC {
    NSMutableArray *naviVCsArr = [[NSMutableArray alloc]initWithArray:[XMTool getCurrentVC].navigationController.viewControllers];
    for (UIViewController *vc in naviVCsArr) {
        if ([vc isKindOfClass:[currentVC class]]) {
            [naviVCsArr removeObject:vc];
            break;
        }
    }
    [XMTool getCurrentVC].navigationController.viewControllers = naviVCsArr;
}

/// 获取本地视频的缓存大小。---- 这里可以根据自己项目存储的位置选择修改。
+ (float)getLocalVideoCache_Bytes {
    // paths.lastObject 是总目录/var/mobile/Containers/Data/Application/03BE2564-B162-436F-9634-6DB75BAEDCFD/Documents
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *lastPath = [NSString stringWithFormat:@"%@/YCDownload/video",[paths lastObject]];
    return [XMTool getFolderSizeAtPath_Bytes:lastPath];
}

/// 获取某个文件夹的大小 单位：bytes
/// @param folderPath  文件路径
+ (float)getFolderSizeAtPath_Bytes:(NSString *)folderPath {
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil) {
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [XMTool getFileSizeAtPath_Bytes:fileAbsolutePath];
    }
    return folderSize;
}

/// 获取单个文件的大小 单位：bytes
+ (long long)getFileSizeAtPath_Bytes:(NSString*)filePath {
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

/// 根据 byte的大小，返回 多少GB /MB/KB/B
+ (NSString *)getFileSizeStringFromBytes_XM:(uint64_t)byteSize {
    float gb = (1024 * 1024 * 1024);
    float mb = (1024 * 1024);
    float kb = 1024;
    if (gb <= byteSize) {
        return [NSString stringWithFormat:@"%@GB", [XMTool getNumberStrFromDouble_XM:(double)byteSize / gb]];
    }
    if (mb <= byteSize) {
        return [NSString stringWithFormat:@"%@MB", [XMTool getNumberStrFromDouble_XM:(double)byteSize / mb]];
    }
    if (kb <= byteSize) {
        return [NSString stringWithFormat:@"%@KB", [XMTool getNumberStrFromDouble_XM:(double)byteSize / kb]];
    }
    return [NSString stringWithFormat:@"%lluB", byteSize];
}

/// 数字转换为字符串
+ (NSString *)getNumberStrFromDouble_XM:(const double)num {
    NSInteger section = round((num - (NSInteger)num) * 100);
    if (section % 10) {
        return [NSString stringWithFormat:@"%.2f", num];
    }
    if (section > 0) {
        return [NSString stringWithFormat:@"%.1f", num];
    }
    return [NSString stringWithFormat:@"%.0f", num];
}

/// 清除网页WKWebView缓存 WKWebsiteDataStore
+ (void)clearWKWebViewCache {
    NSSet *websiteDataTypes = [NSSet setWithArray:@[
                                                     WKWebsiteDataTypeDiskCache,
                                                     WKWebsiteDataTypeOfflineWebApplicationCache,
                                                     WKWebsiteDataTypeMemoryCache,
                                                     WKWebsiteDataTypeLocalStorage,
                                                     WKWebsiteDataTypeCookies,
                                                     WKWebsiteDataTypeSessionStorage,
                                                     WKWebsiteDataTypeIndexedDBDatabases,
                                                     WKWebsiteDataTypeWebSQLDatabases
                                                     ]];
    NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
    [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
        // 结束回调
    }];
}

#pragma mark - 拨打电话功能

/// 拨打电话
/// @param phoneString 电话号码字符串
+ (void)callPhoneAction:(NSString *)phoneString {
    if (phoneString.length > 0) {
        NSString *lastStr = [[NSString alloc] initWithFormat:@"tel:%@",phoneString];
        NSURL *phoneURL = [NSURL URLWithString:lastStr];
        if ([[UIApplication sharedApplication] canOpenURL:phoneURL]) {
//            [[UIApplication sharedApplication] openURL:phoneURL];
            [[UIApplication sharedApplication] openURL:phoneURL options:@{} completionHandler:^(BOOL success) {
                
            }];
        }
    }
}

@end
