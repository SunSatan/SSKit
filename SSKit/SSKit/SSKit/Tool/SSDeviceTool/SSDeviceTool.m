//
//  SSDeviceTool.m
//  SSDeviceTool
//
//  Created by muzhi on 2020/3/25.
//  Copyright © 2020 SunSatan. All rights reserved.
//

#import "SSDeviceTool.h"
#import "SSDeviceLibrary.h"
#import "NSString+SSCategory.h"
#import "SSTimer.h"

#import <AdSupport/AdSupport.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import <objc/runtime.h>
#import <sys/utsname.h>
#import <sys/mount.h>
#import <mach/mach.h>
#include <sys/sysctl.h>
//#import <CoreTelephony/CTTelephonyNetworkInfo.h>
//#import <CoreTelephony/CTCarrier.h>

@interface SSDeviceTool ()

@property (nonatomic, strong) CADisplayLink *link;
@property (nonatomic, assign) NSTimeInterval countFPS;
@property (nonatomic, assign) NSTimeInterval startTimestamp;
@property (nonatomic, copy) FPSDispalyBlock FPSDispalyBlock;

@property (nonatomic, strong) SSTimer *memoryTime;

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
    int result = 0 , mib[2] = {CTL_HW, typeSpecifier};
    sysctl(mib, 2, &result, &size, NULL, 0);
    return (NSUInteger)result;
}

+ (NSString *)_machineModelID
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceModelID  = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    return deviceModelID;
}

#pragma mark - CPU信息

+ (NSUInteger)CPUCoresNumber
{
    return [self _systemInfo:HW_NCPU];
}

+ (NSString *)deviceSoCName
{
    return [SSDeviceLibrary deviceSoCName:self._machineModelID];
}

+ (NSUInteger)CPUMaxFrequency
{
    return 0;
}

+ (NSUInteger)CPUCurrentFrequency
{
    return 0;
}

+ (NSString *)CPUArchitecture
{
    return [NSBundle.mainBundle.infoDictionary[@"UIRequiredDeviceCapabilities"] firstObject];
}

#pragma mark - 内存、硬盘信息

- (void)startMemoryWithTimeInterval:(NSTimeInterval)timeInterval
{
    if (self.memoryTime) return;
    
    __weak typeof(self) selfWeak = self;
    self.memoryTime = [SSTimer timerWithTimeInterval:timeInterval target:self repeats:YES runLoopMode:NSRunLoopCommonModes block:^(NSTimer * _Nonnull timer) {
        __strong typeof(self) self = selfWeak;
        
        if (self.memorySizeTimeBlock)
            self.memorySizeTimeBlock(self.class.deviceMemorySize);
        if (self.memorySizeStringTimeBlock)
            self.memorySizeStringTimeBlock(self.class.deviceMemorySizeString);
        if (self.memoryFreeSizeTimeBlock)
            self.memoryFreeSizeTimeBlock(self.class.deviceMemoryFreeSize);
        if (self.memoryFreeSizeStringTimeBlock)
            self.memoryFreeSizeStringTimeBlock(self.class.deviceMemoryFreeSizeString);
        if (self.memoryUsedSizeTimeBlock)
            self.memoryUsedSizeTimeBlock(self.class.deviceMemoryUsedSize);
        if (self.memoryUsedSizeStringTimeBlock)
            self.memoryUsedSizeStringTimeBlock(self.class.deviceMemoryUsedSizeString);
        
        if (self.diskSizeTimeBlock)
            self.diskSizeTimeBlock(self.class.deviceDiskSize);
        if (self.diskSizeStringTimeBlock)
            self.diskSizeStringTimeBlock(self.class.deviceDiskSizeString);
        if (self.diskFreeSizeTimeBlock)
            self.diskFreeSizeTimeBlock(self.class.deviceDiskFreeSize);
        if (self.diskFreeSizeStringTimeBlock)
            self.diskFreeSizeStringTimeBlock(self.class.deviceDiskFreeSizeString);
        if (self.diskUsedSizeTimeBlock)
            self.diskUsedSizeTimeBlock(self.class.deviceDiskUsedSize);
        if (self.diskUsedSizeStringTimeBlock)
            self.diskUsedSizeStringTimeBlock(self.class.deviceDiskUsedSizeString);
    }];
}

