//
//  XMSortBarView.h
//  XMUI_OC
//
//  Created by ext.zhangmingwei1 on 2022/6/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum {
    XMSortBarClickType_mutiple    =   0,  // 综合
    XMSortBarClickType_sale       =   1,  // 销量
    XMSortBarClickType_priceAsc   =   2,  // 价格升序
    XMSortBarClickType_priceDesc  =   3,  // 价格降序
    XMSortBarClickType_newest     =   4,  // 最新
    XMSortBarClickType_sort1      =   5,  // 排列方式1
    XMSortBarClickType_sort2      =   6,  // 排列方式2
    XMSortBarClickType_pick       =   7,  // 筛选
}XMSortBarClickType;

/// 搜索结果页的 排序bar - 「综合、销量、价格、最新上架、筛选」
@interface XMSortBarView : UIView

// ------------------- 方便处理某个页面隐藏某个按钮的需求 BEGIN 「一般用不到」
/// 综合
@property (nonatomic, strong) UIButton      *mutipleBtn;
/// 销量
@property (nonatomic, strong) UIButton      *saleBtn;
/// 价格
@property (nonatomic, strong) UIButton      *priceBtn;
/// 最新上架
@property (nonatomic, strong) UIButton      *newsBtn;
/// 排列方式
@property (nonatomic, strong) UIButton      *sortBtn;
/// 筛选
@property (nonatomic, strong) UIButton      *pickBtn;
// ------------------- 方便处理某个页面隐藏某个按钮的需求 END 「一般用不到」

/// 点击按钮的回调
@property (nonatomic, copy) void (^clickButtonBlock) (XMSortBarClickType);

/// 重置筛选按钮
- (void)resetPickButton;

@end

NS_ASSUME_NONNULL_END
