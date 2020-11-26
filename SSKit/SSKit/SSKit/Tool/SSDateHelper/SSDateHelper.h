//
//  SSDateHelper.h
//  SSDateHelper
//  日期助手，提供日期字符转换、日期计算、日期判断等功能。
//  Created by SunSatan on 20/3/22.
//  Copyright © 2020年 SunSatan. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 日期字符相互转化 方法名注解：xx_yyyy_zzzz
 
 xx: 分割符简称，特指使用日期格式中年月日间的分割符
 1、hl: 年月日间分割符为横线- Horizontal line
 2、ol: 年月日间分割符为斜线/ Oblique line
 3、cn: 年月日间分割符为中文
 4、dot: 年月日间分割符为圆点.
 5、nl: 显示使用中国农历
 注：时分秒间分割符默认统一使用冒号:
 
 yyyy: 日期格式，指设置的dateFormat的具体格式
 
 zzzz: 功能描述，stringFromDate 或者 dateFromString
 */

#define SSDateMainHelper SSDateHelper.main

typedef NS_ENUM(NSUInteger, SSDateSubMode) {
    /** 
     减法计算相对精确：比如只要不是同一年(一个月、一天、一小时、一分、一秒)就会返回差值，并不在乎两个日期是不是只相差一秒
     例如：2020-01-01 和 2019-12-31 的年份差值为1或-1
     例如：2020-01-30 和 2020-02-02 的月份差值为1或-1
     */
    SSDateSubModeRelative,
    /**
     减法计算精确到日：比如在计算天、时、分、秒的差值时与 SSDateSubModeRelative 效果相同
     例如：2020-01-02 和 2019-01-03 的年份差值为0 
     例如：2020-01-02 和 2019-01-02 的年份差值为1或-1
     */
    SSDateSubModeDate,
    /** 减法计算精确到秒 */
    SSDateSubModeTime
};

typedef NS_ENUM(NSUInteger, SSDateWeekMode) {
    /** 根据日历惯例，认为每周开始第一天为周日 */
    SSDateWeekModeDefault,
    /** 根据我们惯例，认为每周开始第一天为周一 */
    SSDateWeekModeUsually
};

NS_ASSUME_NONNULL_BEGIN

@interface SSDateHelper : NSObject

#pragma mark - 单例模式

+ (instancetype)main;

@end

#pragma mark - NSDate 转为 NSString

@interface SSDateHelper (DateToString)

/// 返回格式为 y-M-d (2019-4-1)
- (NSString *)hl_YMD_stringFromDate:(NSDate *)date;
/// 返回格式为 yyyy-MM-dd (2019-04-01)
- (NSString *)hl_YYYYMMDD_stringFromDate:(NSDate *)date;
/// 返回格式为 y-M-d H:m (2019-4-1 15:32)
- (NSString *)hl_YMDHM_stringFromDate:(NSDate *)date;
/// 返回格式为 y-M-d H:m:s (2019-4-1 15:32:7)
- (NSString *)hl_YMDHMS_stringFromDate:(NSDate *)date;
/// 返回格式为 yyyy-MM-dd HH:mm:ss (2019-04-01 09:02:07)
- (NSString *)hl_YYYYMMDDHHMMSS_stringFromDate:(NSDate *)date;

/// 返回格式为 y年M月d日 (2019年4月1日)
- (NSString *)cn_YMD_stringFromDate:(NSDate *)date;
/// 返回格式为 y年M月d日 H:m (2019年4月1日 15:32)
- (NSString *)cn_YMDHM_stringFromDate:(NSDate *)date;
/// 返回格式为 y年M月d日 H:m:s (2019年4月1日 15:32:7)
- (NSString *)cn_YMDHMS_stringFromDate:(NSDate *)date;
/// 返回格式为 y年M月d日 HH:mm:ss (2019年4月1日 09:10:07)
- (NSString *)cn_YMDHHMMSS_stringFromDate:(NSDate *)date;
/// 返回格式为 M月d日 (4月1日)
- (NSString *)cn_MD_stringFromDate:(NSDate *)date;

/// 返回格式为 d/M/y (1/4/2019)
- (NSString *)ol_DMY_stringFromDate:(NSDate *)date;
/// 返回格式为 d/M/y H:m (1/4/2019 15:32)
- (NSString *)ol_DMYHM_stringFromDate:(NSDate *)date;

/// 返回格式为 y.M.d (2019.4.1)
- (NSString *)dot_YMD_stringFromDate:(NSDate *)date;
/// 返回格式为 y.M.d H:m (2019.4.1 15:32)
- (NSString *)dot_YMDHM_stringFromDate:(NSDate *)date;

