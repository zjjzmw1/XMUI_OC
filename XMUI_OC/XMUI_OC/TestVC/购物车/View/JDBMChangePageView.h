//
//  JDBMChangePageView.h
//  JDBMCartModule
//
//  Created by zhengminghui on 2022/5/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^ChangePageCallBackWithTag)(NSInteger tag);
typedef void(^ChangePageCallBackWithDict)(NSDictionary *dict);

@interface JDBMChangePageView : UIView

@property (copy, nonatomic)ChangePageCallBackWithTag  tagCallBack;
@property (copy, nonatomic)ChangePageCallBackWithDict dictCallBack;

/*
 @param data 数组字典 @[@{
                            @"tag":@"选项标识",
                            @"title":@"选项名称",
                            @"...":@"自定义需要回传数据",
                        },...]
 */
- (instancetype)initWithFrame:(CGRect)frame data:(NSArray *)data;
- (void)showViewWithData:(NSArray *)data;
- (void)changeViewWithTag:(NSInteger)tag;
@end

NS_ASSUME_NONNULL_END
