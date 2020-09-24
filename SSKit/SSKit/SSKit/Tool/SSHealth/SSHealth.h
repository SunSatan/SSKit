//
//  SSHealth.h
//  demo
//
//  Created by 孙铭健 on 2020/9/23.
//

#import <Foundation/Foundation.h>
#import <HealthKit/HealthKit.h>

NS_ASSUME_NONNULL_BEGIN

#define SSHealthShare SSHealth.shareHealth

typedef void (^successCompletion)(void);
typedef void (^queryResultsHandler)(HKStatisticsCollection * _Nullable result); 

typedef NS_ENUM(NSUInteger, SSTimeMode) {
    SSTimeModeMinute,
    SSTimeModeHour,
    SSTimeModeDay,
    SSTimeModeWeek,
    SSTimeModeMonth,
    SSTimeModeYear
};

@interface SSHealth : NSObject <NSCopying>

+ (instancetype)shareHealth;

- (void)requestAllHealthAuthority;
//- (void)requestHealthAuthorityWithSet:(NSSet<HKObjectType *> *)types;

- (NSUInteger)stepCountSumWithEndDate:(NSDate *)endDate
                       timeLengthMode:(SSTimeMode)timeLengthMode
                     timeIntervalMode:(SSTimeMode)timeIntervalMode;

- (NSUInteger)walkDistanceSumWithEndDate:(NSDate *)endDate
                          timeLengthMode:(SSTimeMode)timeLengthMode
                        timeIntervalMode:(SSTimeMode)timeIntervalMode;

- (NSInteger)heartRateLatestToday;
- (NSInteger)heartRateMaxToday;

- (NSInteger)stepLengthLatestToday;

- (NSInteger)activeEnergyBurnedSumToday;

@end

NS_ASSUME_NONNULL_END
