//
//  SSHealth.m
//  demo
//
//  Created by 孙铭健 on 2020/9/23.
//

#import "SSHealth.h"
#import "SSHealthType.h"
#import "SSMacro.h"
#import "SSDateHelper.h"

@interface SSHealth ()

@property (nonatomic, strong) HKHealthStore *healthStore;

@end

@implementation SSHealth

- (NSInteger)stepLengthLatestToday
{
    SS_SEMAPHORE_CREATE_0;
    __block NSUInteger stepLength = 0;
    [self statisticsCollectionQueryWithQuantityType:SSHealthType.stepLength
                                            endDate:[NSDate date]
                                     timeLengthMode:SSTimeModeDay
                                   timeIntervalMode:SSTimeModeDay
                                            options:HKStatisticsOptionMostRecent
                                queryResultsHandler:^(HKStatisticsCollection * _Nullable result) {
        //最新的在最后面
        HKStatistics *statistics = result.statistics.lastObject;
        stepLength = [statistics.mostRecentQuantity doubleValueForUnit:HKUnit.meterUnit] * 100;
        SS_SEMAPHORE_SIGNAL;
    }];
    
    SS_SEMAPHORE_WAIT;
    return stepLength;
}

- (NSInteger)activeEnergyBurnedSumToday
{
    SS_SEMAPHORE_CREATE_0;
    __block NSUInteger activeEnergyBurnedSum = 0;
    [self statisticsCollectionQueryWithQuantityType:SSHealthType.activeEnergyBurned
                                            endDate:[NSDate date]
                                     timeLengthMode:SSTimeModeDay
                                   timeIntervalMode:SSTimeModeDay
                                            options:HKStatisticsOptionCumulativeSum
                                queryResultsHandler:^(HKStatisticsCollection * _Nullable result) {
        //最新的在最后面
        for ( HKStatistics *statistics in result.statistics) {
            activeEnergyBurnedSum = [statistics.sumQuantity doubleValueForUnit:HKUnit.kilocalorieUnit];
        }
        SS_SEMAPHORE_SIGNAL;
    }];
    
    SS_SEMAPHORE_WAIT;
    return activeEnergyBurnedSum;
}

- (NSInteger)heartRateLatestToday
{
    SS_SEMAPHORE_CREATE_0;
    __block NSUInteger heartRateLatest = 0;
    [self statisticsCollectionQueryWithQuantityType:SSHealthType.heartRate
                                            endDate:[NSDate date]
                                     timeLengthMode:SSTimeModeDay
                                   timeIntervalMode:SSTimeModeMinute
                                            options:HKStatisticsOptionMostRecent
                                queryResultsHandler:^(HKStatisticsCollection * _Nullable result) {
        //最新的在最后面
        HKStatistics *statistics = result.statistics.lastObject;
        heartRateLatest = [statistics.mostRecentQuantity doubleValueForUnit:[HKUnit.countUnit unitDividedByUnit:HKUnit.minuteUnit]];
        SS_SEMAPHORE_SIGNAL;
    }];
    
    SS_SEMAPHORE_WAIT;
    return heartRateLatest;
}

- (NSInteger)heartRateMaxToday
{
    SS_SEMAPHORE_CREATE_0;
    __block NSUInteger heartRateLatest = 0;
    [self statisticsCollectionQueryWithQuantityType:SSHealthType.heartRate
                                            endDate:[NSDate date]
                                     timeLengthMode:SSTimeModeDay
                                   timeIntervalMode:SSTimeModeDay
                                            options:HKStatisticsOptionDiscreteMax
                                queryResultsHandler:^(HKStatisticsCollection * _Nullable result) {
        //最新的在最后面
        HKStatistics *statistics = result.statistics.lastObject;
        heartRateLatest = [statistics.maximumQuantity doubleValueForUnit:[HKUnit.countUnit unitDividedByUnit:HKUnit.minuteUnit]];
        SS_SEMAPHORE_SIGNAL;
    }];
    
    SS_SEMAPHORE_WAIT;
    return heartRateLatest;
}

- (NSUInteger)stepCountSumWithEndDate:(NSDate *)endDate
                       timeLengthMode:(SSTimeMode)timeLengthMode
                     timeIntervalMode:(SSTimeMode)timeIntervalMode
{
    SS_SEMAPHORE_CREATE_0;
    __block NSUInteger stepCountSum = 0;
    [self statisticsCollectionQueryWithQuantityType:SSHealthType.stepCount
                                            endDate:endDate
                                     timeLengthMode:timeLengthMode
                                   timeIntervalMode:timeIntervalMode
                                            options:HKStatisticsOptionCumulativeSum
                                queryResultsHandler:^(HKStatisticsCollection * _Nullable result) {
        for (HKStatistics *statistics in result.statistics) {
            stepCountSum += [statistics.sumQuantity doubleValueForUnit:HKUnit.countUnit];
        }
        SS_SEMAPHORE_SIGNAL;
    }];
    
    SS_SEMAPHORE_WAIT;
    return stepCountSum;
}

