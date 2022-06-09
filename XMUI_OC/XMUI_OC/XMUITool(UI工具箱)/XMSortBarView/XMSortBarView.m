//
//  XMSortBarView.m
//  XMUI_OC
//
//  Created by ext.zhangmingwei1 on 2022/6/9.
//

#import "XMSortBarView.h"

@interface XMSortBarView()

/// 容器
@property (nonatomic, strong) UIView        *contentView;
/// 滚动view
@property (nonatomic, strong) UIScrollView  *scrollView;
/// 竖线
@property (nonatomic, strong) UIView        *lineView;

@end

@implementation XMSortBarView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.scrollView];
    [self.contentView addSubview:self.lineView];
    [self.contentView addSubview:self.pickBtn];
    
    [self.scrollView addSubview:self.mutipleBtn];
    [self.scrollView addSubview:self.saleBtn];
    [self.scrollView addSubview:self.priceBtn];
    [self.scrollView addSubview:self.newsBtn];
    [self.scrollView addSubview:self.sortBtn];
    
    [self reloadFrame];
    // 默认选择综合
    [self clickBtnAction:self.mutipleBtn];
    return self;
}

/// 刷新布局
- (void)reloadFrame {
    CGFloat space = 18;
    CGFloat btnH = self.frame.size.height;
    self.contentView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.scrollView.frame = CGRectMake(0, 0, self.contentView.width - 70, self.contentView.height);
    
    self.mutipleBtn.frame = CGRectMake(0, 0, 28 + space * 2, btnH);
    self.saleBtn.frame = CGRectMake(self.mutipleBtn.right + (28 - space*2), 0, 28 + space * 2, btnH);
    self.priceBtn.frame = CGRectMake(self.saleBtn.right + (24 - space*2), 0, 50 + space * 2, btnH);
    self.newsBtn.frame = CGRectMake(self.priceBtn.right + (24 - space*2), 0, 56 + space * 2, btnH);
    self.sortBtn.frame = CGRectMake(self.newsBtn.right + (27 - space*2), 0, 24 + space * 2, btnH);
    
    self.lineView.frame = CGRectMake(self.contentView.width - 70, 16, 0.5, (self.contentView.height - 16)/2.0);
    self.pickBtn.frame = CGRectMake(self.contentView.width - 70, 0, 70, btnH);
    
    // 右边有间隙
    self.scrollView.contentSize = CGSizeMake(self.sortBtn.right - space, self.frame.size.height);
}

#pragma mark - 按钮点击事件
- (void)clickBtnAction:(UIButton *)btn {
    if (btn.tag == XMSortBarClickType_sort1 || btn.tag == XMSortBarClickType_sort2 || btn.tag == XMSortBarClickType_pick) { // 排列、筛选的时候，不重置 排序按钮

    } else { // 重置排序按钮
        [self resetSortAction];
        if (btn.tag != XMSortBarClickType_priceAsc && btn.tag != XMSortBarClickType_priceDesc) {
            self.priceBtn.tag = XMSortBarClickType_priceDesc;
        }
    }
    // 设置选中按钮字体
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
    // 处理价格
    if (btn.tag == XMSortBarClickType_priceAsc || btn.tag == XMSortBarClickType_priceDesc) {
        if (btn.tag == XMSortBarClickType_priceAsc) { // 切换为降序
            btn.tag = XMSortBarClickType_priceDesc;
            [self.priceBtn setImage:[UIImage imageNamed:@"sort_price_des"] forState:UIControlStateNormal];
        } else { // 切为升序
            btn.tag = XMSortBarClickType_priceAsc;
            [self.priceBtn setImage:[UIImage imageNamed:@"sort_price_asc"] forState:UIControlStateNormal];
        }
    }
    if (btn.tag == XMSortBarClickType_sort1 || btn.tag == XMSortBarClickType_sort2) { // 排列方式
        if (btn.tag == XMSortBarClickType_sort1) {
            [self.sortBtn setImage:[UIImage imageNamed:@"sort_goods_sel"] forState:UIControlStateNormal];
            self.sortBtn.tag = XMSortBarClickType_sort2;
        } else {
            [self.sortBtn setImage:[UIImage imageNamed:@"sort_goods_normal"] forState:UIControlStateNormal];
            self.sortBtn.tag = XMSortBarClickType_sort1;
        }
    }
    if (btn.tag == XMSortBarClickType_pick) { // 筛选
        [self.pickBtn setImage:[UIImage imageNamed:@"sort_shaixuan_sel"] forState:UIControlStateNormal];
    }
    // 点击回调
    if (self.clickButtonBlock) {
        self.clickButtonBlock((XMSortBarClickType)btn.tag);
    }
}

