//
//  SSHealthType.m
//  SSKit
//
//  Created by 孙铭健 on 2020/9/23.
//  Copyright © 2020 孙铭健. All rights reserved.
//

#import "SSHealthType.h"

@implementation SSHealthType

+ (NSSet<HKQuantityType *> *)allTypeSet
{
    return [NSSet setWithObjects:self.BMI, self.bodyHeight, self.bodyWeight, self.stepCount, self.stepLength, self.walkDistance, self.flightsClimbed, self.activeEnergyBurned, self.walkSpeed, self.walkingDoubleSupportPercentage, self.walkingAsymmetryPercentage, self.heartRate, self.headphoneVolume, nil];
}

+ (HKQuantityType *)BMI
{
    return [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMassIndex]; //
}

+ (HKQuantityType *)bodyHeight
{
    return [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeight];//
}

+ (HKQuantityType *)bodyWeight
{
    return [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass];//
}

+ (HKQuantityType *)stepCount
{
    return [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];//
}

+ (HKQuantityType *)stepLength
{
    if (@available(iOS 14.0, *)) {
        return [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierWalkingStepLength]; //
    }
    return nil;
}

+ (HKQuantityType *)walkDistance
{
    return [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];//
}

+ (HKQuantityType *)flightsClimbed
{
    return [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierFlightsClimbed];//
}

+ (HKQuantityType *)activeEnergyBurned
{
    return [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierActiveEnergyBurned]; //
}

+ (HKQuantityType *)walkSpeed //
{
    if (@available(iOS 14.0, *)) {
        return [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierWalkingSpeed];
    }
    return nil;
}

+ (HKQuantityType *)walkingDoubleSupportPercentage //
{
    if (@available(iOS 14.0, *)) {
        return [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierWalkingDoubleSupportPercentage];
    }
    return  nil;
}

+ (HKQuantityType *)walkingAsymmetryPercentage //
{
    if (@available(iOS 14.0, *)) {
        return [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierWalkingAsymmetryPercentage];
    }
    return  nil;
}

+ (HKQuantityType *)heartRate
{
    return [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeartRate]; //
}

+ (HKQuantityType *)headphoneVolume
{
    if (@available(iOS 13.0, *)) {
        return [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeadphoneAudioExposure];
    }
    return nil;
}


@end