- (NSUInteger)walkDistanceSumWithEndDate:(NSDate *)endDate
                          timeLengthMode:(SSTimeMode)timeLengthMode
                        timeIntervalMode:(SSTimeMode)timeIntervalMode
{
    SS_SEMAPHORE_CREATE_0;
    __block NSUInteger walkDistanceSum = 0;
    [self statisticsCollectionQueryWithQuantityType:SSHealthType.walkDistance
                                            endDate:endDate
                                     timeLengthMode:timeLengthMode
                                   timeIntervalMode:timeIntervalMode
                                            options:HKStatisticsOptionCumulativeSum
                                queryResultsHandler:^(HKStatisticsCollection * _Nullable result) {
        for (HKStatistics *statistics in result.statistics) {
            walkDistanceSum += [statistics.sumQuantity doubleValueForUnit:HKUnit.meterUnit];
        }
        SS_SEMAPHORE_SIGNAL;
    }];
    
    SS_SEMAPHORE_WAIT;
    return walkDistanceSum;
}

- (void)requestAllHealthAuthority
{
    [self requestReadTypes:SSHealthType.allTypeSet successCompletion:nil];
}

#pragma mark -

- (void)requestReadTypes:(nullable NSSet<HKObjectType *> *)typesToRead successCompletion:(successCompletion)successCompletion
{
    if (![HKHealthStore isHealthDataAvailable]) return;
    
    [_healthStore requestAuthorizationToShareTypes:nil readTypes:typesToRead completion:^(BOOL success, NSError * _Nullable error) {
        if (!success) return;
        
        if (successCompletion) successCompletion();
    }];
}

- (void)statisticsCollectionQueryWithQuantityType:(HKQuantityType *)quantityType
                                          endDate:(NSDate *)endDate
                                   timeLengthMode:(SSTimeMode)timeLengthMode
                                 timeIntervalMode:(SSTimeMode)timeIntervalMode
                                          options:(HKStatisticsOptions)options
                              queryResultsHandler:(queryResultsHandler)queryResultsHandler
{
    NSDate *startDate = [self startDateForEndDate:endDate timeLengthMode:timeLengthMode];
    NSDateComponents *intervalComponents = [self timeInterval:timeIntervalMode];
    NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:startDate endDate:[NSDate date] options:HKQueryOptionStrictStartDate|HKQueryOptionStrictEndDate];
    
    HKStatisticsCollectionQuery *query = [[HKStatisticsCollectionQuery alloc] initWithQuantityType:quantityType quantitySamplePredicate:predicate options:options anchorDate:startDate intervalComponents:intervalComponents];
    query.initialResultsHandler = ^(HKStatisticsCollectionQuery * _Nonnull query, HKStatisticsCollection * _Nullable result, NSError * _Nullable error) {
        if (queryResultsHandler) queryResultsHandler(result);
    };
    
    NSSet *set = [NSSet setWithObject:quantityType];
    @weakify;
    [self requestReadTypes:set successCompletion:^{
        @strongify;
        [self.healthStore executeQuery:query];
    }];
}

- (void)removeUserAddData:(HKStatistics *)statistics
{
    
}

- (NSDate *)startDateForEndDate:(NSDate *)endDate timeLengthMode:(SSTimeMode)mode
{
    NSDate *date;
    switch (mode) {
        case SSTimeModeMinute:
            date = [SSDateMainHelper minuteLastDateForDate:endDate];
            break;
        case SSTimeModeHour:
            date = [SSDateMainHelper hourLastDateForDate:endDate];
            break;
        case SSTimeModeDay:
            date = [SSDateMainHelper dayStartDateForDate:endDate];
            break;
        case SSTimeModeWeek:
            date = [SSDateMainHelper weekStartDateForDate:endDate weekMode:SSDateWeekModeUsually];
            break;
        case SSTimeModeMonth:
            date = [SSDateMainHelper monthStartDateForDate:endDate];
            break;
        case SSTimeModeYear:
            date = [SSDateMainHelper yearStartDateForDate:endDate];
            break;
    }
    return date;
}

- (NSDateComponents *)timeInterval:(SSTimeMode)mode
{
    //时间间隔为1天
    NSDateComponents *intervalComponents = [[NSDateComponents alloc] init];
    switch (mode) {
        case SSTimeModeMinute:
            intervalComponents.minute = 1;
            break;
        case SSTimeModeHour:
            intervalComponents.hour = 1;
            break;
        case SSTimeModeDay:
            intervalComponents.day = 1;
            break;
        case SSTimeModeWeek:
            intervalComponents.day = 7;
            break;
        case SSTimeModeMonth:
            intervalComponents.month = 1;
            break;
        case SSTimeModeYear:
            intervalComponents.year = 1;
            break;
    }
    return intervalComponents;
}

#pragma mark - 单例

static SSHealth *_share = nil;

+ (instancetype)shareHealth
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _share = [[super allocWithZone:nil] init];
        _share.healthStore = [HKHealthStore new];
    });
    return _share;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    return [self shareHealth];
}

- (id)copyWithZone:(struct _NSZone *)zone
{
    return _share;
}

- (id)mutableCopyWithZone:(NSZone *)zone
{
    return _share;
}

@end
