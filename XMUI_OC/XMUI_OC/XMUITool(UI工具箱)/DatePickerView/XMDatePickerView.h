//
//  XMDatePickerView.h
//  XMUI_OC
//
//  Created by zhangmingwei on 2022/6/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 选择的日期block
typedef void(^XMDateSubmitBlock) (NSString *selectedDate);

@interface XMDatePickerView : UIView

/// 初始化 第一步 （共两步）
- (instancetype)initDateWithTypeWithDefaultDate:(NSDate *)defaultDate
                                      doneBlock:(XMDateSubmitBlock) submitBlock;

/// 弹出展示 第二步 （共两步）
- (void)showAction;

@end

NS_ASSUME_NONNULL_END
