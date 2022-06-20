//
//  OrderListCell.h
//  XMUI_OC
//
//  Created by ext.zhangmingwei1 on 2022/6/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderListCell : UITableViewCell

/// 刷新数据
- (void)reloadData:(NSInteger)currentRow selectRow:(NSInteger)selectRow title:(NSString *)titleString;

@end

NS_ASSUME_NONNULL_END
