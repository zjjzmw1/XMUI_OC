//
//  OrderListAlertView.m
//  XMUI_OC
//
//  Created by ext.zhangmingwei1 on 2022/6/20.
//

#import "OrderListAlertView.h"
#import "OrderListCell.h"

@interface OrderListAlertView()<UITableViewDataSource, UITableViewDelegate>

/// 容器
@property (nonatomic, strong) UIView        *contentView;
/// 蒙层
@property (nonatomic, strong) UIView        *maskView;

/// 标题
@property (nonatomic, strong) UILabel       *titleLbl;
/// 关闭按钮
@property (nonatomic, strong) UIButton      *closeBtn;
/// 确定按钮
@property (nonatomic, strong) UIButton      *submitBtn;

@property (nonatomic, strong) UITableView   *tableView;
/// 是否将要隐藏
@property (nonatomic, assign) BOOL          willHidden;
/// 停止拖拽的时候的偏移
@property (nonatomic, assign) CGFloat       stopDragingOffsetY;

@end

@implementation OrderListAlertView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:CGRectMake(0, 0, kScreenWidth_XM, kScreenHeight_XM)];
    if (self) {
        if (self.superview == nil) {
            [[UIApplication sharedApplication].keyWindow addSubview:self];
        }
        [self initAllSubView];
    }
    return self;
}

- (void)initAllSubView {
    [self addSubview:self.maskView];
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.tableView];
    [self.contentView addSubview:self.submitBtn];
    
    self.maskView.frame = CGRectMake(0, 0, kScreenWidth_XM, kScreenHeight_XM);
    self.contentView.frame = CGRectMake(0, 156, kScreenWidth_XM, kScreenHeight_XM - 156);
    
    self.tableView.frame = CGRectMake(0, 0, self.frame.size.width, self.contentView.height - kSafeAreaBottom_XM - 55);
    // 确定按钮
    self.submitBtn.frame = CGRectMake(18, self.contentView.height - 38 - kSafeAreaBottom_XM - 10, self.width - 36, 38);
}

#pragma mark - 弹出方法
- (void)showAction {
    self.willHidden = NO;
    if (self.superview == nil) {
        [[UIApplication sharedApplication].keyWindow addSubview:self];
    }
    [self.tableView reloadData];
    self.maskView.alpha = 0.0;
    self.contentView.transform = CGAffineTransformMakeTranslation(0, self.contentView.height);
    [self.tableView reloadData];
    [UIView animateWithDuration:0.2 animations:^{
        self.maskView.alpha = 0.5;
        self.contentView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - 隐藏方法
- (void)hiddenAction {
    self.willHidden = YES;
    self.maskView.alpha = 0.5;
    [UIView animateWithDuration:0.2 animations:^{
        self.maskView.alpha = 0.0;
        self.contentView.transform = CGAffineTransformMakeTranslation(0, self.contentView.height);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - 确定点击回调
- (void)submitAction {
    if (self.dataArray.count > self.currentSelectRow) {
        self.clickSubmitBlock(self.currentSelectRow, self.dataArray[self.currentSelectRow]);
    }
    [self hiddenAction];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    self.currentSelectRow = indexPath.row;
    [self.tableView reloadData];
}

#pragma mark - table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth_XM, 44)];
    headerView.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:self.titleLbl];
    [headerView addSubview:self.closeBtn];
    self.titleLbl.frame = CGRectMake(0, 0, headerView.width, headerView.height);
    self.closeBtn.frame = CGRectMake(headerView.width - 44, 0, 44, 44);
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    OrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderListCell"];

    if (self.dataArray.count > indexPath.row) {
        NSString *titleStr = self.dataArray[indexPath.row];
        [cell reloadData:indexPath.row selectRow:self.currentSelectRow title:titleStr];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.willHidden == NO) { // 拖拽过程中
        if (scrollView.contentOffset.y < 0) {
            scrollView.superview.transform = CGAffineTransformMakeTranslation(0, -scrollView.contentOffset.y);
            scrollView.transform = CGAffineTransformMakeTranslation(0, scrollView.contentOffset.y);
        } else {
            scrollView.superview.transform = CGAffineTransformIdentity;
            scrollView.transform = CGAffineTransformIdentity;
        }
    }
    // 第二种消失逻辑 ---- 类似抖音效果 ------------- BEGIN
    if (self.stopDragingOffsetY < -30 && (self.stopDragingOffsetY - scrollView.contentOffset.y > 0)) { // 快速下拉
        [self hiddenAction];
    } else if (self.stopDragingOffsetY < -50 && (self.stopDragingOffsetY - scrollView.contentOffset.y >= 0)) {
        [self hiddenAction];
    } else if (self.stopDragingOffsetY < -80 && (self.stopDragingOffsetY - scrollView.contentOffset.y >= -2)) {
        [self hiddenAction];
    }
    if (self.stopDragingOffsetY < 0) {
        NSLog(@"yy===%f,,,%f",self.stopDragingOffsetY, scrollView.contentOffset.y);
    }
    self.stopDragingOffsetY = 0;
    // 第二种消失逻辑 ----------------- END
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    // 第一种消失逻辑 ----------------- BEGIN
    // 停止拖拽的时候，下拉高度大于80，就消失
//    if (scrollView.contentOffset.y < -80 && scrollView.isDragging == NO) {
//        [self hiddenAction];
//    }
    // 第一种消失逻辑 ----------------- END

    // 第二种消失逻辑 ---- 类似抖音效果 ------------- BEGIN
    self.stopDragingOffsetY = scrollView.contentOffset.y;
    // 第二种消失逻辑 ----------------- END
}

#pragma mark - 懒加载

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth_XM, kScreenHeight_XM)];
        _contentView.backgroundColor = [UIColor whiteColor];
        [self addRectCorner:4 corners:UIRectCornerTopLeft|UIRectCornerTopRight toView:_contentView];
    }
    return _contentView;
}

