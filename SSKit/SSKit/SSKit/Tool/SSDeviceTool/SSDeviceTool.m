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

+ (CGFloat)CPUUsage
{
    kern_return_t kr;
    task_info_data_t tinfo;
    mach_msg_type_number_t task_info_count;
    
    task_info_count = TASK_INFO_MAX;
    kr = task_info(mach_task_self(), TASK_BASIC_INFO, (task_info_t)tinfo, &task_info_count);
    if (kr != KERN_SUCCESS) {
        return 0;
    }
    
    task_basic_info_t      basic_info;
    thread_array_t         thread_list;
    mach_msg_type_number_t thread_count;
    
    thread_info_data_t     thinfo;
    mach_msg_type_number_t thread_info_count;
    
    thread_basic_info_t basic_info_th;
    uint32_t stat_thread = 0; // Mach threads
    
    basic_info = (task_basic_info_t)tinfo;
    
    // get threads in the task
    kr = task_threads(mach_task_self(), &thread_list, &thread_count);
    if (kr != KERN_SUCCESS) {
        return 0;
    }
    if (thread_count > 0)
        stat_thread += thread_count;
    
    long tot_sec = 0;
    long tot_usec = 0;
    float tot_cpu = 0;
    int j;
    
    for (j = 0; j < thread_count; j++)
    {
        thread_info_count = THREAD_INFO_MAX;
        kr = thread_info(thread_list[j], THREAD_BASIC_INFO,
                         (thread_info_t)thinfo, &thread_info_count);
        if (kr != KERN_SUCCESS) {
            return 0;
        }
        
        basic_info_th = (thread_basic_info_t)thinfo;
        
        if (!(basic_info_th->flags & TH_FLAGS_IDLE)) {
            tot_sec = tot_sec + basic_info_th->user_time.seconds + basic_info_th->system_time.seconds;
            tot_usec = tot_usec + basic_info_th->system_time.microseconds + basic_info_th->system_time.microseconds;
            tot_cpu = tot_cpu + basic_info_th->cpu_usage / (float)TH_USAGE_SCALE * 100.0;
        }
        
    } // for each thread
    
    kr = vm_deallocate(mach_task_self(), (vm_offset_t)thread_list, thread_count * sizeof(thread_t));
    assert(kr == KERN_SUCCESS);
    
    return tot_cpu;
}

+ (int64_t)memoryUsage {
    int64_t memoryUsageInByte = 0;
    task_vm_info_data_t vmInfo;
    mach_msg_type_number_t count = TASK_VM_INFO_COUNT;
    kern_return_t kernelReturn = task_info(mach_task_self(), TASK_VM_INFO, (task_info_t) &vmInfo, &count);
    if(kernelReturn == KERN_SUCCESS) {
        memoryUsageInByte = (int64_t) vmInfo.phys_footprint;
    }
    return memoryUsageInByte;
}

+ (NSString *)CPUUsageString
{
    return [NSString stringWithFormat:@"%.1lf", self.CPUUsage];
}

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
    //方法1
//    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
//    NSInteger size =  [fattributes objectForKey:NSFileSystemSize];
    
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
    
    //方法1
//    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
//    NSInteger size =  [fattributes objectForKey:NSFileSystemFreeSize];
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
