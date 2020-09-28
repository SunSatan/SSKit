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

- (void)stepCountSumToday:(void(^)(NSUInteger stepCountSum))handler;
- (void)stepDistanceToday:(void(^)(NSUInteger distance))handler;  //单位是米
- (void)floorUpCountToday:(void(^)(NSUInteger floorUpCount))handler;
- (void)floorDownCountToday:(void(^)(NSUInteger floorDownCount))handler;

- (void)reloadData:(void(^)(NSUInteger stepCountSum, NSUInteger distance, NSUInteger floorUpCount))handler;

+ (instancetype)main;

- (NSUInteger)stepCountSumToday;
- (NSUInteger)stepDistanceToday;
- (NSUInteger)floorUpCountToday;
- (NSUInteger)floorDownCountToday;

@end

NS_ASSUME_NONNULL_END
