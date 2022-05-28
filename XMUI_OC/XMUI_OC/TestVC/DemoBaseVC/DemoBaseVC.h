//
//  DemoBaseVC.h
//  XMUI_OC
//
//  Created by ext.zhangmingwei1 on 2022/5/28.
//

#import <UIKit/UIKit.h>
#import "XMCustomNaviView.h"

NS_ASSUME_NONNULL_BEGIN

@interface DemoBaseVC : UIViewController

/// 自定义导航栏
@property (nonatomic, strong) XMCustomNaviView  *customNaviView;

@end

NS_ASSUME_NONNULL_END
