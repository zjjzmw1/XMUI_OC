//
//  JDBMHoverCartViewController.h
//  JDBMCartModule
//
//  Created by zhengminghui on 2022/5/24.
//

#import <UIKit/UIKit.h>
//#import <WJOACommonModule/WJBaseViewController.h>
#import "WJBaseViewController.h"

@class JDBMHoverChildViewController;
@class JDBMHoverPageViewController;
NS_ASSUME_NONNULL_BEGIN

@protocol JDBMHoverChildViewControllerDelegate <NSObject>
@optional
- (void)hoverChildViewController:(JDBMHoverChildViewController *)ViewController scrollViewDidScroll:(UIScrollView *)scrollView;
@end

@protocol JDBMHoverPageViewControllerDelegate <NSObject>
@optional
- (void)hoverPageViewController:(JDBMHoverPageViewController *)ViewController scrollViewDidScroll:(UIScrollView *)scrollView;
- (void)hoverPageViewController:(JDBMHoverPageViewController *)ViewController scrollViewDidEndDecelerating:(UIScrollView *)scrollView;
@end

@interface JDBMHoverChildViewController : WJBaseViewController
@property(nonatomic, assign) CGFloat offsetY;
@property(nonatomic, assign) BOOL isCanScroll;
@property(nonatomic, weak) id<JDBMHoverChildViewControllerDelegate> scrollDelegate;
@property(nonatomic, strong) UIScrollView *scrollView;
@end


@interface JDBMHoverPageViewController : WJBaseViewController
- (instancetype)initWithViewControllers:(NSArray<JDBMHoverChildViewController *> *)viewControllers
                             headerView:(UIView *)headerView
                          pageTitleView:(UIView *)pageTitleView;

+ (instancetype)viewControllers:(NSArray<JDBMHoverChildViewController *> *)viewControllers
                     headerView:(UIView *)headerView
                  pageTitleView:(UIView *)pageTitleView;

@property(nonatomic, strong, readonly) NSArray<JDBMHoverChildViewController *> *viewControllers;
@property(nonatomic, strong, readonly) UIView *headerView;
@property(nonatomic, strong, readonly) UIView *pageTitleView;
@property(nonatomic, assign, readonly) NSUInteger currentIndex;
@property(nonatomic, weak) id<JDBMHoverPageViewControllerDelegate> delegate;

- (void)moveToAtIndex:(NSInteger)index animated:(BOOL)animated;
@end

NS_ASSUME_NONNULL_END