+ (unsigned long long)deviceMemorySize
{
    return NSProcessInfo.processInfo.physicalMemory;
}

+ (NSString *)deviceMemorySizeString
{
    unsigned long long memorySize = self.deviceMemorySize;
    return [NSString ss_memoryUnit:memorySize];
}

+ (unsigned long long)deviceMemoryFreeSize
{
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vmStats, &infoCount);
    if (kernReturn != KERN_SUCCESS) {
        return NSNotFound;
    }
    
    return ((vm_page_size * (vmStats.free_count +vmStats.inactive_count)));
}

+ (NSString *)deviceMemoryFreeSizeString
{
    unsigned long long memoryFreeSize = self.deviceMemoryFreeSize;
    return [NSString ss_memoryUnit:memoryFreeSize];
}

+ (unsigned long long)deviceMemoryUsedSize
{
    return self.deviceMemorySize - self.deviceMemoryFreeSize;
}

+ (NSString *)deviceMemoryUsedSizeString
{
    return [NSString ss_memoryUnit:self.deviceMemoryUsedSize];
}

+ (unsigned long long)deviceDiskSize
{
    struct statfs buf;
    unsigned long long freeSpace = -1;
    if (statfs("/var", &buf) >= 0) {
        freeSpace = (unsigned long long)(buf.f_bsize * buf.f_blocks);
    }
    return freeSpace;
}

+ (NSString *)deviceDiskSizeString
{
    unsigned long long diskSize = self.deviceDiskSize;
    return [NSString ss_diskUnit:diskSize];
}

+ (unsigned long long)deviceDiskFreeSize
{
    struct statfs buf;
    unsigned long long freeSpace = -1;
    if (statfs("/var", &buf) >= 0) {
        freeSpace = (unsigned long long)(buf.f_bsize * buf.f_bavail);
    }
    return freeSpace;
}

+ (NSString *)deviceDiskFreeSizeString
{
    unsigned long long diskFreeSize = self.deviceDiskFreeSize;
    return [NSString ss_diskUnit:diskFreeSize];
}

+ (unsigned long long)deviceDiskUsedSize
{
    return self.deviceDiskSize - self.deviceDiskFreeSize;
}

+ (NSString *)deviceDiskUsedSizeString
{
    return [NSString ss_diskUnit:self.deviceDiskUsedSize];
}

#pragma mark - fps参数

- (void)startCalculateFPS:(FPSDispalyBlock)FPSDispalyBlock
{
    if (_link) return;
    
    _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(ticktack:)];
    [_link addToRunLoop:NSRunLoop.mainRunLoop forMode:NSRunLoopCommonModes];
    
    self.FPSDispalyBlock = FPSDispalyBlock;
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
    CGFloat FPS = floor(_countFPS / seconds);
    NSString *FPSString = [NSString stringWithFormat:@"%.0f FPS", round(FPS)];
    _countFPS = 0;
    
    if (self.FPSDispalyBlock) self.FPSDispalyBlock(FPS, FPSString);
}

#pragma mark - app参数

+ (NSString *)currentAppName
{
    NSString *version = NSBundle.mainBundle.infoDictionary[@"CFBundleName"];
    return version;
}

+ (NSString *)currentAppVersion
{
    NSString *version = NSBundle.mainBundle.infoDictionary[@"CFBundleShortVersionString"];
    return version;
}

+ (NSString *)currentAppBuild
{
    NSString *version = NSBundle.mainBundle.infoDictionary[@"CFBundleVersion"];
    return version;
}

#pragma mark - 设备参数

+ (NSString *)pushTokenForDeviceToken:(NSData *)deviceToken
{
    const unsigned *tokenBytes = deviceToken.bytes;
    NSString *pushToken = [NSString stringWithFormat:@"%08x%08x%08x%08x%08x%08x%08x%08x", ntohl(tokenBytes[0]), ntohl(tokenBytes[1]), ntohl(tokenBytes[2]), ntohl(tokenBytes[3]), ntohl(tokenBytes[4]), ntohl(tokenBytes[5]), ntohl(tokenBytes[6]), ntohl(tokenBytes[7])];
    return pushToken;
}