/// 返回格式为 H:m (15:32)
- (NSString *)HM_stringFromDate:(NSDate *)date;
/// 返回格式为 H:m:s (15:32:7)
- (NSString *)HMS_stringFromDate:(NSDate *)date;
/// 返回格式为 HH:mm (15:32)
- (NSString *)HHMM_stringFromDate:(NSDate *)date;
/// 返回格式为 HH:mm:ss (15:32:7)
- (NSString *)HHMMSS_stringFromDate:(NSDate *)date;

/// 返回格式为 周日 (根据手机系统语言)
- (NSString *)week_StringFromDate:(NSDate *)date;
/// 返回格式为 星期日 (根据手机系统语言)
- (NSString *)weekday_StringFromDate:(NSDate *)date;
/// 返回格式为 周日（指定中文)
- (NSString *)cn_week_StringFromDate:(NSDate *)date;
/// 返回格式为 星期日（指定中文)
- (NSString *)cn_weekday_StringFromDate:(NSDate *)date;
/// 返回格式为 Mon（指定英文)
- (NSString *)en_week_StringFromDate:(NSDate *)date;
/// 返回格式为 Monday（指定英文)
- (NSString *)en_weekday_StringFromDate:(NSDate *)date;

@end

#pragma mark - NSString 转为 NSDate

@interface SSDateHelper (StringToDate)

/// 参数格式为 yyyy-MM-dd (2019-04-01)
- (NSDate *)hl_YYYYMMDD_dateFromString:(NSString *)str;
/// 参数格式为 yyyy-MM-dd H:m (2019-04-01 15:32)
- (NSDate *)hl_YYYYMMDDHM_dateFromString:(NSString *)str;
/// 参数格式为 yyyy-MM-dd HH:mm (2019-04-01 04:02)
- (NSDate *)hl_YYYYMMDDHHMM_dateFromString:(NSString *)str;
/// 参数格式为 yyyy-MM-dd H:m:s (2019-04-01 15:32:4)
- (NSDate *)hl_YYYYMMDDHMS_dateFromString:(NSString *)str;
/// 参数格式为 yyyy-MM-dd HH:mm:ss (2019-04-01 05:02:04)
- (NSDate *)hl_YYYYMMDDHHMMSS_dateFromString:(NSString *)str;
/// 参数格式为 M-d (4-1)
- (NSDate *)hl_MD_dateFromString:(NSString *)str;
/// 参数格式为 MM-dd (04-01)
- (NSDate *)hl_MMDD_dateFromString:(NSString *)str;

/// 参数格式为 y年M月d日 (2019年4月1日)
- (NSDate *)cn_YMD_dateFromString:(NSString *)str;
/// 参数格式为 M月d日 (4月1日)
- (NSDate *)cn_MD_dateFromString:(NSString *)str;
/// 参数格式为 y年M月d日 H:m (2019年4月1日 9:2)
- (NSDate *)cn_YMDHM_dateFromString:(NSString *)str;
/// 参数格式为 M月d日 H:m (4月1日 9:2)
- (NSDate *)cn_MDHM_dateFromString:(NSString *)str;

/// 参数格式为 y.M.d (2019.4.1)
- (NSDate *)dot_YMD_dateFromString:(NSString *)str;
/// 参数格式为 y.M.d H:m (2019.4.1 15:32)
- (NSDate *)dot_MD_dateFromString:(NSString *)str;

/// 参数格式为 d/M/y (1/4/2019)
- (NSDate *)ol_DMY_dateFromString:(NSString *)str;
/// 参数格式为 d/M/y H:m (1/4/2019 15:32)
- (NSDate *)ol_DMYHM_dateFromString:(NSString *)str;

@end

#pragma mark - 中国农历、生肖

@interface SSDateHelper (ChineseCalendar)

/// 返回 农历年月日 (甲子年二月十五)
- (NSString *)nl_YMD_stringFromDate:(NSDate *)date;
/// 返回 农历月日 (二月十五)
- (NSString *)nl_MD_stringFromDate:(NSDate *)date;
/// 返回 农历年 (甲子年)
- (NSString *)nl_yearsStringFromDate:(NSDate *)date;
/// 返回 农历月 (二月)
- (NSString *)nl_monthStringFromDate:(NSDate *)date;
/// 返回 农历日 (廿五)
- (NSString *)nl_dayStringFromDate:(NSDate *)date;
/// 返回 年份所属生肖 (鼠)
- (NSString *)nl_zodiacStringFromDate:(NSDate *)date;
/// 返回 年份所属地支生肖 (子鼠)
- (NSString *)nl_earthlyBranchesZodiacStringFromDate:(NSDate *)date;

