//
//  SSDeviceTool.m
//  SSDeviceTool
//
//  Created by SunSatan on 2020/3/25.
//  Copyright © 2020 SunSatan. All rights reserved.
//

#import "SSDeviceTool.h"
#import "SSDeviceLibrary.h"
#import "NSString+SSCategory.h"
#import "SSTimer.h"
#import "SSWeakProxy.h"

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

#pragma mark - fps
@property (nonatomic, strong) CADisplayLink  *link;
@property (nonatomic, assign) NSTimeInterval  countFPS;       //统计fps
@property (nonatomic, assign) NSTimeInterval  startTimestamp; //每次循环开始的时间戳
@property (nonatomic, copy)   FPSDispalyBlock FPSDispalyBlock;

#pragma mark - 内存读取定时器
@property (nonatomic, strong) SSTimer *memoryTimer;
@property (nonatomic, strong) SSTimer *memoryUsageTimer;

@end

@implementation SSDeviceTool

#pragma mark - dealloc

- (void)dealloc
{
    NSLog(@"SSDeviceTool -> dealloc");
}

#pragma mark - Private Method

+ (NSUInteger)_systemInfo:(uint)typeSpecifier
{
    size_t size = sizeof(NSUInteger);
    int result = 0 , mib[2] = {CTL_HW, typeSpecifier};
    sysctl(mib, 2, &result, &size, NULL, 0);
    return (NSUInteger)result;
}

+ (NSString *)pushTokenFromDeviceToken:(NSData *)deviceToken
{
    const unsigned *tokenBytes = deviceToken.bytes;
    NSString *pushToken = [NSString stringWithFormat:@"%08x%08x%08x%08x%08x%08x%08x%08x", ntohl(tokenBytes[0]), ntohl(tokenBytes[1]), ntohl(tokenBytes[2]), ntohl(tokenBytes[3]), ntohl(tokenBytes[4]), ntohl(tokenBytes[5]), ntohl(tokenBytes[6]), ntohl(tokenBytes[7])];
    return pushToken;
}

#pragma mark - app参数

+ (NSString *)appName
{
    NSString *name = NSBundle.mainBundle.infoDictionary[@"CFBundleName"];
    return name;
}

+ (NSString *)appVersion
{
    NSString *version = NSBundle.mainBundle.infoDictionary[@"CFBundleShortVersionString"];
    return version;
}

+ (NSString *)appBuild
{
    NSString *build = NSBundle.mainBundle.infoDictionary[@"CFBundleVersion"];
    return build;
}

#pragma mark - fps

- (void)startCalculateFPS:(FPSDispalyBlock)FPSDispalyBlock
{
    if (_link) return;
    SSWeakProxy *proxy = [SSWeakProxy proxyWithTarget:self];
    _link = [CADisplayLink displayLinkWithTarget:proxy selector:@selector(ticktack:)];
    [_link addToRunLoop:NSRunLoop.mainRunLoop forMode:NSRunLoopCommonModes];
    
    self.FPSDispalyBlock = FPSDispalyBlock;
}

//- (void)endCalculateFPS
//{
//    [_link invalidate];
//    _link = nil;
//}

- (void)ticktack:(CADisplayLink *)link
{
    if (_startTimestamp == 0)
        _startTimestamp = link.timestamp; //记下开始时间戳
    
    _countFPS++;
    NSTimeInterval seconds = _link.timestamp - _startTimestamp;
    
    if (seconds < 1)
        return;   //统计一秒内的帧数
    
    //返回数据
    CGFloat FPS = ceil(_countFPS / seconds);
    NSString *FPSString = [NSString stringWithFormat:@"%.0f FPS", round(FPS)];
    if (self.FPSDispalyBlock) self.FPSDispalyBlock(FPS, FPSString);
    //开始下一轮
    _countFPS = 0;
    _startTimestamp = link.timestamp;
}

#pragma mark - 电池

+ (CGFloat)batteryLevel
{
    UIDevice.currentDevice.batteryMonitoringEnabled = YES;
    CGFloat batteryLevel = UIDevice.currentDevice.batteryLevel;
    return batteryLevel;
}

+ (UIDeviceBatteryState)batteryState
{
    UIDevice.currentDevice.batteryMonitoringEnabled = YES;
    UIDeviceBatteryState batteryState = UIDevice.currentDevice.batteryState;
    return batteryState;
}

#pragma mark - 设备参数

+ (NSString *)machineModelID
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceModelID  = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    return deviceModelID;
}

+ (NSString *)deviceModel
{
    return [SSDeviceLibrary deviceModelWithMachineModelID:self.machineModelID];
}

+ (NSString *)systemName
{
    return UIDevice.currentDevice.systemName;
}

