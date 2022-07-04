//
//  NSDate+XMTool.h
//  艺库
//
//  Created by zhangmingwei on 2019/7/11.
//  Copyright © 2019 YiKuNetwork. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (XMTool)

/// 根据时间戳返回某个格式的字符串
/// @param timestamp 时间戳的字符串
/// @param dateFormat 例如：「YYYY-MM-dd」
+ (NSString *)getTimeStringFromTimestamp:(NSString *)timestamp andDateFormat:(NSString *)dateFormat;

/// 根据日期字符串获取NSDate类型
/// @param formateString 时间格式例如： @"yyyy-MM-dd HH:mm:ss"
/// @param dateStr 字符串时间
+ (NSDate *)getDateWithFormateString:(NSString *)formateString dateString:(NSString *)dateStr;

/// 获取时间的字符串 "yyyy-MM-dd HH:mm:ss"
- (NSString *)getDateStr_XM;
/// 根据 "yyyy-MM-dd HH:mm:ss" 格式的字符串，返回NSdate格式的时间
+ (NSDate *)getDate_XM:(NSString *)dateStr_XM;
/// 上次存储的时间，距离当前时间的间隔 秒: 例如：距离上次存储时间，距离现在是  20秒
+ (NSTimeInterval)fromNowTimeInterval_XM:(NSString *)lastDateStr;

/// 返回 @"yyyy-MM-dd HH:mm:ss" 类型的字符串
- (NSString *)dateString;
/// 返回 format类型的字符串 - 传入格式例如：@"yyyy-MM-dd HH:mm:ss"
- (NSString *)dateStrWithFormat:(NSString *)format;
/// 距离当前时间的间隔：1分钟内、几分钟前、几天前、等 -- 类似朋友圈、微博 - 的时间展示
- (NSString *)fromNowTimeIntervalDescription;

/// 获取年份
- (NSInteger)getYearInteger;
/// 获取月份
- (NSInteger)getMonthInteger;
/// 获取天
- (NSInteger)getDayInteger;

@end

NS_ASSUME_NONNULL_END