@end

#pragma mark - 判断、比较

@interface SSDateHelper (Judge)

/**
 判断指定日期是否是今天，只比较年月日

 @param date 指定日期
 @return 当指定日期是今天时 yes，否则 no
 */
- (BOOL)isTodayForDate:(NSDate *)date;

/**
 判断指定日期年份是否是闰年

 @param date 指定日期
 @return 当指定日期在闰年中时 yes，否则 no
 */
- (BOOL)isLeapYearForDate:(NSDate *)date;

/**
 判断两个日期是否是同一天，只比较年月日

 @param fromDate 指定日期
 @param toDate 指定日期
 @return 当两个日期为同一天时 yes，否则 no
 */
- (BOOL)isSameDayFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;

/**
 判断两个日期是否是同时间，只比较年月日时分

 @param fromDate 指定日期
 @param toDate 指定日期
 @return 当两个日期为同时间时 yes，否则 no
 */
- (BOOL)isSameTimeFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;

/**
 判断指定日期是否比今天早，只比较年月日

 @param date 指定日期
 @return 只有指定日期早于今天时 yes，否则等于晚于都是 no
 */
- (BOOL)isEarlierThanTodayForDate:(NSDate *)date;

/**
 判断指定日期是否比今天晚，只比较年月日

 @param date 指定日期
 @return 只有指定日期晚于今天时 yes，否则等于早于都是 no
 */
- (BOOL)isLaterThanTodayForDate:(NSDate *)date;

/**
 判断指定日期是否比当前时间早，只比较年月日时分

 @param date 指定日期
 @return 只有指定日期早于当前时间时 yes，否则等于晚于都是 no
 */
- (BOOL)isEarlierThanPresentTimeForDate:(NSDate *)date;

/**
 判断指定日期是否比当前时间晚，只比较年月日时分

 @param date 指定日期
 @return 只有指定日期晚于当前时间时 yes，否则等于早于都是 no
 */
- (BOOL)isLaterThanPresentTimeForDate:(NSDate *)date;

/**
 判断 fromDate 是否是比 toDate 早，只比较年月日

 @param fromDate 早的日期
 @param toDate 晚的日期
 @return 只有 fromDate 早于 toDate 时 yes，否则等于晚于都是 no
 */
- (BOOL)isEarlierDayFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;

/**
 判断 fromDate 是否是比 toDate 晚，只比较年月日

 @param fromDate 晚的日期
 @param toDate 早的日期
 @return 只有 fromDate 晚于 toDate 时 yes，否则等于早于都是 no
 */
- (BOOL)isLaterDayFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;

/**
 判断 fromDate 是否是比 toDate 早，只比较年月日时分

 @param fromDate 早的日期
 @param toDate 晚的日期
 @return 只有 fromDate 早于 toDate 时 yes，否则等于晚于都是 no
 */
- (BOOL)isEarlierTimeFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;

/**
 判断 fromDate 是否是比 toDate 晚，只比较年月日时分

 @param fromDate 晚的日期
 @param toDate 早的日期
 @return 只有 fromDate 晚于 toDate 时 yes，否则等于早于都是 no
 */
- (BOOL)isLaterTimeFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;

@end

#pragma mark - 计算：增加、差值

@interface SSDateHelper (Calculation)

/**
 给指定日期增加指定年数

 @param years 指定年数
 @param toDate 指定日期
 @return 增加指定年数后的新日期
 */
- (NSDate *)dateByAddingYears:(NSInteger)years toDate:(NSDate *)toDate;

/**
 给指定日期增加指定月数

 @param months 指定月数
 @param toDate 指定日期
 @return 增加指定月数后的新日期
 */
- (NSDate *)dateByAddingMonths:(NSInteger)months toDate:(NSDate *)toDate;

/**
 给指定日期增加指定天数

 @param days 指定天数
 @param toDate 指定日期
 @return 增加指定天数后的新日期
 */
- (NSDate *)dateByAddingDays:(NSTimeInterval)days toDate:(NSDate *)toDate;

/**
 给指定日期增加指定小时数

 @param hours 指定小时数
 @param toDate 指定日期
 @return 增加指定小时数后的新日期
 */
- (NSDate *)dateByAddingHours:(NSTimeInterval)hours toDate:(NSDate *)toDate;

/**
 给指定日期增加指定分钟数

 @param minutes 指定分钟数
 @param toDate 指定日期
 @return 增加指定分钟数后的新日期
 */
