//
//  SSMotion.h
//  widget
//
//  Created by SunSatan on 2020/9/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define SSMotionMain SSMotion.main

@class SSWeakProxy;

@interface SSMotion : NSObject <NSCopying>

+ (instancetype)main;

// 会不断更新数据，需要配对使用关闭
- (void)startUpdatePressure:(void(^)(double pressure))update;
- (void)stopUpdateAltitude;

// 同步方法，主线程返回数据
- (NSUInteger)stepCountSumToday;
- (NSUInteger)stepDistanceToday;
- (NSUInteger)floorUpCountToday;
- (NSUInteger)floorDownCountToday;

// 异步方法，block在子线程
- (void)stepCountSumToday:(void(^)(NSUInteger stepCountSum))handler; //单位是步
- (void)stepDistanceToday:(void(^)(NSUInteger distance))handler;  //单位是米
- (void)floorUpCountToday:(void(^)(NSUInteger floorUpCount))handler; //单位是楼层
- (void)floorDownCountToday:(void(^)(NSUInteger floorDownCount))handler; //单位是楼层

// 指定开始日期和结束日期
- (void)stepCountSumFromDate:(NSDate *)date toDate:(NSDate *)endDate complete:(void(^)(NSUInteger stepCountSum))complete;
- (void)stepDistanceFromDate:(NSDate *)date toDate:(NSDate *)endDate complete:(void(^)(NSUInteger distance))complete;
- (void)floorUpCountFromDate:(NSDate *)date toDate:(NSDate *)endDate complete:(void(^)(NSUInteger floorUpCount))complete;
- (void)floorDownCountFromDate:(NSDate *)date toDate:(NSDate *)endDate complete:(void(^)(NSUInteger floorDownCount))complete;

@end

NS_ASSUME_NONNULL_END
