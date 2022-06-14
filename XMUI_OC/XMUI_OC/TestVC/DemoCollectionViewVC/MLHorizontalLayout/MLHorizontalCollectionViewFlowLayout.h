//
//  MLHorizontalCollectionViewFlowLayout.h
//  XMUI_OC
//
//  Created by ext.zhangmingwei1 on 2022/6/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum NSInteger {
    MLHorizonalCenter = 0,  // 水平居中
    MLHorizonalLeft = 1,
    MLHorizonalRight = 2,
}MLHorizonalType;

/// 水平对齐方式的 flowLayout
@interface MLHorizontalCollectionViewFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, assign) MLHorizonalType horizonalType;

@end

NS_ASSUME_NONNULL_END
