//
//  XMSizeMacro.h
//  艺库
//
//  Created by zhangmingwei on 2019/7/11.
//  Copyright © 2019 YiKuNetwork. All rights reserved.
//

#ifndef XMSizeMacro_h
#define XMSizeMacro_h

/// 屏幕高度
#define kScreenHeight_XM [UIScreen mainScreen].bounds.size.height
/// 屏幕宽度
#define kScreenWidth_XM [UIScreen mainScreen].bounds.size.width

/// 状态栏高度
#define kStatusBarHeight_XM         (kIsIphoneX_or_later ? kSafeAreaTop_XM : 20)
/// 导航栏+状态栏 /// 如果是iOS12以上的iPad，导航栏就是50 + status  ，ipad的导航栏不好确定，不同iPad高度也不同
#define kNaviStatusBarH_XM (kStatusBarHeight_XM + 44)

#define kTabBarH_XM   (kIsIphoneX_or_later ? (kSafeAreaBottom_XM + 49.0) : (kIsIpad_XM ? 56.f : 49.f))

/// 判断是否是全面屏
#define kIsIphoneX_or_later \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] keyWindow].safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})

/// 底部安全区的高度，非全面屏就是0
#define kSafeAreaBottom_XM \
^(){\
if (@available(iOS 11.0, *)) {\
    UIEdgeInsets safeAreaInsets = [[UIApplication sharedApplication] keyWindow].safeAreaInsets;\
    return safeAreaInsets.bottom;\
} else {\
    return UIEdgeInsetsMake(0, 0, 0, 0).bottom;\
}\
}()
/// 顶部安全区的高度 （全面屏的话就是statubar的高度，非全面屏就是0）
#define kSafeAreaTop_XM \
^(){\
if (@available(iOS 11.0, *)) {\
    UIEdgeInsets safeAreaInsets = [[UIApplication sharedApplication] keyWindow].safeAreaInsets;\
    return safeAreaInsets.top;\
} else {\
    return UIEdgeInsetsMake(0, 0, 0, 0).top;\
}\
}()

/// 是否是iPhone4的尺寸大小
#define kIsIPhone4Size_XM ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
/// 是否是kIsIPhone5Size_XM的尺寸大小
#define kIsIPhone5Size_XM ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
/// 是否是iPhone6的尺寸大小
#define kIsIPhone6Size_XM ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
/// 是否是iPhone6Plus的尺寸大小
#define kIsIPhone6PlusSize_XM ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
/// 是否是iPad
#define kIsIpad_XM (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

/// 比例系数 -- 以iPhone6为标准 - 传入iPhone6手机的 view的宽度或者高度 -- 就应该以宽度的比例，不应该用高度的比例
#define kScaleIphone6_W_XM(w)       (kScreenWidth_XM*(w)/375)


#endif /* XMSizeMacro_h */
