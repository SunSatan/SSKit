//
//  SSDeviceTool.m
//  SSDeviceTool
//
//  Created by muzhi on 2020/3/25.
//  Copyright © 2020 SunSatan. All rights reserved.
//

#import "SSDeviceTool.h"

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
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    
    if (@available(iOS 12.0, *)) {
        NSDictionary *dict = [info serviceSubscriberCellularProviders];
        for (id info in dict) {
            CTCarrier *carrier = dict[info];
        }
    }
    
    CTCarrier *carrier = [info subscriberCellularProvider];
    if (!carrier.isoCountryCode) {
        return @"";
    }
    return carrier.carrierName;
}

#pragma mark - 屏幕参数

+ (CGRect)deviceScreenBounds
{
    return [UIScreen mainScreen].bounds;
}

+ (CGFloat)deviceScreenWidth
{
    return [UIScreen mainScreen].bounds.size.width;
}

+ (CGFloat)deviceScreenHeight
{
    return [UIScreen mainScreen].bounds.size.height;
}

+ (CGFloat)statusBarHeight
{
    CGFloat statusBarHeight = 0;
    if (@available(iOS 13.0, *)) {
        UIStatusBarManager *statusBarManager = [UIApplication sharedApplication].windows.firstObject.windowScene.statusBarManager;
        statusBarHeight = statusBarManager.statusBarFrame.size.height;
    } else {
        statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    }
    return statusBarHeight;
}

+ (CGFloat)navigationBarHeight
{
    UINavigationController *navigationController = [[UINavigationController alloc] init];
    CGFloat navigationBarHeight = navigationController.navigationBar.frame.size.height;
    return navigationBarHeight;
}

+ (CGFloat)navigationToolBarHeight
{
    UINavigationController *navigationController = [[UINavigationController alloc] init];
    CGFloat toolBarHeight = navigationController.toolbar.frame.size.height;
    return toolBarHeight;
}

+ (CGFloat)tabBarHeight
{
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    CGFloat tabBarHeight = tabBarController.tabBar.frame.size.height;
    return tabBarHeight;
}

+ (CGRect)safeAreaFrame
{
    CGRect safeAreaFrame = CGRectZero;
    if (@available(iOS 11.0, *)) {
        UIViewController *vc = [[UIViewController alloc] init];
        safeAreaFrame = vc.view.safeAreaLayoutGuide.layoutFrame;
    }
    return safeAreaFrame;
}

+ (CGFloat)safeAreaLeft
{
    CGFloat safeAreaLeft = 0;
    if (@available(iOS 11.0, *)) {
        UIViewController *vc = [[UIViewController alloc] init];
        safeAreaLeft = vc.view.safeAreaInsets.left;
    }
    return safeAreaLeft;
}

+ (CGFloat)safeAreaRight
{
    CGFloat safeAreaRight = 0;
    if (@available(iOS 11.0, *)) {
        UIViewController *vc = [[UIViewController alloc] init];
        safeAreaRight = vc.view.safeAreaInsets.right;
    }
    return safeAreaRight;
}

+ (CGFloat)safeAreaTop
{
    CGFloat safeAreaTop = 0;
    if (@available(iOS 11.0, *)) {
        UIViewController *vc = [[UIViewController alloc] init];
        safeAreaTop = vc.view.safeAreaInsets.top;
    }
    return safeAreaTop;
}

+ (CGFloat)safeAreaBottom
{
    CGFloat safeAreaBottom = 0 ;
    if (@available(iOS 11.0, *)) {
        UIViewController *vc = [[UIViewController alloc] init];
        safeAreaBottom = vc.view.safeAreaInsets.bottom;
    }
    return safeAreaBottom;
}

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

