//
//  UITableView+XMTool.m
//  艺库
//
//  Created by zhangmingwei on 2019/8/15.
//  Copyright © 2019 YiKuNetwork. All rights reserved.
//

#import "UITableView+XMTool.h"

@implementation UITableView (XMTool)


/**
 便捷的初始化 UITableView的类方法
 */
+ (instancetype)instanceWithType:(UITableViewStyle)style {
    UITableView *tableV = [[UITableView alloc] initWithFrame:CGRectZero style:style];
    [tableV registerClass:[UITableViewCell self] forCellReuseIdentifier:@"UITableViewCell"];
    tableV.separatorStyle = UITableViewCellSeparatorStyleNone; // 默认不带横线
    tableV.separatorColor = [UIColor lightGrayColor];
    tableV.backgroundColor = [UIColor whiteColor];
    tableV.rowHeight = UITableViewAutomaticDimension;
    // 0 就是不自动适配高度了。
//    tableV.estimatedRowHeight = 0; // 个别场景：太小会跳动，太大会算不准。可以根据具体页面调整这个值。
    tableV.estimatedSectionHeaderHeight = 0;
    tableV.estimatedSectionFooterHeight = 0;
    if (@available(iOS 11.0, *)) {
        tableV.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
    // 修复section上面有空白的bug
    if (@available(iOS 15.0, *)) {
        tableV.sectionHeaderTopPadding = 0;
    } else {
        // Fallback on earlier versions
    }
    if (style == UITableViewStyleGrouped) {
        tableV.sectionHeaderHeight = CGFLOAT_MIN;
        tableV.sectionFooterHeight = CGFLOAT_MIN;
    }
    return tableV;
}

/**
 section 不值顶的方法
 */
- (void)setSectionHeaderNotTopWithHeight:(CGFloat)sectionHeight {
    if (self.contentOffset.y <= sectionHeight && self.contentOffset.y > 0) {
        if (self.contentInset.top != -self.contentOffset.y) {
            self.contentInset = UIEdgeInsetsMake(-self.contentOffset.y, 0, 0, 0);
        }
    } else if (self.contentOffset.y >= sectionHeight) {
        if (self.contentInset.top != -sectionHeight) {
            self.contentInset = UIEdgeInsetsMake(-sectionHeight, 0, 0, 0);
        }
    }
}


@end