+ (NSString *)systemVersion
{
    return UIDevice.currentDevice.systemVersion;
}

+ (NSString *)systemNameAndVersion
{
    NSString *version = [NSString stringWithFormat:@"%@ %@", UIDevice.currentDevice.systemName, UIDevice.currentDevice.systemVersion];
    return version;
}

+ (NSString *)deviceName
{
    return UIDevice.currentDevice.name;
}

+ (NSString *)idfv
{
    NSString *idfv = UIDevice.currentDevice.identifierForVendor.UUIDString;
    return idfv;
}

+ (NSString *)idfa
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

+ (NSString *)language
{
    NSArray *languageArray = NSLocale.preferredLanguages;
    return languageArray.firstObject;
}

+ (NSString *)localeCountry
{
    NSString *localeIdentifier = [NSLocale.currentLocale localizedStringForCountryCode:NSLocale.currentLocale.countryCode];
    return localeIdentifier;
}

+ (NSDate *)latestRestartTime
{
    NSTimeInterval time = NSProcessInfo.processInfo.systemUptime;
    return [NSDate.alloc initWithTimeIntervalSinceNow:(0 - time)];
}

+ (NSString *)saleTime
{
    return [SSDeviceLibrary saleTimeWithDevice:self.deviceModel];
}

+ (NSString *)latestSystemVersion
{
    return [SSDeviceLibrary latestOSVersionWithDevice:self.deviceModel];
}

+ (NSString *)screenPPI
{
    return [NSString stringWithFormat:@"%ld ppi", [SSDeviceLibrary ppiWithDevice:self.deviceModel]];
}

+ (NSString *)screenSize
{
    return [NSString stringWithFormat:@"%ld\"", [SSDeviceLibrary screenSizeWithDevice:self.deviceModel]];
}

+ (NSString *)screenAspectRatio
{
    return [SSDeviceLibrary aspectRatioWithScreenSize:[SSDeviceLibrary screenSizeWithDevice:self.deviceModel]];
}

+ (NSString *)SIMCard
{
    return [SSDeviceLibrary SIMCardWithDevice:self.deviceModel];
}

+ (NSString *)displayScreen
{
    return [SSDeviceLibrary displayScreenWithDevice:self.deviceModel];
}

+ (NSString *)deviceSize
{
    return [SSDeviceLibrary deviceSizeWithDevice:self.deviceModel];
}

