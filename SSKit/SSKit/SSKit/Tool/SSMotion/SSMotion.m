//
//  SSMotion.m
//  widget
//
//  Created by 孙铭健 on 2020/9/25.
//

#import "SSMotion.h"
#import "SSDateHelper.h"
#import "SSMacro.h"

#import <CoreMotion/CoreMotion.h>

@interface SSMotion ()

@property (nonatomic, strong) CMPedometer *pedometer;

@end

@implementation SSMotion

#pragma mark - 步数

- (NSUInteger)stepCountSumToday
{
    if (!CMPedometer.isStepCountingAvailable) return 0;
    
    SS_SEMAPHORE_CREATE_0;
    __block NSUInteger _stepCount = 0;
    [self.pedometer queryPedometerDataFromDate:[SSDateMainHelper dayStartDateForDate:[NSDate date]] toDate:[NSDate date] withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
        _stepCount = pedometerData.numberOfSteps.unsignedIntegerValue;
        SS_SEMAPHORE_SIGNAL;
    }];
    
    SS_SEMAPHORE_WAIT;
    return _stepCount;
}

- (void)stepCountSumToday:(void(^)(NSUInteger stepCountSum))handler
{
    if (!CMPedometer.isStepCountingAvailable) return;
    
    [self.pedometer queryPedometerDataFromDate:[SSDateMainHelper dayStartDateForDate:[NSDate date]] toDate:[NSDate date] withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
        if (handler){
            handler(pedometerData.numberOfSteps.unsignedIntegerValue);
        }
    }];
}

- (void)stepCountSumFromDate:(NSDate *)date toDate:(NSDate *)endDate complete:(void(^)(NSUInteger stepCountSum))complete
{
    if (!CMPedometer.isStepCountingAvailable) return;
    
    [self.pedometer queryPedometerDataFromDate:date toDate:endDate withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
        if (complete){
            complete(pedometerData.numberOfSteps.unsignedIntegerValue);
        }
    }];
}

#pragma mark - 步行距离

- (NSUInteger)stepDistanceToday
{
    if (!CMPedometer.isStepCountingAvailable) return 0;
    
    SS_SEMAPHORE_CREATE_0;
    __block NSUInteger distance = 0;
    [self.pedometer queryPedometerDataFromDate:[SSDateMainHelper dayStartDateForDate:[NSDate date]] toDate:[NSDate date] withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
        distance = pedometerData.distance.unsignedIntegerValue;
        SS_SEMAPHORE_SIGNAL;
    }];
    
    SS_SEMAPHORE_WAIT;
    return distance;
}

- (void)stepDistanceToday:(void(^)(NSUInteger distance))handler
{
    if (!CMPedometer.isDistanceAvailable) return;
    
    [self.pedometer queryPedometerDataFromDate:[SSDateMainHelper dayStartDateForDate:[NSDate date]] toDate:[NSDate date] withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
        if (handler){
            handler(pedometerData.distance.unsignedIntegerValue);
        }
    }];
}

- (void)stepDistanceFromDate:(NSDate *)date toDate:(NSDate *)endDate complete:(void(^)(NSUInteger distance))complete
{
    if (!CMPedometer.isStepCountingAvailable) return;
    
    [self.pedometer queryPedometerDataFromDate:date toDate:endDate withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
        if (complete){
            complete(pedometerData.distance.unsignedIntegerValue);
        }
    }];
}

#pragma mark - 爬楼层数

- (NSUInteger)floorUpCountToday
{
    if (!CMPedometer.isStepCountingAvailable) return 0;
    
    SS_SEMAPHORE_CREATE_0;
    __block NSUInteger floorUpCount = 0;
    [self.pedometer queryPedometerDataFromDate:[SSDateMainHelper dayStartDateForDate:[NSDate date]] toDate:[NSDate date] withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
        floorUpCount = pedometerData.floorsAscended.unsignedIntegerValue;
        SS_SEMAPHORE_SIGNAL;
    }];
    
    SS_SEMAPHORE_WAIT;
    return floorUpCount;
}

- (void)floorUpCountToday:(void(^)(NSUInteger floorUpCount))handler
{
    if (!CMPedometer.isFloorCountingAvailable) return;
    
    [self.pedometer queryPedometerDataFromDate:[SSDateMainHelper dayStartDateForDate:[NSDate date]] toDate:[NSDate date] withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
        if (handler){
            handler(pedometerData.floorsAscended.unsignedIntegerValue);
        }
    }];
}

- (void)floorUpCountFromDate:(NSDate *)date toDate:(NSDate *)endDate complete:(void(^)(NSUInteger floorUpCount))complete
{
    if (!CMPedometer.isStepCountingAvailable) return;
    
    [self.pedometer queryPedometerDataFromDate:date toDate:endDate withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
        if (complete){
            complete(pedometerData.floorsAscended.unsignedIntegerValue);
        }
    }];
}

#pragma mark - 下楼层数

- (NSUInteger)floorDownCountToday
{
    if (!CMPedometer.isStepCountingAvailable) return 0;
    
    SS_SEMAPHORE_CREATE_0;
    __block NSUInteger floorDownCount = 0;
    [self.pedometer queryPedometerDataFromDate:[SSDateMainHelper dayStartDateForDate:[NSDate date]] toDate:[NSDate date] withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
        floorDownCount = pedometerData.floorsDescended.unsignedIntegerValue;
        SS_SEMAPHORE_SIGNAL;
    }];
    
    SS_SEMAPHORE_WAIT;
    return floorDownCount;
}

- (void)floorDownCountToday:(void(^)(NSUInteger floorDownCount))handler
{
    if (!CMPedometer.isFloorCountingAvailable) return;
    
    [self.pedometer queryPedometerDataFromDate:[SSDateMainHelper dayStartDateForDate:[NSDate date]] toDate:[NSDate date] withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
        if (handler){
            handler(pedometerData.floorsDescended.unsignedIntegerValue);
        }
    }];
}

- (void)floorDownCountFromDate:(NSDate *)date toDate:(NSDate *)endDate complete:(void(^)(NSUInteger floorDownCount))complete
{
    if (!CMPedometer.isStepCountingAvailable) return;
    
    [self.pedometer queryPedometerDataFromDate:date toDate:endDate withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
        if (complete){
            complete(pedometerData.floorsDescended.unsignedIntegerValue);
        }
    }];
}

#pragma mark - 单例

static SSMotion * _main;

+ (instancetype)main
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _main = [[super allocWithZone:nil] init];
        _main.pedometer = [CMPedometer new];
    });
    
    return _main;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    return [self main];
}

- (id)copyWithZone:(struct _NSZone *)zone
{
    return _main;
}

- (id)mutableCopyWithZone:(NSZone *)zone
{
    return _main;
}

@end
