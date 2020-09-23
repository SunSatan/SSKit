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

typedef NS_ENUM(NSUInteger, SSTimeMode) {
    SSTimeModeDay,
    SSTimeModeWeek,
    SSTimeModeMonth,
    SSTimeModeYear
};

@interface SSHealth : NSObject <NSCopying>
+ (instancetype)shareHealth;

- (void)requestReadTypes:(nullable NSSet<HKObjectType *> *)typesToRead successCompletion:(successCompletion)successCompletion;

- (NSUInteger)stepCountSumWithEndDate:(NSDate *)endDate
                       timeLengthMode:(SSTimeMode)timeLengthMode
                     timeIntervalMode:(SSTimeMode)timeIntervalMode;

@end

NS_ASSUME_NONNULL_END
