//
//  SSDateHelper.m
//  SSDateHelper
//
//  Created by SunSatan on 20/3/22.
//  Copyright © 2020年 SunSatan. All rights reserved.
//

#import "SSDateHelper.h"

static NSString * const kEmptyString = @"";

static NSTimeInterval const kHoursOfDay      = 24;
static NSTimeInterval const kMinuteOfHour    = 60;
static NSTimeInterval const kSecondsOfMinute = 60;
static NSTimeInterval const kSecondsOfHour   = kSecondsOfMinute * kMinuteOfHour;
static NSTimeInterval const kSecondsOfDay    = kSecondsOfHour   * kHoursOfDay;
static NSTimeInterval const kMinuteOfDay     = kMinuteOfHour    * kHoursOfDay;

static char * const kChineseCalendarYears[] = {
    "甲子","乙丑","丙寅","丁卯","戊辰","己巳","庚午","辛未","壬申","癸酉",
    "甲戌","乙亥","丙子","丁丑","戊寅","己卯","庚辰","辛己","壬午","癸未",
    "甲申","乙酉","丙戌","丁亥","戊子","己丑","庚寅","辛卯","壬辰","癸巳",
    "甲午","乙未","丙申","丁酉","戊戌","己亥","庚子","辛丑","壬寅","癸丑",
    "甲辰","乙巳","丙午","丁未","戊申","己酉","庚戌","辛亥","壬子","癸丑",
    "甲寅","乙卯","丙辰","丁巳","戊午","己未","庚申","辛酉","壬戌","癸亥"
};

static char * const kChineseCalendarMonths[] = {
    "正月","二月","三月","四月","五月","六月","七月","八月","九月","十月","冬月","腊月"
};

static char * const kChineseCalendarDays[] = {
    "初一","初二","初三","初四","初五","初六","初七","初八","初九","初十",
    "十一","十二","十三","十四","十五","十六","十七","十八","十九","二十",
    "廿一","廿二","廿三","廿四","廿五","廿六","廿七","廿八","廿九","三十"
};

static char * const kChineseZodiac[] = {
    "鼠","牛","虎","兔","龙","蛇","马","羊","猴","鸡","狗","猪"
};

static char * const kHeavenlyStems[] = {
    "甲","乙","丙","丁","戊","己","庚","辛","壬","癸"
};

static char * const kEarthlyBranches[] = {
    "子","丑","寅","卯","辰","巳","午","未","申","酉","戌","亥"
};

@interface SSDateHelper ()

@property (atomic, strong) NSDateFormatter *dateFormatter;
@property (atomic, strong) NSCalendar *chineseCalendar;

@end

@implementation SSDateHelper

#pragma mark - 单例模式

static SSDateHelper *_mainHelper = nil;

+ (instancetype)main
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _mainHelper = [[super allocWithZone:nil] init];
        _mainHelper.dateFormatter = [[NSDateFormatter alloc] init];
        _mainHelper.chineseCalendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierChinese];
    });
    return _mainHelper;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    return [self main];
}

- (id)copyWithZone:(struct _NSZone *)zone
{
    return _mainHelper;
}

- (id)mutableCopyWithZone:(NSZone *)zone
{
    return _mainHelper;
}

#pragma mark - 错误信息打印

- (void)PrintErrorMessagesWithSelector:(SEL)sel
                             parameter:(NSString *)parmName
                           returnValue:(NSString *)returnValue
{
    NSLog(@"'-[SSDateHelper %@]' %@ is nil, so return %@.", NSStringFromSelector(sel), parmName, returnValue);
}

#pragma mark - NSDate 转为 NSString

- (NSString *)ol_DMY_stringFromDate:(NSDate *)date
{
    if (!date) {
        [self PrintErrorMessagesWithSelector:_cmd
                                   parameter:@"date"
                                 returnValue:@"EmptyString"];
        return kEmptyString;
    }
    self.dateFormatter.dateFormat = @"d/M/y";
    return [self.dateFormatter stringFromDate:date];
}

- (NSString *)ol_DMYHM_stringFromDate:(NSDate *)date
{
    if (!date) {
        [self PrintErrorMessagesWithSelector:_cmd
                                   parameter:@"date"
                                 returnValue:@"EmptyString"];
        return kEmptyString;
    }
    self.dateFormatter.dateFormat = @"d/M/y H:m";
    return [self.dateFormatter stringFromDate:date];
}

- (NSString *)dot_YMD_stringFromDate:(NSDate *)date
{
    if (!date) {
        [self PrintErrorMessagesWithSelector:_cmd
                                   parameter:@"date"
                                 returnValue:@"EmptyString"];
        return kEmptyString;
    }
    self.dateFormatter.dateFormat = @"y.M.d";
    return [self.dateFormatter stringFromDate:date];
}

- (NSString *)dot_YMDHM_stringFromDate:(NSDate *)date
{
    if (!date) {
        [self PrintErrorMessagesWithSelector:_cmd
                                   parameter:@"date"
                                 returnValue:@"EmptyString"];
        return kEmptyString;
    }
    self.dateFormatter.dateFormat = @"y.M.d H:m";
    return [self.dateFormatter stringFromDate:date];
}

- (NSString *)hl_YMD_stringFromDate:(NSDate *)date
{
    if (!date) {
        [self PrintErrorMessagesWithSelector:_cmd
                                   parameter:@"date"
                                 returnValue:@"EmptyString"];
        return kEmptyString;
    }
    self.dateFormatter.dateFormat = @"y-M-d";
    return [self.dateFormatter stringFromDate:date];
}

- (NSString *)hl_YYYYMMDD_stringFromDate:(NSDate *)date
{
    if (!date) {
        [self PrintErrorMessagesWithSelector:_cmd
                                   parameter:@"date"
                                 returnValue:@"EmptyString"];
        return kEmptyString;
    }
    self.dateFormatter.dateFormat = @"yyyy-MM-dd";
    return [self.dateFormatter stringFromDate:date];
}

- (NSString *)hl_YMDHM_stringFromDate:(NSDate *)date
{
    if (!date) {
        [self PrintErrorMessagesWithSelector:_cmd
                                   parameter:@"date"
                                 returnValue:@"EmptyString"];
        return kEmptyString;
    }
    self.dateFormatter.dateFormat = @"y-M-d H:m";
    return [self.dateFormatter stringFromDate:date];
}

- (NSString *)hl_YMDHMS_stringFromDate:(NSDate *)date
{
    if (!date) {
        [self PrintErrorMessagesWithSelector:_cmd
                                   parameter:@"date"
                                 returnValue:@"EmptyString"];
        return kEmptyString;
    }
    self.dateFormatter.dateFormat = @"y-M-d H:m:s";
    return [self.dateFormatter stringFromDate:date];
}

