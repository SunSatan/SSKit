//
//  SSHealthType.h
//  SSKit
//
//  Created by 孙铭健 on 2020/9/23.
//  Copyright © 2020 孙铭健. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <HealthKit/HealthKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SSHealthType : NSObject

@property (class, nonatomic, readonly) HKQuantityType *BMI;
@property (class, nonatomic, readonly) HKQuantityType *bodyHeight; // 身高
@property (class, nonatomic, readonly) HKQuantityType *bodyWeight; // 体重

@property (class, nonatomic, readonly) HKQuantityType *stepCount;  // 步数
@property (class, nonatomic, readonly) HKQuantityType *stepLength; // 步长
@property (class, nonatomic, readonly) HKQuantityType *walkSpeed;  // 步行速度
@property (class, nonatomic, readonly) HKQuantityType *walkDistance; // 走路距离

@property (class, nonatomic, readonly) HKQuantityType *flightsClimbed; // 已爬楼层

@property (class, nonatomic, readonly) HKQuantityType *heartRate; // 心率
@property (class, nonatomic, readonly) HKQuantityType *activeEnergyBurned;// 活动消耗能量

@property (class, nonatomic, readonly) HKQuantityType *headphoneVolume; // 耳机音量

@property (class, nonatomic, readonly) HKQuantityType *walkingDoubleSupportPercentage; // 行走中，双足支撑的百分比
@property (class, nonatomic, readonly) HKQuantityType *walkingAsymmetryPercentage;     // 行走中，步伐不对称的百分比

//血氧

@end

NS_ASSUME_NONNULL_END