- (NSDate *)dateByAddingMinutes:(NSTimeInterval)minutes toDate:(NSDate *)toDate;

/**
 给指定日期增加指定秒数

 @param seconds 指定秒数
 @param toDate 指定日期
 @return 增加指定秒数后的新日期
 */
- (NSDate *)dateByAddingSeconds:(NSTimeInterval)seconds toDate:(NSDate *)toDate;

/**
 计算 date 减去 subDate 的年份差

 @param date 减数日期
 @param subDate 被减数日期
 @param mode 指定精确方式
 @return 返回 date 减去 subDate 的年份差值
 */
- (NSInteger)yearsDifferenceForDate:(NSDate *)date subDate:(NSDate *)subDate subMode:(SSDateSubMode)mode;

/**
 计算 date 减去 subDate 的月份差
 
 @param date 减数日期
 @param subDate 被减数日期
 @param mode 指定精确方式
 @return 返回 date 减去 subDate 的月份差值
 */
- (NSInteger)monthsDifferenceForDate:(NSDate *)date subDate:(NSDate *)subDate subMode:(SSDateSubMode)mode;

/**
 计算 date 减去 subDate 的天数差
 
 @param date 减数日期
 @param subDate 被减数日期
 @param mode 指定精确方式
 @return 返回 date 减去 subDate 的天数差值
 */
- (NSInteger)daysDifferenceForDate:(NSDate *)date subDate:(NSDate *)subDate subMode:(SSDateSubMode)mode;

/**
 计算 date 减去 subDate 的小时差

 @param date 减数日期
 @param subDate 被减数日期
 @param mode 指定精确方式
 @return 计算 date 减去 subDate 的小时差值
 */
- (NSInteger)hoursDifferenceForDate:(NSDate *)date subDate:(NSDate *)subDate subMode:(SSDateSubMode)mode;

/**
 计算 date 减去 subDate 的分钟差

 @param date 减数日期
 @param subDate 被减数日期
 @param mode 指定精确方式
 @return 计算 date 减去 subDate 的分钟差值
 */
- (NSInteger)minutesDifferenceForDate:(NSDate *)date subDate:(NSDate *)subDate subMode:(SSDateSubMode)mode;

/**
 计算 date 减去 subDate 的秒数差

 @param date 减数日期
 @param subDate 被减数日期
 @param mode 指定精确方式
 @return 计算 date 减去 subDate 的秒数差值
 */
- (NSInteger)secondsDifferenceForDate:(NSDate *)date subDate:(NSDate *)subDate subMode:(SSDateSubMode)mode;

/**
 计算 date 减去 subDate 的星期差

 @param date 减数日期
 @param subDate 被减数日期
 @param mode 指定星期开始方式
 @return 计算 date 减去 subDate 的星期差值
 */
- (NSInteger)weeksDifferenceForDate:(NSDate *)date subDate:(NSDate *)subDate subMode:(SSDateWeekMode)mode;

@end

#pragma mark - 日期拓展

@interface SSDateHelper (DayExpansion)

/**
 回到 date 分钟开始的时间: 2020-4-1 11:12:56 -> 2020-4-1 11:12:00

 @param date 指定日期
 @return NSDate
 */
- (NSDate *)minuteStartDateForDate:(NSDate *)date;
/**
 回到 date 小时开始的时间: 2020-4-1 11:12:56 -> 2020-4-1 11:00:00

 @param date 指定日期
 @return NSDate
 */
- (NSDate *)hourStartDateForDate:(NSDate *)date;
/**
 回到 date 天开始的时间: 2020-4-1 11:12:56 -> 2020-4-1 00:00:00

 @param date 指定日期
 @return NSDate
 */
- (NSDate *)dayStartDateForDate:(NSDate *)date;
/**
 回到 date 周开始的一天
 
 SSDateWeekModeDefault: 2020-4-1 11:12:56 -> 2020-3-29 00:00:00
 SSDateWeekModeUsually: 2020-4-1 11:12:56 -> 2020-3-30 00:00:00

 @param date 指定日期
 @param weekMode 周开始模式
 @return NSDate
 */
- (NSDate *)weekStartDateForDate:(NSDate *)date weekMode:(SSDateWeekMode)weekMode;
/**
 回到 date 月开始的一天

 @param date 指定日期: 2020-4-11 11:12:56 -> 2020-4-1 00:00:00
 @return NSDate
 */
- (NSDate *)monthStartDateForDate:(NSDate *)date;
/**
 回到 date 年开始的一天: 2020-4-1 11:12:56 -> 2020-1-1 00:00:00

 @param date 指定日期
 @return NSDate
 */
