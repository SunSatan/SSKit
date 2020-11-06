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

///设置 target 自动关闭数据更新，不然就需要手动关闭数据自动更新。
@property (nonatomic, weak) id target;
@property (nonatomic, strong) CLLocationManager *location;
@property (nonatomic, strong) CLGeocoder *geocoder;

@end

@implementation SSLocation

- (void)dealloc
{
    _location = nil;
}

- (instancetype)init
{
    if (self = [super init]) {
        _location = [[CLLocationManager alloc] init];
        _location.desiredAccuracy = kCLLocationAccuracyBest;
        _location.delegate = self;
        _geocoder = CLGeocoder.new;
    }
    return self;
}

#pragma mark - 

- (void)startUpdatingLocationWithTarget:(id)target
{
    _target = target;
    [self startUpdatingLocation];
}

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
        return;
    }
    
    CLLocation *location = locations.firstObject;
    
    _lonAndLatDataBack ? _lonAndLatDataBack(location.coordinate.longitude, location.coordinate.latitude) : nil;
    _altitudeDataBack  ? _altitudeDataBack(location.altitude) : nil;
    
    __weak typeof(self) selfWeak = self;
    [_geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark *placemark = placemarks.firstObject;
        if (selfWeak.localeNameDataBack) {
            selfWeak.localeNameDataBack([placemark.addressDictionary[@"FormattedAddressLines"] firstObject]);
        }
    }];
}

@end