+ (NSString *)devicePhoneName
{
    NSString *name = [NSString stringWithFormat:@"%@", UIDevice.currentDevice.name];
    return name;
}

+ (NSString *)deviceSystemVersion
{
    NSString *version = [NSString stringWithFormat:@"%@ %@", UIDevice.currentDevice.systemName, UIDevice.currentDevice.systemVersion];
    return version;
}

+ (NSString *)deviceLanguage
{
    NSArray *languageArray = NSLocale.preferredLanguages;
    return languageArray.firstObject;
}

+ (NSString *)localeCountry
{
    NSString *localeIdentifier = [NSLocale.currentLocale localizedStringForCountryCode:NSLocale.currentLocale.countryCode];
    return localeIdentifier;
}

+ (NSString *)deviceIDFV
{
    NSString *idfv = UIDevice.currentDevice.identifierForVendor.UUIDString;
    return idfv;
}

+ (NSString *)deviceIDFA
{
    NSString *idfa = @"";
    if (@available(iOS 14, *)) {
        if (ATTrackingManager.trackingAuthorizationStatus == ATTrackingManagerAuthorizationStatusAuthorized) {
            idfa = ASIdentifierManager.sharedManager.advertisingIdentifier.UUIDString;
        }
    } else {
        if (ASIdentifierManager.sharedManager.isAdvertisingTrackingEnabled) {
            idfa = ASIdentifierManager.sharedManager.advertisingIdentifier.UUIDString;
        }
    }
    return idfa;
}

+ (CGFloat)deviceBatteryLevel
{
    UIDevice.currentDevice.batteryMonitoringEnabled = YES;
    CGFloat batteryLevel = UIDevice.currentDevice.batteryLevel;
    return batteryLevel;
}

+ (UIDeviceBatteryState)deviceBatteryState
{
    UIDevice.currentDevice.batteryMonitoringEnabled = YES;
    UIDeviceBatteryState batteryState = UIDevice.currentDevice.batteryState;
    return batteryState;
}

+ (NSString *)deviceModel
{
    return [SSDeviceLibrary deviceModel:self._machineModelID];
}

+ (NSDate *)deviceLatestRestartTime
{
    NSTimeInterval time = NSProcessInfo.processInfo.systemUptime;
    return [NSDate.alloc initWithTimeIntervalSinceNow:(0 - time)];
}

+ (NSString *)deviceSaleTime
{
    return [SSDeviceLibrary deviceSaleTime:self._machineModelID];
}

+ (NSString *)deviceMemType
{
    return [SSDeviceLibrary deviceMemType:self._machineModelID];
}

+ (NSString *)deviceLatestSystemVersion
{
    return [SSDeviceLibrary deviceLatestOSVersion:self._machineModelID];
}

+ (NSString *)screenPPI
{
    return [SSDeviceLibrary devicePPI:self._machineModelID];
}

+ (NSString *)screenSize
{
    return [SSDeviceLibrary deviceScreenSize:self._machineModelID];
}

+ (NSString *)screenAspectRatio
{
    return [SSDeviceLibrary deviceAspectRatio:self.screenSize];
}

// 常见越狱文件
const char *jailbreak_tool_pathes[] =
{
    "/Applications/Cydia.app",
    "/Library/MobileSubstrate/MobileSubstrate.dylib",
    "/bin/bash",
    "/usr/sbin/sshd",
    "/etc/apt"
};

char *printEnv(void)
{
    char *env = getenv("DYLD_INSERT_LIBRARIES");
    return env;
}

/** 当前设备是否越狱 */
+ (BOOL)isJailbreak
{
    // 判断是否存在越狱文件
    for (int i = 0; i < 5; i++) {
        if ([NSFileManager.defaultManager fileExistsAtPath:[NSString stringWithUTF8String:jailbreak_tool_pathes[i]]]) {
            return YES;
        }
    }
    // 判断是否存在cydia应用
    if([UIApplication.sharedApplication canOpenURL:[NSURL URLWithString:@"cydia://package/com.example.package"]]) {
        return YES;
    }
    
    // 读取系统所有的应用名称
    if ([NSFileManager.defaultManager fileExistsAtPath:@"/User/Applications/"]) {
        return YES;
    }
    
    // 读取环境变量
    if(printEnv()) {
        return YES;
    }
    
    return NO;
}

@end