- (NSDate *)yearStartDateForDate:(NSDate *)date;

@end

#pragma mark - 月份拓展

@interface SSDateHelper (MonthExpansion)

/**
 获取当前月份的总天数
 */
- (NSInteger)dayNumberOfCurrentMonth;

/**
 获取指定日期的月份的总天数

 @param date 指定日期
 @return 指定日期的月份的总天数
 */
- (NSInteger)dayNumberOfMonthForDate:(NSDate *)date;

/**
 获取上个月1号的日期
 */
- (NSDate *)firstDateOfLastMonth;

/**
 获取当前月1号的日期
 */
- (NSDate *)firstDateOfCurrentMonth;

/**
 获取下个月1号的日期
 */
- (NSDate *)firstDateOfNextMonth;

/**
 获取指定日期的月份1号的日期
 */
- (NSDate *)firstDateOfMonthForDate:(NSDate *)date;

/**
 获取以指定日期的月份为基准，进行偏移后的月份1号的日期

 @param date 指定日期
 @param number 月份偏移量
 @return 以指定日期的月份为基准，进行偏移后的月份1号的日期
 */
- (NSDate *)firstDateOfMonthForDate:(NSDate *)date monthsLater:(NSInteger)number;

@end

#pragma mark - 日期区间

@interface SSDateHelper (DateRange)

/**
 判断 dates 里所有元素是否是一个连续的日期段，只比较年月日
 栗子1: dates = [2020-03-22, 2020-03-23, 2020-03-24, 2020-03-21];
 栗子2: dates = [2020-03-22, 2020-03-23, 2020-03-24, 2020-03-26];
 
 @param dates 日期数组
 @return dates 如栗子1时 yes，如栗子2时 no
 */
- (BOOL)isContinuousDateRangeForDates:(NSArray<NSDate *> *)dates;

/**
 判断 date 是否在[fromDate, toDate]里，只比较年月日
 
 @param date 指定日期
 @param fromDate DateRange 开始日期
 @param toDate DateRange 结束日期
 @return 只有 date 在[fromDate, toDate]里时 yes，否则 no。
 */
- (BOOL)isExsitDateRangeForDate:(NSDate *)date fromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;

/**
 获取日期数组里从最早时间开始的一个连续的日期区间的拼接字符
 例如：dateArray = [2020-03-01, 2020-03-02, 2020-03-03, 2020-03-05, 2020-03-06, 2020-03-07, 2020-03-08]
 返回  @"2019年3月1日 - 2019年3月3日"
 
 @param dateArray 日期数组
 @param dateFormat 指定日期格式，默认格式为 y年M月d日
 @return 日期数组里从最早时间开始的一个连续的日期区间拼接字符
 */
- (NSString *)dateRangeStringFromDates:(NSArray<NSDate *> *)dateArray dateFormat:(NSString *)dateFormat;

/**
 获取[fromDate, toDate]的日期区间的拼接字符（做了早晚判定，所以不需要特别在意两个日期的顺序）
 例如：fromDate = 2020-03-01  toDate = 2020-03-07
 返回 @"2019年3月1日 - 2019年3月7日"

 @param fromDate 开始日期
 @param toDate 结束日期
 @param dateFormat 指定日期格式，默认格式为2019年3月4日
 @return [fromDate, toDate]的日期区间的拼接字符
 */
- (NSString *)dateRangeStringFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate dateFormat:(NSString *)dateFormat;

/**
 获取包含[fromDate, toDate]的日期区间里所有的日期的数组

 @param fromDate 开始日期
 @param toDate 结束日期
 @return 包含[fromDate, toDate]的日期区间里所有日期的数组
 */
- (NSArray<NSDate *> *)datesFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;

/**
 获取日期数组里最早的日期

 @param dateArray 日期数组
 @return 日期数组里最早的日期
 */
- (NSDate *)earliestDateFromDates:(NSArray<NSDate *> *)dateArray;

/**
 获取日期数组里最晚的日期

 @param dateArray 日期数组
 @return 日期数组里最晚的日期
 */
- (NSDate *)latestDateFromDates:(NSArray<NSDate *> *)dateArray;

@end

#pragma mark - 其他拓展

@interface SSDateHelper (Other)

/**
 根据指定日期获取特定的时间描述

 @param date 指定日期
 @param isShowTime 是否显示时间
 @return 特定的时间描述
 */
- (NSString *)ss_timeDescriptionFromDate:(NSDate *)date showTime:(BOOL)isShowTime;

@end

NS_ASSUME_NONNULL_END
