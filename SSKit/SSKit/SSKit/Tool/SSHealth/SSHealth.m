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

- (void)requestReadTypes:(nullable NSSet<HKObjectType *> *)typesToRead successCompletion:(successCompletion)successCompletion
{
    if (![HKHealthStore isHealthDataAvailable]) return;
    
    [_healthStore requestAuthorizationToShareTypes:nil readTypes:typesToRead completion:^(BOOL success, NSError * _Nullable error) {
        if (!success) return;
        
        if (successCompletion) successCompletion();
    }];
}

- (NSUInteger)stepCountSumWithEndDate:(NSDate *)endDate
                       timeLengthMode:(SSTimeMode)timeLengthMode
                     timeIntervalMode:(SSTimeMode)timeIntervalMode
{
    //开始、结束时间
    NSDate *startDate = [self startDateForEndDate:endDate timeLengthMode:timeLengthMode];
    //时间间隔
        NSDateComponents *intervalComponents = [self timeInterval:timeIntervalMode];
    //时间段查询谓词
    NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:startDate endDate:endDate options:HKQueryOptionStrictStartDate|HKQueryOptionStrictEndDate];
    
    
    SS_SEMAPHORE_CREATE_0;
    __block NSUInteger stepCountSum = 0;
    
    HKSampleQuery *sampleQuery = [[HKSampleQuery alloc] initWithSampleType:SSHealthType.stepCount predicate:predicate limit:HKObjectQueryNoLimit sortDescriptors:nil resultsHandler:^(HKSampleQuery * _Nonnull query, NSArray<__kindof HKSample *> * _Nullable results, NSError * _Nullable error) {
        
        if (@available(iOS 13.0, *)) {
            for (HKCumulativeQuantitySample *element in results) {
                //bundleIdentifier:com.apple.Health
                //name:健康
                if ([element.sourceRevision.source.bundleIdentifier isEqualToString:@"com.apple.Health"]) continue;
                
                stepCountSum += [element.sumQuantity doubleValueForUnit:HKUnit.countUnit];
                
            }
            SS_SEMAPHORE_SIGNAL;
        }
    }];
    
        HKStatisticsCollectionQuery *query = [[HKStatisticsCollectionQuery alloc] initWithQuantityType:SSHealthType.stepCount quantitySamplePredicate:predicate options:HKStatisticsOptionCumulativeSum anchorDate:startDate intervalComponents:intervalComponents];
        query.initialResultsHandler = ^(HKStatisticsCollectionQuery * _Nonnull query, HKStatisticsCollection * _Nullable result, NSError * _Nullable error) {
    
            for (HKStatistics *statistics in result.statistics) {
    
                stepCountSum += [statistics.sumQuantity doubleValueForUnit:HKUnit.countUnit];
    
                NSLog(@"statistics.sources : %ld", statistics.sources.count);
                for (HKSource *source in statistics.sources) {
                    NSLog(@"%@", source.bundleIdentifier);
                }
            }
        };
    
    NSSet *set = [NSSet setWithObject:SSHealthType.stepCount];
    @weakify;
    [self requestReadTypes:set successCompletion:^{
        @strongify;
        [self.healthStore executeQuery:sampleQuery];
    }];
    
    SS_SEMAPHORE_WAIT;
    return stepCountSum;
}

- (NSDate *)startDateForEndDate:(NSDate *)endDate timeLengthMode:(SSTimeMode)mode
{
    NSDate *date;
    switch (mode) {
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


- (void)removeUserAddData:(HKStatistics *)statistics
{
    
}

- (NSDateComponents *)timeInterval:(SSTimeMode)mode
{
    //时间间隔为1天
    NSDateComponents *intervalComponents = [[NSDateComponents alloc] init];
    switch (mode) {
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