- (NSString *)cn_YMD_stringFromDate:(NSDate *)date
{
    if (!date) {
        [self PrintErrorMessagesWithSelector:_cmd
                                   parameter:@"date"
                                 returnValue:@"EmptyString"];
        return kEmptyString;
    }
    self.dateFormatter.dateFormat = @"y年M月d日";
    return [self.dateFormatter stringFromDate:date];
}

- (NSString *)cn_YMDHM_stringFromDate:(NSDate *)date
{
    if (!date) {
        [self PrintErrorMessagesWithSelector:_cmd
                                   parameter:@"date"
                                 returnValue:@"EmptyString"];
        return kEmptyString;
    }
    self.dateFormatter.dateFormat = @"y年M月d日 H:m";
    return [self.dateFormatter stringFromDate:date];
}

- (NSString *)cn_YMDHMS_stringFromDate:(NSDate *)date
{
    if (!date) {
        [self PrintErrorMessagesWithSelector:_cmd
                                   parameter:@"date"
                                 returnValue:@"EmptyString"];
        return kEmptyString;
    }
    self.dateFormatter.dateFormat = @"y年M月d日 H:m:s";
    return [self.dateFormatter stringFromDate:date];
}

- (NSString *)cn_MD_stringFromDate:(NSDate *)date
{
    if (!date) {
        [self PrintErrorMessagesWithSelector:_cmd
                                   parameter:@"date"
                                 returnValue:@"EmptyString"];
        return kEmptyString;
    }
    self.dateFormatter.dateFormat = @"M月d日";
    return [self.dateFormatter stringFromDate:date];
}

- (NSString *)HM_stringFromDate:(NSDate *)date
{
    if (!date) {
        [self PrintErrorMessagesWithSelector:_cmd
                                   parameter:@"date"
                                 returnValue:@"EmptyString"];
        return kEmptyString;
    }
    self.dateFormatter.dateFormat = @"H:m";
    return [self.dateFormatter stringFromDate:date];
}

- (NSString *)HMS_stringFromDate:(NSDate *)date
{
    if (!date) {
        [self PrintErrorMessagesWithSelector:_cmd
                                   parameter:@"date"
                                 returnValue:@"EmptyString"];
        return kEmptyString;
    }
    self.dateFormatter.dateFormat = @"H:m:s";
    return [self.dateFormatter stringFromDate:date];
}

- (NSString *)HHMM_stringFromDate:(NSDate *)date
{
    if (!date) {
        [self PrintErrorMessagesWithSelector:_cmd
                                   parameter:@"date"
                                 returnValue:@"EmptyString"];
        return kEmptyString;
    }
    self.dateFormatter.dateFormat = @"HH:mm";
    return [self.dateFormatter stringFromDate:date];
}

- (NSString *)HHMMSS_stringFromDate:(NSDate *)date
{
    if (!date) {
        [self PrintErrorMessagesWithSelector:_cmd
                                   parameter:@"date"
                                 returnValue:@"EmptyString"];
        return kEmptyString;
    }
    self.dateFormatter.dateFormat = @"HH:mm:ss";
    return [self.dateFormatter stringFromDate:date];
}

- (NSString *)weekStringFromDate:(NSDate *)date
{
    if (!date) {
        [self PrintErrorMessagesWithSelector:_cmd
                                   parameter:@"date"
                                 returnValue:@"EmptyString"];
        return kEmptyString;
    }
    self.dateFormatter.dateFormat = @"eee";
    return [self.dateFormatter stringFromDate:date];
}

- (NSString *)weekdayStringFromDate:(NSDate *)date
{
    if (!date) {
        [self PrintErrorMessagesWithSelector:_cmd
                                   parameter:@"date"
                                 returnValue:@"EmptyString"];
        return kEmptyString;
    }
    self.dateFormatter.dateFormat = @"eeee";
    return [self.dateFormatter stringFromDate:date];
}

#pragma mark - NSString 转为 NSDate

- (NSDate *)ol_DMY_dateFromString:(NSString *)str
{
    if (!str || str.length <= 0) {
        [self PrintErrorMessagesWithSelector:_cmd
                                   parameter:@"str"
                                 returnValue:@"nil"];
        return nil;
    }
    self.dateFormatter.dateFormat = @"d/M/y";
    return [self.dateFormatter dateFromString:str];
}

- (NSDate *)ol_DMYHM_dateFromString:(NSString *)str
{
    if (!str || str.length <= 0) {
        [self PrintErrorMessagesWithSelector:_cmd
                                   parameter:@"str"
                                 returnValue:@"nil"];
        return nil;
    }
    self.dateFormatter.dateFormat = @"d/M/y H:m";
    return [self.dateFormatter dateFromString:str];
}

- (NSDate *)hl_YYYYMMDD_dateFromString:(NSString *)str
{
    if (!str || str.length <= 0) {
        [self PrintErrorMessagesWithSelector:_cmd
                                   parameter:@"str"
                                 returnValue:@"nil"];
        return nil;
    }
    self.dateFormatter.dateFormat = @"yyyy-MM-dd";
    return [self.dateFormatter dateFromString:str];
}

- (NSDate *)hl_YYYYMMDDHM_dateFromString:(NSString *)str
{
    if (!str || str.length <= 0) {
        [self PrintErrorMessagesWithSelector:_cmd
                                   parameter:@"str"
                                 returnValue:@"nil"];
        return nil;
    }
    self.dateFormatter.dateFormat = @"yyyy-MM-dd H:m";
    return [self.dateFormatter dateFromString:str];
}

- (NSDate *)hl_YYYYMMDDHHMM_dateFromString:(NSString *)str
{
    if (!str || str.length <= 0) {
        [self PrintErrorMessagesWithSelector:_cmd
                                   parameter:@"str"
                                 returnValue:@"nil"];
        return nil;
    }
    self.dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm";
    return [self.dateFormatter dateFromString:str];
}

- (NSDate *)hl_YYYYMMDDHMS_dateFromString:(NSString *)str
{
    if (!str || str.length <= 0) {
        [self PrintErrorMessagesWithSelector:_cmd
                                   parameter:@"str"
                                 returnValue:@"nil"];
        return nil;
    }
    self.dateFormatter.dateFormat = @"yyyy-MM-dd H:m:s";
    return [self.dateFormatter dateFromString:str];
}

