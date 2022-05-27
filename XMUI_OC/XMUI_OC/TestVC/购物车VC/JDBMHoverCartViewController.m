//
//  JDBMHoverCartViewController.m
//  JDBMCartModule
//
//  Created by zhengminghui on 2022/5/24.
//

#import "JDBMHoverCartViewController.h"
#import "XMSizeMacro.h"
#import "UIView+XMTool.h"

@implementation JDBMHoverChildViewController
@end

@interface JDBMHoverPageScrollView : UIScrollView<UIGestureRecognizerDelegate>
@property(nonatomic, strong) NSArray *scrollViewWhites;


@end

@implementation JDBMHoverPageScrollView

- (BOOL)touchesShouldCancelInContentView:(UIView *)view{
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    if (self.scrollViewWhites == nil) {
        return YES;
    }
    for (UIScrollView *item in self.scrollViewWhites) {
        if (otherGestureRecognizer.view == item){
            return YES;
        }
    }
    return NO;
}
@end


@interface JDBMHoverPageViewController  ()<UIScrollViewDelegate,JDBMHoverChildViewControllerDelegate> {
    CGFloat currentY;
}
@property(nonatomic, strong) JDBMHoverPageScrollView *mainScrollView;
@property(nonatomic, strong) UIScrollView *pageScrollView;

/// 置顶按钮
@property (nonatomic, strong) UIButton  *toTopBtn;

@end

@implementation JDBMHoverPageViewController

- (instancetype)initWithViewControllers:(NSArray *)viewControllers
                             headerView:(UIView *)headerView
                          pageTitleView:(UIView *)pageTitleView{
    if (self = [super initWithNibName:nil bundle:nil]){
        _viewControllers = viewControllers;
        _headerView = headerView;
        _pageTitleView = pageTitleView;
    }
    return self;
}

+ (instancetype)viewControllers:(NSArray<JDBMHoverChildViewController *> *)viewControllers
                     headerView:(UIView *)headerView
                  pageTitleView:(UIView *)pageTitleView{
    return [[JDBMHoverPageViewController alloc]initWithViewControllers:viewControllers headerView:headerView pageTitleView:pageTitleView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareView];
}

- (void)prepareView{
    self.mainScrollView = [[JDBMHoverPageScrollView alloc]init];
    self.mainScrollView.bounces = NO;
    self.mainScrollView.delegate = self;
    self.mainScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.mainScrollView];
    [self.mainScrollView addSubview:_headerView];
    [self.mainScrollView addSubview:_pageTitleView];
    
    self.pageScrollView = [[UIScrollView alloc]init];
    self.pageScrollView.pagingEnabled = YES;
    self.pageScrollView.delegate = self;
    self.pageScrollView.showsHorizontalScrollIndicator = NO;
    [self.mainScrollView addSubview:self.pageScrollView];
    for (JDBMHoverPageViewController *vc in self.viewControllers) {
        [self.pageScrollView addSubview:vc.view];
        [self addChildViewController:vc];
    }
    if (@available(iOS 11.0, *)){
        self.mainScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    self.toTopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.toTopBtn.frame = CGRectMake(kScreenWidth_XM - 100, kScreenHeight_XM - 100, 50, 50);
    self.toTopBtn.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.toTopBtn];
    __weak typeof(self) weakSelf = self;
    [self.toTopBtn setTapActionWithBlock:^{
        [weakSelf toTopAction];
    }];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.mainScrollView.frame = self.view.bounds;
    self.mainScrollView.contentSize = CGSizeMake(0, self.mainScrollView.frame.size.height + self.headerView.frame.size.height);
    // 44 高度的切换view
    _pageTitleView.frame = CGRectMake(0, kNaviStatusBarH_XM,  _pageTitleView.frame.size.width,  _pageTitleView.frame.size.height);
    // 切换view下面的vc
    self.pageScrollView.frame = CGRectMake(0, CGRectGetMaxY(_pageTitleView.frame), self.view.frame.size.width, self.mainScrollView.contentSize.height - CGRectGetMaxY(_pageTitleView.frame));
    self.pageScrollView.contentSize = CGSizeMake(self.view.frame.size.width * _viewControllers.count, 0);
    NSMutableArray *scrollViews = [NSMutableArray array];
    for (NSInteger i = 0; i < _viewControllers.count; i++) {
        JDBMHoverChildViewController *child = [_viewControllers objectAtIndex:i];
        child.scrollDelegate = self;
        child.view.frame = CGRectMake(i * self.view.frame.size.width, child.view.frame.origin.y, child.view.frame.size.width, child.view.frame.size.height);
        if (child.scrollView != nil){
            [scrollViews addObject:child.scrollView];
            child.scrollView.frame = CGRectMake(child.scrollView.frame.origin.x, child.scrollView.frame.origin.y, child.scrollView.frame.size.width, self.pageScrollView.frame.size.height);
        }
    }
    self.mainScrollView.scrollViewWhites = scrollViews;
    NSLog(@"sss====%@",self.mainScrollView);
}

