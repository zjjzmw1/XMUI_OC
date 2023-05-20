//
//  XMWebViewVC.h
//  XMUI_OC
//
//  Created by zhangmingwei on 2023/5/20.
//

#import "DemoBaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMWebViewVC : DemoBaseVC

/// 网页地址
@property (nonatomic, copy) NSString *urlString;
/// 是否需要缓存
@property (nonatomic, assign) BOOL needCacheFlag;

@end

NS_ASSUME_NONNULL_END