- (NSDate *)hl_YYYYMMDDHHMMSS_dateFromString:(NSString *)str
{
    if (!str || str.length <= 0) {
        [self PrintErrorMessagesWithSelector:_cmd
                                   parameter:@"str"
                                 returnValue:@"nil"];
        return nil;
    }
    self.dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    return [self.dateFormatter dateFromString:str];
}

- (NSDate *)hl_MD_dateFromString:(NSString *)str
{
    if (!str || str.length <= 0) {
        [self PrintErrorMessagesWithSelector:_cmd
                                   parameter:@"str"
                                 returnValue:@"nil"];
        return nil;
    }
    self.dateFormatter.dateFormat = @"M-d";
    return [self.dateFormatter dateFromString:str];
}

- (NSDate *)hl_MMDD_dateFromString:(NSString *)str
{
    if (!str || str.length <= 0) {
        [self PrintErrorMessagesWithSelector:_cmd
                                   parameter:@"str"
                                 returnValue:@"nil"];
        return nil;
    }
    self.dateFormatter.dateFormat = @"MM-dd";
    return [self.dateFormatter dateFromString:str];
}

- (NSDate *)cn_YMD_dateFromString:(NSString *)str
{
    if (!str || str.length <= 0) {
        [self PrintErrorMessagesWithSelector:_cmd
                                   parameter:@"str"
                                 returnValue:@"nil"];
        return nil;
    }
    self.dateFormatter.dateFormat = @"y年M月d日";
    return [self.dateFormatter dateFromString:str];
}

- (NSDate *)cn_MD_dateFromString:(NSString *)str
{
    if (!str || str.length <= 0) {
        [self PrintErrorMessagesWithSelector:_cmd
                                   parameter:@"str"
                                 returnValue:@"nil"];
        return nil;
    }
    self.dateFormatter.dateFormat = @"M月d日";
    return [self.dateFormatter dateFromString:str];
}

- (NSDate *)cn_YMDHM_dateFromString:(NSString *)str
{
    if (!str || str.length <= 0) {
        [self PrintErrorMessagesWithSelector:_cmd
                                   parameter:@"str"
                                 returnValue:@"nil"];
        return nil;
    }
    self.dateFormatter.dateFormat = @"y年M月d日 H:m";
    return [self.dateFormatter dateFromString:str];
}

- (NSDate *)cn_MDHM_dateFromString:(NSString *)str
{
    if (!str || str.length <= 0) {
        [self PrintErrorMessagesWithSelector:_cmd
                                   parameter:@"str"
                                 returnValue:@"nil"];
        return nil;
    }
    self.dateFormatter.dateFormat = @"M月d日 H:m";
    return [self.dateFormatter dateFromString:str];
}

- (NSDate *)dot_YMD_dateFromString:(NSString *)str
{
    if (!str || str.length <= 0) {
        [self PrintErrorMessagesWithSelector:_cmd
                                   parameter:@"str"
                                 returnValue:@"nil"];
        return nil;
    }
    self.dateFormatter.dateFormat = @"y.M.d";
    return [self.dateFormatter dateFromString:str];
}

- (NSDate *)dot_MD_dateFromString:(NSString *)str
{
    if (!str || str.length <= 0) {
        [self PrintErrorMessagesWithSelector:_cmd
                                   parameter:@"str"
                                 returnValue:@"nil"];
        return nil;
    }
    self.dateFormatter.dateFormat = @"y.M.d H:m";
    return [self.dateFormatter dateFromString:str];
}

#pragma mark - 中国农历、生肖

- (NSString *)nl_YMD_stringFromDate:(NSDate *)date
{
    if (!date) {
        [self PrintErrorMessagesWithSelector:_cmd
                                   parameter:@"date"
                                 returnValue:@"EmptyString"];
        return kEmptyString;
    }
    NSDateComponents *dateComponents = [self.chineseCalendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
    
    NSString *year_str  = @(kChineseCalendarYears[dateComponents.year - 1]);
    NSString *month_str = @(kChineseCalendarMonths[dateComponents.month - 1]);
    NSString *day_str   = @(kChineseCalendarDays[dateComponents.day - 1]);
    NSString *cn_str = [NSString stringWithFormat:@"%@%@%@", year_str, month_str, day_str];
    return cn_str;
}

- (NSString *)nl_MD_stringFromDate:(NSDate *)date
{
    if (!date) {
        [self PrintErrorMessagesWithSelector:_cmd
                                   parameter:@"date"
                                 returnValue:@"EmptyString"];
        return kEmptyString;
    }
    NSDateComponents *dateComponents = [self.chineseCalendar components:NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
    
    NSString *month_str = @(kChineseCalendarMonths[dateComponents.month - 1]);
    NSString *day_str   = @(kChineseCalendarDays[dateComponents.day - 1]);
    NSString *cn_str = [NSString stringWithFormat:@"%@%@", month_str, day_str];
    return cn_str;
}

- (NSString *)nl_yearsStringFromDate:(NSDate *)date
{
    if (!date) {
        [self PrintErrorMessagesWithSelector:_cmd
                                   parameter:@"date"
                                 returnValue:@"EmptyString"];
        return kEmptyString;
    }
    NSDateComponents *dateComponents = [self.chineseCalendar components:NSCalendarUnitYear fromDate:date];
    
    NSString *year_str = @(kChineseCalendarYears[dateComponents.year - 1]);
    NSString *cn_str = [NSString stringWithFormat:@"%@", year_str];
    return cn_str;
}

- (NSString *)nl_monthStringFromDate:(NSDate *)date
{
    if (!date) {
        [self PrintErrorMessagesWithSelector:_cmd
                                   parameter:@"date"
                                 returnValue:@"EmptyString"];
        return kEmptyString;
    }
    NSDateComponents *dateComponents = [self.chineseCalendar components:NSCalendarUnitMonth fromDate:date];
    NSString *month_str = @(kChineseCalendarMonths[dateComponents.month - 1]);
    return month_str;
}

- (NSString *)nl_dayStringFromDate:(NSDate *)date
{
    if (!date) {
        [self PrintErrorMessagesWithSelector:_cmd
                                   parameter:@"date"
                                 returnValue:@"EmptyString"];
        return kEmptyString;
    }
    NSDateComponents *dateComponents = [self.chineseCalendar components:NSCalendarUnitDay fromDate:date];
    NSString *day_str = @(kChineseCalendarDays[dateComponents.day - 1]);
    return day_str;
}

- (NSString *)nl_zodiacStringFromDate:(NSDate *)date
{
    if (!date) {
        [self PrintErrorMessagesWithSelector:_cmd
                                   parameter:@"date"
                                 returnValue:@"EmptyString"];
        return kEmptyString;
    }
    NSDateComponents *dateComponents = [self.chineseCalendar components:NSCalendarUnitYear fromDate:date];
    NSInteger zodiacIndex = (dateComponents.year - 1) % 12;
    NSString *zodiac = @(kChineseZodiac[zodiacIndex]);
    return zodiac;
}

- (NSString *)nl_earthlyBranchesZodiacStringFromDate:(NSDate *)date
{
    if (!date) {
        [self PrintErrorMessagesWithSelector:_cmd
                                   parameter:@"date"
                                 returnValue:@"EmptyString"];
        return kEmptyString;
    }
    NSDateComponents *dateComponents = [self.chineseCalendar components:NSCalendarUnitYear fromDate:date];
    NSInteger index = (dateComponents.year - 1) % 12;
    NSString *zodiac = @(kChineseZodiac[index]);
    NSString *earthlyBranches = @(kEarthlyBranches[index]);
    NSString *str = [NSString stringWithFormat:@"%@%@", earthlyBranches, zodiac];
    return str;
}

#pragma mark - 判断、比较

- (BOOL)isTodayForDate:(NSDate *)date
{
    if (!date) {
        [self PrintErrorMessagesWithSelector:_cmd
                                   parameter:@"date"
                                 returnValue:@"NO"];
        return NO;
    }
    
    NSCalendarUnit unit = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay;
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:unit fromDate:date];
    NSDateComponents *todayComponents = [[NSCalendar currentCalendar] components:unit fromDate:[NSDate date]];
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDateComponents:dateComponents toDateComponents:todayComponents options:NSCalendarWrapComponents];
    BOOL sure = (comp.day == 0);
    return sure;
}

