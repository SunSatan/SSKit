//
//  SSMotion.h
//  widget
//
//  Created by 孙铭健 on 2020/9/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define SSMotionMain SSMotion.main

@interface SSMotion : NSObject <NSCopying>

+ (instancetype)main;

// 同步方法，主线程返回数据
- (NSUInteger)stepCountSumToday;
- (NSUInteger)stepDistanceToday;
- (NSUInteger)floorUpCountToday;
- (NSUInteger)floorDownCountToday;

// 异步方法，block在子线程
- (void)stepCountSumToday:(void(^)(NSUInteger stepCountSum))handler;
- (void)stepDistanceToday:(void(^)(NSUInteger distance))handler;  //单位是米
- (void)floorUpCountToday:(void(^)(NSUInteger floorUpCount))handler;
- (void)floorDownCountToday:(void(^)(NSUInteger floorDownCount))handler;

// 指定开始日期和结束日期
- (void)stepCountSumFromDate:(NSDate *)date toDate:(NSDate *)endDate complete:(void(^)(NSUInteger stepCountSum))complete;
- (void)stepDistanceFromDate:(NSDate *)date toDate:(NSDate *)endDate complete:(void(^)(NSUInteger distance))complete;
- (void)floorUpCountFromDate:(NSDate *)date toDate:(NSDate *)endDate complete:(void(^)(NSUInteger floorUpCount))complete;
- (void)floorDownCountFromDate:(NSDate *)date toDate:(NSDate *)endDate complete:(void(^)(NSUInteger floorDownCount))complete;

- (void)reloadData:(void(^)(NSUInteger stepCountSum, NSUInteger distance, NSUInteger floorUpCount))handler;

@end

NS_ASSUME_NONNULL_END