+ (NSString *)deviceModel
{
    /** 来源于：https://www.theiphonewiki.com/wiki/Models */
    
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    
    if ([deviceString isEqualToString:@"AirPods1,1"]) return @"AirPods";
    if ([deviceString isEqualToString:@"AirPods2,1"]) return @"AirPods 2";
    if ([deviceString isEqualToString:@"iProd8,1"])   return @"AirPods Pro";
    
    if ([deviceString isEqualToString:@"AppleTV2,1"]) return @"Apple TV 2";
    if ([deviceString isEqualToString:@"AppleTV3,1"]) return @"Apple TV 3";
    if ([deviceString isEqualToString:@"AppleTV3,2"]) return @"Apple TV 3";
    if ([deviceString isEqualToString:@"AppleTV5,3"]) return @"Apple TV 4";
    if ([deviceString isEqualToString:@"AppleTV6,2"]) return @"Apple TV 4K";
    
    if ([deviceString isEqualToString:@"Watch1,1"]) return @"Apple Watch";
    if ([deviceString isEqualToString:@"Watch1,2"]) return @"Apple Watch";
    if ([deviceString isEqualToString:@"Watch2,6"]) return @"Apple Watch Series 1";
    if ([deviceString isEqualToString:@"Watch2,7"]) return @"Apple Watch Series 1";
    if ([deviceString isEqualToString:@"Watch2,3"]) return @"Apple Watch Series 2";
    if ([deviceString isEqualToString:@"Watch2,4"]) return @"Apple Watch Series 2";
    if ([deviceString isEqualToString:@"Watch3,1"]) return @"Apple Watch Series 3";
    if ([deviceString isEqualToString:@"Watch3,2"]) return @"Apple Watch Series 3";
    if ([deviceString isEqualToString:@"Watch3,3"]) return @"Apple Watch Series 3";
    if ([deviceString isEqualToString:@"Watch3,4"]) return @"Apple Watch Series 3";
    if ([deviceString isEqualToString:@"Watch4,1"]) return @"Apple Watch Series 4";
    if ([deviceString isEqualToString:@"Watch4,2"]) return @"Apple Watch Series 4";
    if ([deviceString isEqualToString:@"Watch4,3"]) return @"Apple Watch Series 4";
    if ([deviceString isEqualToString:@"Watch4,4"]) return @"Apple Watch Series 4";
    
    if ([deviceString isEqualToString:@"iPad1,1"])  return @"iPad";
    if ([deviceString isEqualToString:@"iPad2,1"])  return @"iPad 2";
    if ([deviceString isEqualToString:@"iPad2,2"])  return @"iPad 2";
    if ([deviceString isEqualToString:@"iPad2,3"])  return @"iPad 2";
    if ([deviceString isEqualToString:@"iPad2,4"])  return @"iPad 2";
    if ([deviceString isEqualToString:@"iPad3,1"])  return @"iPad 3";
    if ([deviceString isEqualToString:@"iPad3,2"])  return @"iPad 3";
    if ([deviceString isEqualToString:@"iPad3,3"])  return @"iPad 3";
    if ([deviceString isEqualToString:@"iPad3,4"])  return @"iPad 4";
    if ([deviceString isEqualToString:@"iPad3,5"])  return @"iPad 4";
    if ([deviceString isEqualToString:@"iPad3,6"])  return @"iPad 4";
    if ([deviceString isEqualToString:@"iPad6,11"]) return @"iPad 5";
    if ([deviceString isEqualToString:@"iPad6,12"]) return @"iPad 5";
    if ([deviceString isEqualToString:@"iPad7,5"])  return @"iPad 6";
    if ([deviceString isEqualToString:@"iPad7,6"])  return @"iPad 6";
    if ([deviceString isEqualToString:@"iPad7,11"]) return @"iPad 7";
    if ([deviceString isEqualToString:@"iPad7,12"]) return @"iPad 7";
    
    if ([deviceString isEqualToString:@"iPad4,1"])  return @"iPad Air";
    if ([deviceString isEqualToString:@"iPad4,2"])  return @"iPad Air";
    if ([deviceString isEqualToString:@"iPad4,3"])  return @"iPad Air";
    if ([deviceString isEqualToString:@"iPad5,3"])  return @"iPad Air 2";
    if ([deviceString isEqualToString:@"iPad5,4"])  return @"iPad Air 2";
    if ([deviceString isEqualToString:@"iPad11,3"]) return @"iPad Air 3";
    if ([deviceString isEqualToString:@"iPad11,4"]) return @"iPad Air 3";
    
    if ([deviceString isEqualToString:@"iPad6,7"]) return @"iPad Pro 12.9";
    if ([deviceString isEqualToString:@"iPad6,8"]) return @"iPad Pro 12.9";
    if ([deviceString isEqualToString:@"iPad6,3"]) return @"iPad Pro 9.7";
    if ([deviceString isEqualToString:@"iPad6,4"]) return @"iPad Pro 9.7";
    if ([deviceString isEqualToString:@"iPad7,1"]) return @"iPad Pro 2 12.9";
    if ([deviceString isEqualToString:@"iPad7,2"]) return @"iPad Pro 2 12.9";
    if ([deviceString isEqualToString:@"iPad7,3"]) return @"iPad Pro 10.5";
    if ([deviceString isEqualToString:@"iPad7,4"]) return @"iPad Pro 10.5";
    if ([deviceString isEqualToString:@"iPad8,1"]) return @"iPad Pro 11";
    if ([deviceString isEqualToString:@"iPad8,2"]) return @"iPad Pro 11";
    if ([deviceString isEqualToString:@"iPad8,3"]) return @"iPad Pro 11";
    if ([deviceString isEqualToString:@"iPad8,4"]) return @"iPad Pro 11";
    if ([deviceString isEqualToString:@"iPad8,5"]) return @"iPad Pro 3 12.9";
    if ([deviceString isEqualToString:@"iPad8,6"]) return @"iPad Pro 3 12.9";
    if ([deviceString isEqualToString:@"iPad8,7"]) return @"iPad Pro 3 12.9";
    if ([deviceString isEqualToString:@"iPad8,8"]) return @"iPad Pro 3 12.9";
    
    if ([deviceString isEqualToString:@"iPad2,5"])  return @"iPad Mini";
    if ([deviceString isEqualToString:@"iPad2,6"])  return @"iPad Mini";
    if ([deviceString isEqualToString:@"iPad2,7"])  return @"iPad Mini";
    if ([deviceString isEqualToString:@"iPad4,4"])  return @"iPad Mini 2";
    if ([deviceString isEqualToString:@"iPad4,5"])  return @"iPad Mini 2";
    if ([deviceString isEqualToString:@"iPad4,6"])  return @"iPad Mini 2";
    if ([deviceString isEqualToString:@"iPad4,7"])  return @"iPad Mini 3";
    if ([deviceString isEqualToString:@"iPad4,8"])  return @"iPad Mini 3";
    if ([deviceString isEqualToString:@"iPad4,9"])  return @"iPad Mini 3";
    if ([deviceString isEqualToString:@"iPad5,1"])  return @"iPad Mini 4";
    if ([deviceString isEqualToString:@"iPad5,2"])  return @"iPad Mini 4";
    if ([deviceString isEqualToString:@"iPad11,1"]) return @"iPad Mini 5";
    if ([deviceString isEqualToString:@"iPad11,2"]) return @"iPad Mini 5";
    
    if ([deviceString isEqualToString:@"iPhone1,1"])  return @"iPhone";
    if ([deviceString isEqualToString:@"iPhone1,2"])  return @"iPhone 3G";
    if ([deviceString isEqualToString:@"iPhone2,1"])  return @"iPhone 3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"])  return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"])  return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,3"])  return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])  return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,1"])  return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,2"])  return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,3"])  return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone5,4"])  return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone6,1"])  return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone6,2"])  return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone7,2"])  return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone7,1"])  return @"iPhone 6 Plus";
    if ([deviceString isEqualToString:@"iPhone8,1"])  return @"iPhone 6S";
    if ([deviceString isEqualToString:@"iPhone8,2"])  return @"iPhone 6S Plus";
    if ([deviceString isEqualToString:@"iPhone8,4"])  return @"iPhone SE";
    if ([deviceString isEqualToString:@"iPhone9,1"])  return @"iPhone 7";
    if ([deviceString isEqualToString:@"iPhone9,3"])  return @"iPhone 7";
    if ([deviceString isEqualToString:@"iPhone9,2"])  return @"iPhone 7 Plus";
    if ([deviceString isEqualToString:@"iPhone9,4"])  return @"iPhone 7 Plus";
    if ([deviceString isEqualToString:@"iPhone10,1"]) return @"iPhone 8";
    if ([deviceString isEqualToString:@"iPhone10,4"]) return @"iPhone 8";
    if ([deviceString isEqualToString:@"iPhone10,2"]) return @"iPhone 8 Plus";
    if ([deviceString isEqualToString:@"iPhone10,5"]) return @"iPhone 8 Plus";
    if ([deviceString isEqualToString:@"iPhone10,3"]) return @"iPhone X";
    if ([deviceString isEqualToString:@"iPhone10,6"]) return @"iPhone X";
    if ([deviceString isEqualToString:@"iPhone11,8"]) return @"iPhone XR";
    if ([deviceString isEqualToString:@"iPhone11,2"]) return @"iPhone XS";
    if ([deviceString isEqualToString:@"iPhone11,6"]) return @"iPhone XS Max";
    if ([deviceString isEqualToString:@"iPhone11,4"]) return @"iPhone XS Max";
    if ([deviceString isEqualToString:@"iPhone12,1"]) return @"iPhone 11";
    if ([deviceString isEqualToString:@"iPhone12,3"]) return @"iPhone 11 Pro";
    if ([deviceString isEqualToString:@"iPhone12,5"]) return @"iPhone 11 Pro Max";
    
    if ([deviceString isEqualToString:@"iPod1,1"]) return @"iPod Touch";
    if ([deviceString isEqualToString:@"iPod2,1"]) return @"iPod Touch 2";
    if ([deviceString isEqualToString:@"iPod3,1"]) return @"iPod Touch 3";
    if ([deviceString isEqualToString:@"iPod4,1"]) return @"iPod Touch 4";
    if ([deviceString isEqualToString:@"iPod5,1"]) return @"iPod Touch 5";
    if ([deviceString isEqualToString:@"iPod7,1"]) return @"iPod Touch 6";
    if ([deviceString isEqualToString:@"iPod9,1"]) return @"iPod Touch 7";

    if ([deviceString isEqualToString:@"i386"])   return @"Simulator";
    if ([deviceString isEqualToString:@"x86_64"]) return @"Simulator";
    
    return @"Unknown Device Model";
}

@end