- (BOOL)isLeapYearForDate:(NSDate *)date
{
    if (!date) {
        [self PrintErrorMessagesWithSelector:_cmd
                                   parameter:@"date"
                                 returnValue:@"NO"];
        return NO;
    }
    
    NSInteger yearInteger = [[NSCalendar currentCalendar] component:NSCalendarUnitYear fromDate:date];
    //能被4整除但不能被100整除为普通闰年，能被400整除为世纪闰年
    if ((yearInteger % 4 == 0 && yearInteger % 100 != 0) ||
        yearInteger % 400 == 0) {
        return YES;
    }
    return NO;
}

- (BOOL)isSameDayFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate
{
    if (!toDate || !fromDate) {
        [self PrintErrorMessagesWithSelector:_cmd
                                   parameter:@"toDate/fromDate"
                                 returnValue:@"NO"];
        return NO;
    }
    
    NSCalendarUnit unit = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay;
    NSDateComponents *toDateComponents = [[NSCalendar currentCalendar] components:unit fromDate:toDate];
    NSDateComponents *fromDateComponents = [[NSCalendar currentCalendar] components:unit fromDate:fromDate];
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDateComponents:fromDateComponents toDateComponents:toDateComponents options:NSCalendarWrapComponents];
    BOOL sure = (comp.day == 0);
    return sure;
}

- (BOOL)isSameTimeFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate
{
    if (!toDate || !fromDate) {
        [self PrintErrorMessagesWithSelector:_cmd
                                   parameter:@"toDate/fromDate"
                                 returnValue:@"NO"];
        return NO;
    }
    
    NSCalendarUnit unit = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute;
    NSDateComponents *toDateComponents = [[NSCalendar currentCalendar] components:unit fromDate:toDate];
    NSDateComponents *fromDateComponents = [[NSCalendar currentCalendar] components:unit fromDate:fromDate];
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:NSCalendarUnitMinute fromDateComponents:fromDateComponents toDateComponents:toDateComponents options:NSCalendarWrapComponents];
    BOOL sure = (comp.minute == 0);
    return sure;
}

- (BOOL)isEarlierThanTodayForDate:(NSDate *)date
{
    if (!date) {
        [self PrintErrorMessagesWithSelector:_cmd
                                   parameter:@"date"
                                 returnValue:@"NO"];
        return NO;
    }
    
    NSCalendarUnit unit = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay;
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:unit fromDate:date];
    NSDateComponents *todayComponents = [[NSCalendar currentCalendar] components:unit fromDate:[NSDate date]];
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDateComponents:dateComponents toDateComponents:todayComponents options:NSCalendarWrapComponents];
    BOOL earlier = (comp.day > 0);
    return earlier;
}

- (BOOL)isLaterThanTodayForDate:(NSDate *)date
{
    if (!date) {
        [self PrintErrorMessagesWithSelector:_cmd
                                   parameter:@"date"
                                 returnValue:@"NO"];
        return NO;
    }
    
    NSCalendarUnit unit = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay;
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:unit fromDate:date];
    NSDateComponents *todayComponents = [[NSCalendar currentCalendar] components:unit fromDate:[NSDate date]];
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDateComponents:dateComponents toDateComponents:todayComponents options:NSCalendarWrapComponents];
    BOOL later = (comp.day < 0);
    return later;
}

- (BOOL)isEarlierThanPresentTimeForDate:(NSDate *)date
{
    if (!date) {
        [self PrintErrorMessagesWithSelector:_cmd
                                   parameter:@"date"
                                 returnValue:@"NO"];
        return NO;
    }
    
    NSCalendarUnit unit = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute;
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:unit fromDate:date];
    NSDateComponents *todayComponents = [[NSCalendar currentCalendar] components:unit fromDate:[NSDate date]];
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:NSCalendarUnitMinute fromDateComponents:dateComponents toDateComponents:todayComponents options:NSCalendarWrapComponents];
    BOOL sure = (comp.minute > 0);
    return sure;
}

- (BOOL)isLaterThanPresentTimeForDate:(NSDate *)date
{
    if (!date) {
        [self PrintErrorMessagesWithSelector:_cmd
                                   parameter:@"date"
                                 returnValue:@"NO"];
        return NO;
    }
    
    NSCalendarUnit unit = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute;
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:unit fromDate:date];
    NSDateComponents *todayComponents = [[NSCalendar currentCalendar] components:unit fromDate:[NSDate date]];
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:NSCalendarUnitMinute fromDateComponents:dateComponents toDateComponents:todayComponents options:NSCalendarWrapComponents];
    BOOL sure = (comp.minute < 0);
    return sure;
}