+ (NSString *)deviceWeight
{
    return [NSString stringWithFormat:@"%ld g", [SSDeviceLibrary deviceWeightWithDevice:self.deviceModel]];
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

#pragma mark - CPU信息

+ (NSString *)SocName
{
    return [SSDeviceLibrary SoCNameWithDevice:self.deviceModel];
}

+ (CGFloat)CPUUsage
{
    kern_return_t kr;
    mach_msg_type_number_t count;
    static host_cpu_load_info_data_t previous_info = {0, 0, 0, 0};
    host_cpu_load_info_data_t info;
    
    count = HOST_CPU_LOAD_INFO_COUNT;
    
    kr = host_statistics(mach_host_self(), HOST_CPU_LOAD_INFO, (host_info_t)&info, &count);
    if (kr != KERN_SUCCESS) {
        return 0;
    }
    
    natural_t user   = info.cpu_ticks[CPU_STATE_USER] - previous_info.cpu_ticks[CPU_STATE_USER];
    natural_t nice   = info.cpu_ticks[CPU_STATE_NICE] - previous_info.cpu_ticks[CPU_STATE_NICE];
    natural_t system = info.cpu_ticks[CPU_STATE_SYSTEM] - previous_info.cpu_ticks[CPU_STATE_SYSTEM];
    natural_t idle   = info.cpu_ticks[CPU_STATE_IDLE] - previous_info.cpu_ticks[CPU_STATE_IDLE];
    natural_t total  = user + nice + system + idle;
    previous_info    = info;
    
    return (user + nice + system) * 100.0 / total;
}

- (void)startCPUUsageBlockWithTimeInterval:(NSTimeInterval)timeInterval
                             CPUUsageBlock:(UsageBlock)CPUUsageBlock
{
    static SSTimer *timer;
    
    if (timer) {
        [timer cleanTimer];
    }
    
    timer = [SSTimer scheduledTimerWithTimeInterval:timeInterval target:self repeats:YES block:^(NSTimer * _Nonnull timer) {
        if (CPUUsageBlock)
            CPUUsageBlock(self.class.CPUUsage);
    }];
}

+ (NSString *)CPUUsageString
{
    return [NSString stringWithFormat:@"%.1lf%%", self.CPUUsage];
}

- (void)startCPUUsageStringBlockWithTimeInterval:(NSTimeInterval)timeInterval
                             CPUUsageStringBlock:(UsageStringBlock)CPUUsageStringBlock
{
    static SSTimer *timer;
    
    if (timer) {
        [timer cleanTimer];
    }
    
    timer = [SSTimer scheduledTimerWithTimeInterval:timeInterval target:self repeats:YES block:^(NSTimer * _Nonnull timer) {
        if (CPUUsageStringBlock)
            CPUUsageStringBlock(self.class.CPUUsageString);
    }];
}

+ (CGFloat)appCPUUsage
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

+ (NSString *)appCPUUsageString
{
    return [NSString stringWithFormat:@"%.1lf%%", self.appCPUUsage];
}

+ (NSUInteger)CPUCoresNumber
{
    return [self _systemInfo:HW_NCPU];
}

+ (NSUInteger)CPUFrequency
{
    return [SSDeviceLibrary CPUFrequencyWithSoC:self.SocName];
}

+ (NSUInteger)GPUCoresNumber
{
    return [SSDeviceLibrary GPUCoresNumberWithSoC:self.SocName];
}

+ (NSString *)CPUArchitecture
{
    return [NSBundle.mainBundle.infoDictionary[@"UIRequiredDeviceCapabilities"] firstObject];
}

#pragma mark - 内存

+ (NSString *)memoryType
{
    return [SSDeviceLibrary memoryTypeWithDevice:self.deviceModel];
}

+ (uint64_t)appMemoryUsedSize
{
    int64_t memoryUsageInByte = 0;
    task_vm_info_data_t vmInfo;
    mach_msg_type_number_t count = TASK_VM_INFO_COUNT;
    kern_return_t kernelReturn = task_info(mach_task_self(), TASK_VM_INFO, (task_info_t) &vmInfo, &count);
    if(kernelReturn == KERN_SUCCESS) {
        memoryUsageInByte = (uint64_t) vmInfo.phys_footprint;
    }
    return memoryUsageInByte;
}

+ (NSString *)appMemoryUsedSizeString
{
    return [NSString ss_memoryUnit:self.appMemoryUsedSize];
}

+ (CGFloat)memoryUsage
{
    return (self.memoryUsedSize / (self.memorySize * 1.0));
}

+ (NSString *)memoryUsageString
{
    return [NSString stringWithFormat:@"%.1lf%%", self.memoryUsage];
}

+ (uint64_t)memorySize
{
    return NSProcessInfo.processInfo.physicalMemory;
}

+ (NSString *)memorySizeString
{
    return [NSString ss_memoryUnit:self.memorySize];
}

+ (uint64_t)memoryFreeSize
{
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vmStats, &infoCount);
    if (kernReturn != KERN_SUCCESS) {
        return 0;
    }
    return (uint64_t)((vm_page_size * (vmStats.free_count +vmStats.inactive_count)));
}

+ (NSString *)memoryFreeSizeString
{
    return [NSString ss_memoryUnit:self.memoryFreeSize];
}

+ (uint64_t)memoryUsedSize
{
    return (self.memorySize - self.memoryFreeSize);
}

+ (NSString *)memoryUsedSizeString
{
    return [NSString ss_memoryUnit:self.memoryUsedSize];
}

#pragma mark - 硬盘信息

+ (CGFloat)diskUsage
{
    return (self.diskUsedSize / (self.diskSize * 1.0));
}

+ (NSString *)diskUsageString
{
    return [NSString stringWithFormat:@"%.1lf%%", self.diskUsage];
}

+ (uint64_t)diskSize
{
    //方法1
//    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
//    NSInteger size =  [fattributes objectForKey:NSFileSystemSize];
    struct statfs buf;
    uint64_t freeSpace = 0;
    if (statfs("/var", &buf) >= 0) {
        freeSpace = (uint64_t)(buf.f_bsize * buf.f_blocks);
    }
    return freeSpace;
}

+ (NSString *)diskSizeString
{
    return [NSString ss_diskUnit:self.diskSize];
}

+ (uint64_t)diskFreeSize
{
    //方法1
//    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
//    NSInteger size =  [fattributes objectForKey:NSFileSystemFreeSize];
    struct statfs buf;
    uint64_t freeSpace =0;
    if (statfs("/var", &buf) >= 0) {
        freeSpace = (uint64_t)(buf.f_bsize * buf.f_bavail);
    }
    return freeSpace;
}

+ (NSString *)diskFreeSizeString
{
    return [NSString ss_diskUnit:self.diskFreeSize];
}

+ (uint64_t)diskUsedSize
{
    return (self.diskSize - self.diskFreeSize);
}

+ (NSString *)diskUsedSizeString
{
    return [NSString ss_diskUnit:self.diskUsedSize];
}

@end
