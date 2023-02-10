//
//  TestVCViewController.h
//  XMUI_OC
//
//  Created by zhangmingwei6 on 2023/2/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TestVCViewController : UIViewController

@property (nonatomic, copy) void (^backBlock) (void);

@end

NS_ASSUME_NONNULL_END