- (BOOL)isEarlierDayFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate
{
    if (!toDate || !fromDate) {
        [self PrintErrorMessagesWithSelector:_cmd
                                   parameter:@"toDate/fromDate"
                                 returnValue:@"NO"];
        return NO;
    }
    
    NSCalendarUnit unit = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay;
    NSDateComponents *toDateComponents = [[NSCalendar currentCalendar] components:unit fromDate:toDate];
    NSDateComponents *fromDateComponents = [[NSCalendar currentCalendar] components:unit fromDate:fromDate];
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDateComponents:fromDateComponents toDateComponents:toDateComponents options:NSCalendarWrapComponents];
    BOOL sure = (comp.day > 0);
    return sure;
}

- (BOOL)isLaterDayFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate
{
    if (!toDate || !fromDate) {
        [self PrintErrorMessagesWithSelector:_cmd
                                   parameter:@"toDate/fromDate"
                                 returnValue:@"NO"];
        return NO;
    }
    
    NSCalendarUnit unit = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay;
    NSDateComponents *toDateComponents = [[NSCalendar currentCalendar] components:unit fromDate:toDate];
    NSDateComponents *fromDateComponents = [[NSCalendar currentCalendar] components:unit fromDate:fromDate];
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDateComponents:fromDateComponents toDateComponents:toDateComponents options:NSCalendarWrapComponents];
    BOOL sure = (comp.day < 0);
    return sure;
}

- (BOOL)isEarlierTimeFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate
{
    if (!toDate || !fromDate) {
        [self PrintErrorMessagesWithSelector:_cmd
                                   parameter:@"toDate/fromDate"
                                 returnValue:@"NO"];
        return NO;
    }
    
    NSCalendarUnit unit = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute;
    NSDateComponents *toDateComponents = [[NSCalendar currentCalendar] components:unit fromDate:toDate];
    NSDateComponents *fromDateComponents = [[NSCalendar currentCalendar] components:unit fromDate:fromDate];
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:NSCalendarUnitMinute fromDateComponents:fromDateComponents toDateComponents:toDateComponents options:NSCalendarWrapComponents];
    BOOL sure = (comp.minute > 0);
    return sure;
}

- (BOOL)isLaterTimeFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate
{
    if (!toDate || !fromDate) {
        [self PrintErrorMessagesWithSelector:_cmd
                                   parameter:@"toDate/fromDate"
                                 returnValue:@"NO"];
        return NO;
    }
    
    NSCalendarUnit unit = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute;
    NSDateComponents *toDateComponents = [[NSCalendar currentCalendar] components:unit fromDate:toDate];
    NSDateComponents *fromDateComponents = [[NSCalendar currentCalendar] components:unit fromDate:fromDate];
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:NSCalendarUnitMinute fromDateComponents:fromDateComponents toDateComponents:toDateComponents options:NSCalendarWrapComponents];
    BOOL sure = (comp.minute < 0);
    return sure;
}

#pragma mark - 计算:增加、差值

- (NSDate *)dateByAddingYears:(NSInteger)years toDate:(NSDate *)toDate
{
    if (!toDate) {
        [self PrintErrorMessagesWithSelector:_cmd
                                   parameter:@"toDate"
                                 returnValue:@"nil"];
        return nil;
    }
    
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond fromDate:toDate];
    
    dateComponents.year += years;
    NSDate *date = [[NSCalendar currentCalendar] dateFromComponents:dateComponents];
    return date;
}

- (NSDate *)dateByAddingMonths:(NSInteger)months toDate:(NSDate *)toDate
{
    if (!toDate) {
        [self PrintErrorMessagesWithSelector:_cmd
                                   parameter:@"toDate"
                                 returnValue:@"nil"];
        return nil;
    }
    
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond fromDate:toDate];
    
    NSInteger moveYears  = months/12;
    NSInteger moveMonths = months%12;
    dateComponents.year += moveYears;
    dateComponents.month += moveMonths;
    
    NSDate *date = [[NSCalendar currentCalendar] dateFromComponents:dateComponents];
    return date;
}

- (NSDate *)dateByAddingDays:(NSTimeInterval)days toDate:(NSDate *)toDate
{
    if (!toDate) {
        [self PrintErrorMessagesWithSelector:_cmd
                                   parameter:@"toDate"
                                 returnValue:@"nil"];
        return nil;
    }
    NSDate *date = [toDate dateByAddingTimeInterval:days * kSecondsOfDay];
    return date;
}

- (NSDate *)dateByAddingHours:(NSTimeInterval)hours toDate:(NSDate *)toDate
{
    if (!toDate) {
        [self PrintErrorMessagesWithSelector:_cmd
                                   parameter:@"toDate"
                                 returnValue:@"nil"];
        return nil;
    }
    NSDate *date = [toDate dateByAddingTimeInterval:hours * kSecondsOfHour];
    return date;
}

- (NSDate *)dateByAddingMinutes:(NSTimeInterval)minutes toDate:(NSDate *)toDate
{
    if (!toDate) {
        [self PrintErrorMessagesWithSelector:_cmd
                                   parameter:@"toDate"
                                 returnValue:@"nil"];
        return nil;
    }
    NSDate *date = [toDate dateByAddingTimeInterval:minutes * kSecondsOfMinute];
    return date;
}

- (NSDate *)dateByAddingSeconds:(NSTimeInterval)seconds toDate:(NSDate *)toDate
{
    if (!toDate) {
        [self PrintErrorMessagesWithSelector:_cmd
                                   parameter:@"toDate"
                                 returnValue:@"nil"];
        return nil;
    }
    NSDate *date = [toDate dateByAddingTimeInterval:seconds];
    return date;
}

- (NSInteger)yearsDifferenceForDate:(NSDate *)date subDate:(NSDate *)subDate subMode:(SSDateSubMode)mode
{
    if (!date || !subDate) {
        [self PrintErrorMessagesWithSelector:_cmd
                                   parameter:@"date/subDate"
                                 returnValue:@"0"];
        return 0;
    }
    
    NSCalendarUnit unit;
    if (mode == SSDateSubModeRelative) {
        unit = NSCalendarUnitYear;
    }
    else if (mode == SSDateSubModeDate) {
        unit = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay;
    }
    else if (mode == SSDateSubModeTime) {
        unit = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond;
    }
    
    NSDateComponents *dateComp = [[NSCalendar currentCalendar] components:unit fromDate:date];
    NSDateComponents *subDateComp = [[NSCalendar currentCalendar] components:unit fromDate:subDate];
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDateComponents:subDateComp toDateComponents:dateComp options:NSCalendarWrapComponents];
    return comp.year;
}