- (UIView *)maskView {
    if (!_maskView) {
        _maskView = [[UIView alloc] init];
        _maskView.backgroundColor = [UIColor blackColor];
        _maskView.alpha = 0.0;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenAction)];
        [_maskView addGestureRecognizer:tap];
    }
    return _maskView;
}

- (UILabel *)titleLbl {
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] init];
        _titleLbl.textColor = [UIColor blackColor];
        _titleLbl.font = [UIFont systemFontOfSize:18];
        _titleLbl.textAlignment = NSTextAlignmentCenter;
        _titleLbl.text = @"订单状态";
    }
    return _titleLbl;
}

- (UIButton *)closeBtn {
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeBtn setImage:[UIImage imageNamed:@"close_icon"] forState:UIControlStateNormal];
        _closeBtn.frame = CGRectMake(0, 0, 20, 20);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenAction)];
        [_closeBtn addGestureRecognizer:tap];
    }
    return _closeBtn;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        // 不添加横线
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedRowHeight = 0;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        [_tableView registerClass:[OrderListCell class] forCellReuseIdentifier:@"OrderListCell"];
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {

        }
        if (@available(iOS 15.0, *)) {
            _tableView.sectionHeaderTopPadding = 0;
        } else {
            // Fallback on earlier versions
        }
        UIView *headV = [[UIView alloc] init];
        _tableView.tableHeaderView = headV;
    }
    return _tableView;
}

- (UIButton *)submitBtn {
    if (!_submitBtn) {
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_submitBtn setTitle:@"确定" forState:UIControlStateNormal];
        _submitBtn.backgroundColor = [UIColor redColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(submitAction)];
        [_submitBtn addGestureRecognizer:tap];
    }
    return _submitBtn;
}

#pragma mark - 为了不依赖其他类，把切圆角的方法，写到这里
/**
 *  添加UIView的四个角的任意角的圆角 需要对设置圆角的view添加frame，否则不行
 *
 *  @param angle    圆角的大小
 *  @param corners  设置哪个角为圆角
 *  @param toView  给哪个view设置圆角
 */
- (void)addRectCorner:(float)angle corners:(UIRectCorner)corners toView:(UIView *)toView {
    // 设置圆角，需要view有frame
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:toView.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(angle, angle)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = toView.bounds;
    maskLayer.path = maskPath.CGPath;
    toView.layer.mask = maskLayer;
}

@end
