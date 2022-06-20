//
//  OrderListAlertView.h
//  XMUI_OC
//
//  Created by zhangmingwei on 2022/6/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 订单状态 弹出 view
@interface OrderListAlertView : UIView

/// 选中的row
@property (nonatomic, assign) NSInteger     currentSelectRow;
@property (nonatomic, strong) NSArray       *dataArray;

/// 确定按钮的点击回调
@property (nonatomic, copy) void (^clickSubmitBlock) (NSInteger row, NSString *titleStr);

/// 弹出
- (void)showAction;

@end

NS_ASSUME_NONNULL_END