- (NSInteger)monthsDifferenceForDate:(NSDate *)date subDate:(NSDate *)subDate subMode:(SSDateSubMode)mode
{
    if (!date || !subDate) {
        [self PrintErrorMessagesWithSelector:_cmd
                                   parameter:@"date/subDate"
                                 returnValue:@"0"];
        return 0;
    }
    
    NSCalendarUnit unit;
    if (mode == SSDateSubModeRelative) {
        unit = NSCalendarUnitYear|NSCalendarUnitMonth;
    }
    else if (mode == SSDateSubModeDate) {
        unit = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay;
    }
    else if (mode == SSDateSubModeTime) {
        unit = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond;
    }
    
    NSDateComponents *dateComp = [[NSCalendar currentCalendar] components:unit fromDate:date];
    NSDateComponents *subDateComp = [[NSCalendar currentCalendar] components:unit fromDate:subDate];
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDateComponents:subDateComp toDateComponents:dateComp options:NSCalendarWrapComponents];
    return comp.month;
}

- (NSInteger)daysDifferenceForDate:(NSDate *)date subDate:(NSDate *)subDate subMode:(SSDateSubMode)mode
{
    if (!date || !subDate) {
        [self PrintErrorMessagesWithSelector:_cmd
                                   parameter:@"date/subDate"
                                 returnValue:@"0"];
        return 0;
    }
    
    NSCalendarUnit unit;
    if (mode == SSDateSubModeRelative || mode == SSDateSubModeDate) {
        unit = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay;
    }
    else if (mode == SSDateSubModeTime) {
        unit = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond;
    }
    
    NSDateComponents *dateComp = [[NSCalendar currentCalendar] components:unit fromDate:date];
    NSDateComponents *subDateComp = [[NSCalendar currentCalendar] components:unit fromDate:subDate];
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDateComponents:subDateComp toDateComponents:dateComp options:NSCalendarWrapComponents];
    return comp.day;
}

- (NSInteger)hoursDifferenceForDate:(NSDate *)date subDate:(NSDate *)subDate subMode:(SSDateSubMode)mode
{
    if (!date || !subDate) {
        [self PrintErrorMessagesWithSelector:_cmd
                                   parameter:@"date/subDate"
                                 returnValue:@"0"];
        return 0;
    }
    
    NSCalendarUnit unit;
    if (mode == SSDateSubModeRelative || mode == SSDateSubModeDate) {
        unit = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour;
    }
    else if (mode == SSDateSubModeTime) {
        unit = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond;
    }
    
    NSDateComponents *dateComp = [[NSCalendar currentCalendar] components:unit fromDate:date];
    NSDateComponents *subDateComp = [[NSCalendar currentCalendar] components:unit fromDate:subDate];
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:NSCalendarUnitHour fromDateComponents:subDateComp toDateComponents:dateComp options:NSCalendarWrapComponents];
    return comp.hour;
}

- (NSInteger)minutesDifferenceForDate:(NSDate *)date subDate:(NSDate *)subDate subMode:(SSDateSubMode)mode
{
    if (!date || !subDate) {
        [self PrintErrorMessagesWithSelector:_cmd
                                   parameter:@"date/subDate"
                                 returnValue:@"0"];
        return 0;
    }
    
    NSCalendarUnit unit;
    if (mode == SSDateSubModeRelative || mode == SSDateSubModeDate) {
        unit = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute;
    }
    else if (mode == SSDateSubModeTime) {
        unit = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond;
    }
    
    NSDateComponents *dateComp = [[NSCalendar currentCalendar] components:unit fromDate:date];
    NSDateComponents *subDateComp = [[NSCalendar currentCalendar] components:unit fromDate:subDate];
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:NSCalendarUnitMinute fromDateComponents:subDateComp toDateComponents:dateComp options:NSCalendarWrapComponents];
    return comp.minute;
}

- (NSInteger)secondsDifferenceForDate:(NSDate *)date subDate:(NSDate *)subDate subMode:(SSDateSubMode)mode
{
    if (!date || !subDate) {
        [self PrintErrorMessagesWithSelector:_cmd
                                   parameter:@"date/subDate"
                                 returnValue:@"0"];
        return 0;
    }
    
    NSCalendarUnit unit = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond;
    
    NSDateComponents *dateComp = [[NSCalendar currentCalendar] components:unit fromDate:date];
    NSDateComponents *subDateComp = [[NSCalendar currentCalendar] components:unit fromDate:subDate];
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:NSCalendarUnitSecond fromDateComponents:subDateComp toDateComponents:dateComp options:NSCalendarWrapComponents];
    return comp.second;
}

- (NSInteger)weeksDifferenceForDate:(NSDate *)date subDate:(NSDate *)subDate subMode:(SSDateWeekMode)mode
{
    if (!date || !subDate) {
        [self PrintErrorMessagesWithSelector:_cmd
                                   parameter:@"date/subDate"
                                 returnValue:@"0"];
        return 0;
    }
    
    NSCalendarUnit unit = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday;
    NSDateComponents *dateComp = [[NSCalendar currentCalendar] components:unit fromDate:date];
    NSDateComponents *subDateComp = [[NSCalendar currentCalendar] components:unit fromDate:subDate];
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDateComponents:subDateComp toDateComponents:dateComp options:NSCalendarWrapComponents];
    
    if (mode == SSDateWeekModeUsually) {
        //如果以我们平时习惯的周天为周末，就要重新架构weekday的排序。
        //需要先把默认weekday往前移一位，在把代表周天的0移到7。
        dateComp.weekday -= 1;
        subDateComp.weekday -= 1;
        dateComp.weekday = (dateComp.weekday == 0) ? 7 : dateComp.weekday;
        subDateComp.weekday = (subDateComp.weekday == 0) ? 7 : subDateComp.weekday;
    }
    
    NSInteger weekdayDifference = dateComp.weekday - subDateComp.weekday;
    NSInteger dayDifference = comp.day;
    NSInteger weekDifference = (dayDifference - weekdayDifference) / 7;
    return weekDifference;
}

#pragma mark - 日期拓展

- (NSDate *)minuteLastDateForDate:(NSDate *)date
{
    if (!date) {
        [self PrintErrorMessagesWithSelector:_cmd
                                   parameter:@"date"
                                 returnValue:@"nil"];
        return nil;
    }
    
    NSCalendarUnit unit = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute;
    NSDateComponents *dateComp = [[NSCalendar currentCalendar] components:unit fromDate:date];
    NSDate *minuteLastDate = [[NSCalendar currentCalendar] dateFromComponents:dateComp];
    return minuteLastDate;
}

