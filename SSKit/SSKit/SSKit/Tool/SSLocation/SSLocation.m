//
//  SSLocation.m
//  SSKit
//
//  Created by SunSatan on 2020/9/28.
//  Copyright © 2020 SunSatan. All rights reserved.
//

#import "SSLocation.h"

#import <CoreLocation/CoreLocation.h>

@interface SSLocation () <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *location;

@end

@implementation SSLocation

#pragma mark - 单例模式

static SSLocation *_share = nil;

+ (instancetype)share
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _share = [[super allocWithZone:nil] init];
        _share.location = [[CLLocationManager alloc] init];
        _share.location.desiredAccuracy = kCLLocationAccuracyBest;
        _share.location.delegate = _share;
    });
    return _share;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    return [self share];
}

- (id)copyWithZone:(struct _NSZone *)zone
{
    return _share;
}

- (id)mutableCopyWithZone:(NSZone *)zone
{
    return _share;
}

#pragma mark - 

- (void)startUpdatingLocation
{
    if (!_target) return;
    
    [_location requestAlwaysAuthorization];
    [_location startUpdatingLocation];
}

- (void)stopUpdatingLocation
{
    [_location stopUpdatingLocation];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    if (!_target) {
        [manager stopUpdatingLocation];
        NSLog(@"停止更新");
    }
    
    for (CLLocation *location in locations) {
        _lonAndLatDataBack ? _lonAndLatDataBack(location.coordinate.longitude, location.coordinate.latitude) : nil;
        _altitudeDataBack  ? _altitudeDataBack(location.altitude) : nil;
    }
}

@end
