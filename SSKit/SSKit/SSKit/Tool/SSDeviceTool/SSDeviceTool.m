//
//  SSDeviceTool.m
//  SSDeviceTool
//
//  Created by muzhi on 2020/3/25.
//  Copyright © 2020 SunSatan. All rights reserved.
//

#import "SSDeviceTool.h"
#import "SSDeviceLibrary.h"

#import <AdSupport/AdSupport.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import <sys/utsname.h>
#import <objc/runtime.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#include <sys/sysctl.h>

@interface SSDeviceTool ()

@property (nonatomic, strong) CADisplayLink *link;
@property (nonatomic, assign) NSTimeInterval countFPS;
@property (nonatomic, assign) NSTimeInterval startTimestamp;
@property (nonatomic, copy) FPSDispalyBlock FPSDispalyBlock;

@end

@implementation SSDeviceTool

- (void)dealloc
{
    NSLog(@"SSDeviceTool -> dealloc");
}

#pragma mark - Private Method

+ (NSUInteger)_systemInfo:(uint)typeSpecifier
{
    size_t size = sizeof(int);
    int result;
    int mib[2] = {CTL_HW, typeSpecifier};
    sysctl(mib, 2, &result, &size, NULL, 0);
    return (NSUInteger)result;
}

+ (NSString *)_deviceColorWithKey:(NSString *)key
{
    UIDevice *device = [UIDevice currentDevice];
    SEL selector = NSSelectorFromString(@"deviceInfoForKey:");
    if (![device respondsToSelector:selector]) {
        selector = NSSelectorFromString(@"_deviceInfoForKey:");
    }
    if ([device respondsToSelector:selector]) {
        IMP imp = [device methodForSelector:selector];
        NSString * (*func)(id, SEL, NSString *) = (void *)imp;
        return func(device, selector, key);
    }
    return @"Un Known";
}

+ (NSDate *)deviceLatestRestartTime
{
    NSTimeInterval time = [[NSProcessInfo processInfo] systemUptime];
    return [[NSDate alloc] initWithTimeIntervalSinceNow:(0 - time)];
}

+ (NSString *)deviceColorHexString
{
    return [self _deviceColorWithKey:@"DeviceColor"];
}
+ (NSString *)deviceEnclosureColorHexString
{
    return [self _deviceColorWithKey:@"DeviceEnclosureColor"];
}

+ (NSUInteger)ramTotalSize
{
    return [self _systemInfo:HW_MEMSIZE];
}

+ (NSString *)CPUModel
{
    return nil;
}

#pragma mark - fps参数

- (void)startCalculateFPS:(FPSDispalyBlock)FPSDispalyBlock
{
    if (!_link) {
        __weak typeof(self) weakSelf = self;
        _link = [CADisplayLink displayLinkWithTarget:weakSelf selector:@selector(ticktack:)];
        [_link addToRunLoop:NSRunLoop.mainRunLoop forMode:NSRunLoopCommonModes];
        
        self.FPSDispalyBlock = FPSDispalyBlock;
    }
}

- (void)endCalculateFPS
{
    [_link invalidate];
    _link = nil;
}

- (void)ticktack:(CADisplayLink *)link
{
    if (_startTimestamp == 0) _startTimestamp = link.timestamp; //记下开始时间戳
    
    _countFPS++;
    
    NSTimeInterval seconds = _link.timestamp - _startTimestamp;
    if (seconds < 1)  return;
    
    _startTimestamp = link.timestamp;
    CGFloat FPS = _countFPS / seconds;
    NSString *FPSString = [NSString stringWithFormat:@"%.0f", round(FPS)];
    _countFPS = 0;
    
    if (self.FPSDispalyBlock) {
        self.FPSDispalyBlock(FPS, FPSString);
    }
    
}

#pragma mark - 网络参数

+ (NSString *)networkProvider
{
//    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
//
//    if (@available(iOS 12.0, *)) {
//        NSDictionary *dict = [info serviceSubscriberCellularProviders];
//        for (id info in dict) {
//            CTCarrier *carrier = dict[info];
//        }
//    }
//
//    CTCarrier *carrier = [info subscriberCellularProvider];
//    if (!carrier.isoCountryCode) {
//        return @"";
//    }
//    return carrier.carrierName;
    return @"";
}

#pragma mark - 屏幕参数



#pragma mark - app参数

+ (NSString *)currentAppName
{
    NSString *version = [[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleName"];
    return version;
}

+ (NSString *)currentAppVerion
{
    NSString *version = [[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return version;
}

+ (NSString *)currentAppBuild
{
    NSString *version = [[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleVersion"];
    return version;
}

#pragma mark - 设备参数

+ (NSString *)pushTokenForDeviceToken:(NSData *)deviceToken
{
    const unsigned *tokenBytes = [deviceToken bytes];
    NSString *pushToken = [NSString stringWithFormat:@"%08x%08x%08x%08x%08x%08x%08x%08x", ntohl(tokenBytes[0]), ntohl(tokenBytes[1]), ntohl(tokenBytes[2]), ntohl(tokenBytes[3]), ntohl(tokenBytes[4]), ntohl(tokenBytes[5]), ntohl(tokenBytes[6]), ntohl(tokenBytes[7])];
    return pushToken;
}

+ (NSString *)devicePhoneName
{
    NSString *name = [NSString stringWithFormat:@"%@", [UIDevice currentDevice].name];
    return name;
}

+ (NSString *)deviceSystemVersion
{
    NSString *version = [NSString stringWithFormat:@"%@ %@", [UIDevice currentDevice].systemName, [UIDevice currentDevice].systemVersion];
    return version;
}

+ (NSString *)deviceLanguage
{
    NSArray *languageArray = [NSLocale preferredLanguages];
    return [languageArray objectAtIndex:0];
}

+ (NSString *)localeCountry
{
    NSLocale *locale = [NSLocale currentLocale];
    NSString *localeIdentifier = [locale localizedStringForCountryCode:locale.countryCode];
    return localeIdentifier;
}

+ (NSString *)deviceIDFV
{
    NSString *idfv = [UIDevice currentDevice].identifierForVendor.UUIDString;
    return idfv;
}

+ (NSString *)deviceIDFA
{
    NSString *idfa = @"";
    if (@available(iOS 14, *)) {
        if (ATTrackingManager.trackingAuthorizationStatus == ATTrackingManagerAuthorizationStatusAuthorized) {
            idfa = [ASIdentifierManager sharedManager].advertisingIdentifier.UUIDString;
        }
    } else {
        if ([ASIdentifierManager sharedManager].isAdvertisingTrackingEnabled) {
            idfa = [ASIdentifierManager sharedManager].advertisingIdentifier.UUIDString;
        }
    }
    return idfa;
}

+ (CGFloat)deviceBatteryLevel
{
    [UIDevice currentDevice].batteryMonitoringEnabled = YES;
    CGFloat batteryLevel = [UIDevice currentDevice].batteryLevel;
    return batteryLevel;
}

+ (UIDeviceBatteryState)deviceBatteryState
{
    [UIDevice currentDevice].batteryMonitoringEnabled = YES;
    UIDeviceBatteryState batteryState = [UIDevice currentDevice].batteryState;
    return batteryState;
}

+ (NSString *)deviceModel
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceName = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    
    return [SSDeviceLibrary deviceModelWithDeviceName:deviceName];
}

@end