- (NSDate *)hourLastDateForDate:(NSDate *)date
{
    if (!date) {
        [self PrintErrorMessagesWithSelector:_cmd
                                   parameter:@"date"
                                 returnValue:@"nil"];
        return nil;
    }
    
    NSCalendarUnit unit = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour;
    NSDateComponents *dateComp = [[NSCalendar currentCalendar] components:unit fromDate:date];
    NSDate *hourLastDate = [[NSCalendar currentCalendar] dateFromComponents:dateComp];
    return hourLastDate;
}

- (NSDate *)dayStartDateForDate:(NSDate *)date
{
    if (!date) {
        [self PrintErrorMessagesWithSelector:_cmd
                                   parameter:@"date"
                                 returnValue:@"nil"];
        return nil;
    }
    
    NSCalendarUnit unit = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay;
    NSDateComponents *dateComp = [[NSCalendar currentCalendar] components:unit fromDate:date];
    NSDate *dayStartDate = [[NSCalendar currentCalendar] dateFromComponents:dateComp];
    return dayStartDate;
}

- (NSDate *)weekStartDateForDate:(NSDate *)date weekMode:(SSDateWeekMode)weekMode
{
    if (!date) {
        [self PrintErrorMessagesWithSelector:_cmd parameter:@"date" returnValue:@"nil"];
        return nil;
    }
    
    NSCalendarUnit unit = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday;
    NSDateComponents *dateComp = [[NSCalendar currentCalendar] components:unit fromDate:date];
    
    //weekday从1-7，1是周日，2是周一，以此类推
    static int const defaultArray[8] = {0, 0, 1, 2, 3, 4, 5, 6};
    static int const usuallyArray[8] = {0, 6, 0, 1, 2, 3, 4, 5};
    
    int num = (weekMode == SSDateWeekModeDefault) ? defaultArray[dateComp.weekday] : usuallyArray[dateComp.weekday];
    
    dateComp.day = dateComp.day - num;
    
    NSDate *weekStartDate = [[NSCalendar currentCalendar] dateFromComponents:dateComp];
    return weekStartDate;
}

- (NSDate *)monthStartDateForDate:(NSDate *)date
{
    if (!date) {
        [self PrintErrorMessagesWithSelector:_cmd
                                   parameter:@"date"
                                 returnValue:@"nil"];
        return nil;
    }
    
    NSCalendarUnit unit = NSCalendarUnitYear|NSCalendarUnitMonth;
    NSDateComponents *dateComp = [[NSCalendar currentCalendar] components:unit fromDate:date];
    NSDate *monthStartDate = [[NSCalendar currentCalendar] dateFromComponents:dateComp];
    return monthStartDate;
}

- (NSDate *)yearStartDateForDate:(NSDate *)date
{
    if (!date) {
        [self PrintErrorMessagesWithSelector:_cmd
                                   parameter:@"date"
                                 returnValue:@"nil"];
        return nil;
    }
    
    NSCalendarUnit unit = NSCalendarUnitYear;
    NSDateComponents *dateComp = [[NSCalendar currentCalendar] components:unit fromDate:date];
    NSDate *yearStartDate = [[NSCalendar currentCalendar] dateFromComponents:dateComp];
    return yearStartDate;
}

#pragma mark - 月份拓展

- (NSInteger)dayNumberOfCurrentMonth
{
    return [self dayNumberOfMonthForDate:[NSDate date]];
}

- (NSInteger)dayNumberOfMonthForDate:(NSDate *)date
{
    if (!date) {
        [self PrintErrorMessagesWithSelector:_cmd
                                   parameter:@"date"
                                 returnValue:@"0"];
        return 0;
    }
    
    NSRange dayRange = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return dayRange.length;
}

- (NSDate *)firstDateOfLastMonth
{
    return [self firstDateOfMonthForDate:[NSDate date] monthsLater:-1];
}

- (NSDate *)firstDateOfCurrentMonth
{
    return [self firstDateOfMonthForDate:[NSDate date] monthsLater:0];
}

- (NSDate *)firstDateOfNextMonth
{
    return [self firstDateOfMonthForDate:[NSDate date] monthsLater:1];
}

- (NSDate *)firstDateOfMonthForDate:(NSDate *)date
{
    return [self firstDateOfMonthForDate:date monthsLater:0];
}

- (NSDate *)firstDateOfMonthForDate:(NSDate *)date monthsLater:(NSInteger)number
{
    if (!date) {
        [self PrintErrorMessagesWithSelector:_cmd
                                   parameter:@"date"
                                 returnValue:@"nil"];
        return nil;
    }
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
    //日期设为1号
    dateComponents.day = 1;
    //设置年份和月份
    NSInteger moveYears  = number/12;
    NSInteger moveMonths = number%12;
    dateComponents.year  = dateComponents.year  + moveYears;
    dateComponents.month = dateComponents.month + moveMonths;
    
    NSDate *firstDateOfMonth = [[NSCalendar currentCalendar] dateFromComponents:dateComponents];
    return firstDateOfMonth;
}

#pragma mark - 日期区间