- (void)moveToAtIndex:(NSInteger)index animated:(BOOL)animated{
    for (JDBMHoverChildViewController *child in _viewControllers) {
        child.isCanScroll = YES;
    }
    [self.pageScrollView setContentOffset:CGPointMake(index * self.view.frame.size.width, 0) animated:animated];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self scrollViewDidEndDecelerating:self.pageScrollView];
    });
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
     self.pageScrollView.scrollEnabled = YES;
     self.mainScrollView.scrollEnabled = YES;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    self.pageScrollView.scrollEnabled = YES;
    self.mainScrollView.scrollEnabled = YES;
    if (scrollView == self.pageScrollView){
        _currentIndex = (NSUInteger)(scrollView.contentOffset.x / scrollView.frame.size.width + 0.5) % _viewControllers.count;
        if ([self.delegate respondsToSelector:@selector(hoverPageViewController:scrollViewDidEndDecelerating:)]){
            [self.delegate hoverPageViewController:self scrollViewDidEndDecelerating:scrollView];
        }
    }
}

/// 上滑
- (void)dragUpAction {
    self.mainScrollView.contentOffset = CGPointMake(0, kStatusBarHeight_XM); // 上划
    [UIView animateWithDuration:0.25 animations:^{
        self.headerView.frame = CGRectMake(0, -kNaviStatusBarH_XM, kScreenWidth_XM, kNaviStatusBarH_XM);
    } completion:^(BOOL finished) {
        self.mainScrollView.contentOffset = CGPointMake(0, kStatusBarHeight_XM); // 上划
        self.headerView.frame = CGRectMake(0, -kNaviStatusBarH_XM, kScreenWidth_XM, kNaviStatusBarH_XM);
    }];
}

/// 下滑
- (void)dragDownAction {
    self.mainScrollView.contentOffset = CGPointMake(0, 0); // 下拉
    [UIView animateWithDuration:0.25 animations:^{
        self.headerView.frame = CGRectMake(0, 0, kScreenWidth_XM, kNaviStatusBarH_XM);
    } completion:^(BOOL finished) {
        self.mainScrollView.contentOffset = CGPointMake(0, 0); // 下拉
        self.headerView.frame = CGRectMake(0, 0, kScreenWidth_XM, kNaviStatusBarH_XM);
    }];
}

// 置顶
- (void)toTopAction {
    [self dragDownAction];
    JDBMHoverChildViewController *child = [_viewControllers objectAtIndex:_currentIndex];
    [child.scrollView setContentOffset:CGPointZero animated:YES];
    [self.mainScrollView setContentOffset:CGPointZero animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"滚动...");
    if (scrollView == self.mainScrollView){
        self.pageScrollView.scrollEnabled = NO;
        JDBMHoverChildViewController *child = [_viewControllers objectAtIndex:_currentIndex];
        if (child.offsetY < currentY && (child.offsetY < child.scrollView.contentSize.height - kScreenHeight_XM)) {
            NSLog(@"下拉");
            [self dragDownAction];
        } else if (child.offsetY > currentY){
            NSLog(@"上划了1111");
            [self dragUpAction];
        } else {
            // 暴力滑动的保护:
            if (self.headerView.frame.origin.y == -kNaviStatusBarH_XM && scrollView.contentOffset.y == 0) {
                [self dragDownAction];
            }
        }
        
        currentY = child.offsetY;
        if (child.offsetY > 0) { // 上滑
            if (scrollView.contentOffset.y != 0) { // 保护上划
                [self dragUpAction];
            }
        } else {
            for (JDBMHoverChildViewController *child in _viewControllers) {
                child.offsetY = 0;
            }
        }
    }else if (scrollView == self.pageScrollView){
        self.mainScrollView.scrollEnabled = NO;
        if ([self.delegate respondsToSelector:@selector(hoverPageViewController:scrollViewDidScroll:)]){
            [self.delegate hoverPageViewController:self scrollViewDidScroll:scrollView];
        }
    }
}
// 往上滚动是 + 变大
- (void)hoverChildViewController:(JDBMHoverChildViewController *)ViewController scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.mainScrollView.contentOffset.y < 0 && self.mainScrollView.contentOffset.y > 0){ // 导航栏要往上走了.
        JDBMHoverChildViewController *child = [_viewControllers objectAtIndex:_currentIndex];
        child.offsetY = 0;
    }
}

@end