/// 重置所有默认状态  ---  「切换状态、筛选   两个按钮不重置」
- (void)resetSortAction {
    // 默认字体
    [self.mutipleBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    self.mutipleBtn.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    [self.saleBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    self.saleBtn.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    [self.priceBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    self.priceBtn.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    [self.newsBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    self.newsBtn.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    // 默认图片
    [self.priceBtn setImage:[UIImage imageNamed:@"sort_price_normal"] forState:UIControlStateNormal];
}

/// 重置筛选按钮
- (void)resetPickButton {
    [self.pickBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    self.pickBtn.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    [self.pickBtn setImage:[UIImage imageNamed:@"sort_shaixuan_normal"] forState:UIControlStateNormal];
}

#pragma mark - 懒加载

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor whiteColor];
    }
    return _contentView;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}

- (UIButton *)mutipleBtn {
    if (!_mutipleBtn) {
        _mutipleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_mutipleBtn setTitle:@"综合" forState:UIControlStateNormal];
        [_mutipleBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        _mutipleBtn.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
        _mutipleBtn.tag = XMSortBarClickType_mutiple;
        [_mutipleBtn addTarget:self action:@selector(clickBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _mutipleBtn;
}

- (UIButton *)saleBtn {
    if (!_saleBtn) {
        _saleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_saleBtn setTitle:@"销量" forState:UIControlStateNormal];
        [_saleBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        _saleBtn.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
        _saleBtn.tag = XMSortBarClickType_sale;
        [_saleBtn addTarget:self action:@selector(clickBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saleBtn;
}

- (UIButton *)priceBtn {
    if (!_priceBtn) {
        _priceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_priceBtn setTitle:@"价格" forState:UIControlStateNormal];
        [_priceBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        _priceBtn.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
        [_priceBtn setImage:[UIImage imageNamed:@"sort_price_normal"] forState:UIControlStateNormal];
        _priceBtn.titleEdgeInsets = UIEdgeInsetsMake(0, - 12, 0, 12);
        _priceBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 28 + 3, 0, -(28 + 3));
        _priceBtn.tag = XMSortBarClickType_priceDesc;
        [_priceBtn addTarget:self action:@selector(clickBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _priceBtn;
}

- (UIButton *)newsBtn {
    if (!_newsBtn) {
        _newsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_newsBtn setTitle:@"最新上架" forState:UIControlStateNormal];
        [_newsBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        _newsBtn.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
        _newsBtn.tag = XMSortBarClickType_newest;
        [_newsBtn addTarget:self action:@selector(clickBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _newsBtn;
}

- (UIButton *)sortBtn {
    if (!_sortBtn) {
        _sortBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sortBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        _sortBtn.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
        // 新方式的获取图片
        [_sortBtn setImage:[UIImage imageNamed:@"sort_goods_normal"] forState:UIControlStateNormal];
        _sortBtn.tag = XMSortBarClickType_sort1;
        [_sortBtn addTarget:self action:@selector(clickBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sortBtn;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor lightGrayColor];
    }
    return _lineView;
}

- (UIButton *)pickBtn {
    if (!_pickBtn) {
        _pickBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_pickBtn setTitle:@"筛选" forState:UIControlStateNormal];
        [_pickBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        _pickBtn.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
        // 新方式的获取图片
//        [_pickBtn setImage:[UIImage bm_iconWithName:JDIF_ICON_FILTER imageSize:CGSizeMake(12, 12) color:[UIColor darkGrayColor]] forState:UIControlStateNormal];
        [_pickBtn setImage:[UIImage imageNamed:@"sort_shaixuan_normal"] forState:UIControlStateNormal];
        _pickBtn.titleEdgeInsets = UIEdgeInsetsMake(0, - 12, 0, 12);
        _pickBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 28 + 4, 0, -(28 + 4));
        _pickBtn.tag = XMSortBarClickType_pick;
        [_pickBtn addTarget:self action:@selector(clickBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _pickBtn;
}


@end
