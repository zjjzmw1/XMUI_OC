//
//  DemoHorizontalCollectionViewCell.h
//  XMUI_OC
//
//  Created by ext.zhangmingwei1 on 2022/6/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DemoHorizontalCollectionViewCell : UICollectionViewCell

/// 刷新数据
- (void)reloadAction:(NSString *)titleStr;

+ (CGSize)size:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