- (BOOL)isContinuousDateRangeForDates:(NSArray<NSDate *> *)dates
{
    if (!dates) {
        [self PrintErrorMessagesWithSelector:_cmd
                                   parameter:@"dates"
                                 returnValue:@"NO"];
        return YES;
    }
    if (dates.count <= 1) {
        return YES;
    }
    NSArray *dateSortArray = [dates sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
    
    BOOL flag = YES;
    for (int i=0, j=1; j<dateSortArray.count; i++, j++) {
        NSDateComponents *dateComponentsI = [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:dateSortArray[i]];
        NSDateComponents *dateComponentsJ = [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:dateSortArray[j]];
        
        NSDateComponents *compare = [[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDateComponents:dateComponentsI toDateComponents:dateComponentsJ options:NSCalendarWrapComponents];
        if (compare.day != 1) {
            flag = NO;
            break;
        }
    }
    return flag;
}

- (BOOL)isExsitDateRangeForDate:(NSDate *)date fromDate:(NSDate *)fromDate toDate:(NSDate *)toDate
{
    if (!date) {
        [self PrintErrorMessagesWithSelector:_cmd
                                   parameter:@"date"
                                 returnValue:@"NO"];
        return NO;
    }
    if (!fromDate || !toDate) {
        [self PrintErrorMessagesWithSelector:_cmd
                                   parameter:@"fromDate/toDate"
                                 returnValue:@"NO"];
        return NO;
    }
    NSDate *startDate = [fromDate earlierDate:toDate];
    NSDate *endDate   = [fromDate laterDate:toDate];
    
    NSCalendarUnit unit = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay;
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:unit fromDate:date];
    NSDateComponents *startDateComponents = [[NSCalendar currentCalendar] components:unit fromDate:startDate];
    NSDateComponents *endDateComponents = [[NSCalendar currentCalendar] components:unit fromDate:endDate];
    NSDateComponents *startComp = [[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDateComponents:startDateComponents toDateComponents:dateComponents options:NSCalendarWrapComponents];
    NSDateComponents *endComp = [[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDateComponents:dateComponents toDateComponents:endDateComponents options:NSCalendarWrapComponents];
    BOOL sure = (startComp.day >= 0 && endComp.day >= 0);
    return sure;
}

- (NSString *)dateRangeStringFromDates:(NSArray<NSDate *> *)dateArray dateFormat:(NSString *)dateFormat
{
    if (!dateArray) {
        [self PrintErrorMessagesWithSelector:_cmd
                                   parameter:@"dateArray"
                                 returnValue:@"EmptyString"];
        return kEmptyString;
    }
    
    self.dateFormatter.dateFormat = @"y年M月d日";
    if (dateFormat && dateFormat.length > 0) {
        self.dateFormatter.dateFormat = dateFormat;
    }
    
    if (dateArray.count == 1) {
        return [self.dateFormatter stringFromDate:dateArray.firstObject];
    }
    
    NSArray *dates = [dateArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
    
    NSDate *startDate = dates.firstObject;
    NSDate *endDate   = dates.lastObject;
    
    for (int i=0, j=1; j<dates.count; i++, j++) {
        NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDate:dates[i] toDate:dates[j] options:NSCalendarWrapComponents];
        if (!(dateComponents.day == 1 || dateComponents.day == 0)) {
            endDate = dates[i];
            break;
        }
    }
    
    if ([self isSameDayFromDate:startDate toDate:endDate]) {
        NSString *dateStr = [self.dateFormatter stringFromDate:startDate];
        return dateStr;
    }
    
    NSString *startDateStr = [self.dateFormatter stringFromDate:startDate];
    NSString *endDateStr   = [self.dateFormatter stringFromDate:endDate];
    NSString *dateRange = [NSString stringWithFormat:@"%@-%@", startDateStr, endDateStr];
    return dateRange;
}

- (NSString *)dateRangeStringFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate dateFormat:(NSString *)dateFormat
{
    if (!fromDate || !toDate) {
        [self PrintErrorMessagesWithSelector:_cmd
                                   parameter:@"fromDate/toDate"
                                 returnValue:@"EmptyString"];
        return kEmptyString;
    }
    
    self.dateFormatter.dateFormat = @"y年M月d日";
    if (dateFormat && dateFormat.length > 0) {
        self.dateFormatter.dateFormat = dateFormat;
    }
    
    NSDate *startDate = [fromDate earlierDate:toDate];
    NSDate *endDate   = [fromDate laterDate:toDate];
    NSString *startDateStr = [self.dateFormatter stringFromDate:startDate];
    NSString *endDateStr   = [self.dateFormatter stringFromDate:endDate];
    NSString *dateRange = [NSString stringWithFormat:@"%@-%@", startDateStr, endDateStr];
    return dateRange;
}

- (NSArray<NSDate *> *)datesFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate
{
    if (!fromDate || !toDate) {
        [self PrintErrorMessagesWithSelector:_cmd
                                   parameter:@"fromDate/toDate"
                                 returnValue:@"nil"];
        return nil;
    }
    
    NSMutableArray *dateArray = [NSMutableArray array];
    
    NSDate *startDate = [fromDate earlierDate:toDate];
    NSDate *endDate   = [fromDate laterDate:toDate];
    NSDate *tmpDate = [NSDate dateWithTimeInterval:0 sinceDate:startDate];
    while (1) {
        if ([self isLaterDayFromDate:tmpDate toDate:endDate]) {
            break;
        }
        [dateArray addObject:tmpDate];
        tmpDate = [tmpDate dateByAddingTimeInterval:kSecondsOfDay];
    }
    return dateArray;
}

#pragma mark - 其他拓展

- (NSString *)ss_timeDescriptionFromDate:(NSDate *)date showTime:(BOOL)isShowTime
{
    if (!date) {
        [self PrintErrorMessagesWithSelector:_cmd
                                   parameter:@"date"
                                 returnValue:@"EmptyString"];
        return kEmptyString;
    }
    
    NSInteger daysCount = [self daysDifferenceForDate:[NSDate date]
                                              subDate:date
                                              subMode:SSDateSubModeRelative];
    NSInteger weeksCount = [self weeksDifferenceForDate:[NSDate date]
                                                subDate:date
                                                subMode:SSDateWeekModeUsually];
    NSInteger yearsCount = [self yearsDifferenceForDate:[NSDate date]
                                                subDate:date
                                                subMode:SSDateSubModeRelative];
    
    NSString *timeDescription = [self cn_MD_stringFromDate:date];
    NSString *time = [self HHMM_stringFromDate:date];
    
    if ([self isTodayForDate:date]) {
        timeDescription = @"今天";
    }
    else if (daysCount == 1) {
        timeDescription = @"昨天";
    }
    else if (daysCount == 2) {
        timeDescription = @"前天";
    }
    else if (weeksCount == 0) {
        timeDescription = [self weekdayStringFromDate:date];
    }
    else if (yearsCount >= 1) {
        timeDescription = [self cn_YMD_stringFromDate:date];
    }
    
    if (isShowTime) {
        timeDescription = [timeDescription stringByAppendingFormat:@" %@", time];
    }
    return timeDescription;
}

- (NSDate *)earliestDateFromDates:(NSArray<NSDate *> *)dateArray
{
    if (!dateArray) {
        [self PrintErrorMessagesWithSelector:_cmd
                                   parameter:@"dateArray"
                                 returnValue:@"nil"];
        return nil;
    }
    if (dateArray.count == 1) {
        return dateArray.firstObject;
    }
    
    NSArray *dates = [dateArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
    NSDate *earliestDate = dates.firstObject;
    return earliestDate;
}

- (NSDate *)latestDateFromDates:(NSArray<NSDate *> *)dateArray
{
    if (!dateArray) {
        [self PrintErrorMessagesWithSelector:_cmd
                                   parameter:@"dateArray"
                                 returnValue:@"nil"];
        return nil;
    }
    if (dateArray.count == 1) {
        return dateArray.firstObject;
    }
    
    NSArray *dates = [dateArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
    NSDate *latestDate = dates.lastObject;
    return latestDate;
}

@end
