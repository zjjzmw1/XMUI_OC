//
//  AppDelegate.m
//  XMUI_OC
//
//  Created by ext.zhangmingwei1 on 2022/5/26.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "XMTabBarVC.h"
#import "XMWebViewManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    self.window.backgroundColor = [UIColor whiteColor];
//    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:[ViewController new]];
//    self.window.rootViewController = navi;
    [self.window makeKeyAndVisible]; // 这句话之后，是否全面屏的相关的宏定义才准确。否则不对。会导致下面用到全面屏的方法的时候不对
    // 添加tabbar
    [self.window setRootViewController:[XMTabBarVC defaultManager]];

    [self.window makeKeyAndVisible];
    
    // 预加载网页
    NSArray *urlArr = @[@"http://www.baidu.com"];
    [[XMWebViewManager defalutManager] preloadWebViewWithUrlArray:urlArr];
    
    return YES;
}

#pragma mark - 这里设置竖屏，其他所有页面都竖屏了。  --- 某个VC再设置横屏也没用了
- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    return UIInterfaceOrientationMaskAllButUpsideDown;
}


@end
