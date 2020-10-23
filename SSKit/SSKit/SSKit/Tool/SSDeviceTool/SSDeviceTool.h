//
//  SSDeviceTool.h
//  SSDeviceTool
//
//  Created by muzhi on 2020/3/25.
//  Copyright © 2020 SunSatan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



NS_ASSUME_NONNULL_BEGIN

//typedef NS_ENUM(NSUInteger, SSMobileOperator) {
//    SSMobileOperatorChinaTelecom,//中国电信
//    SSMobileOperatorChinaUnicom, //中国联通
//    SSMobileOperatorChinaMobile, //中国移动
//    SSMobileOperatorOther        //其他
//};
//
//#pragma mark - 网络参数
//
//@interface SSDeviceTool (SSNetwork)
//
//@property (class, nonatomic, readonly) NSString *networkProvider; //网络服务商、未完成
//
//@end

@interface SSDeviceTool : NSObject
/**
 * 将 deviceToken 转换成 pushToken
 */
+ (NSString *)pushTokenFromDeviceToken:(NSData *)deviceToken;

@end

#pragma mark - app参数 √

@interface SSDeviceTool (SSAppInfo)
/**
 * 获取当前安装本app名称 Display Name
 */
@property (class, nonatomic, readonly) NSString *appName;
/**
 * 获取设备当前安装本app版本号 Version
 */
@property (class, nonatomic, readonly) NSString *appVersion;
/**
 * 获取设备当前安装本app构建号 Build
 */
@property (class, nonatomic, readonly) NSString *appBuild;

@end

#pragma mark - FPS √

typedef void(^FPSDispalyBlock)(CGFloat FPS, NSString *FPSString);

@interface SSDeviceTool (FPS)
/**
 * 开启统计FPS
 * @param FPSDispalyBlock fps数据回调，一秒一次
 */
- (void)startCalculateFPS:(FPSDispalyBlock)FPSDispalyBlock;
/**
 * 关闭统计FPS
 */
- (void)endCalculateFPS;

@end

#pragma mark - 电池 √

@interface SSDeviceTool (SSBattery)
/**
 * 设备电量百分比
 */
@property (class, nonatomic, readonly) CGFloat batteryLevel;
/**
 * 设备充电状态
 */
@property (class, nonatomic, readonly) UIDeviceBatteryState batteryState;
/**
 * 设备电池的额定容量
 */
@property (class, nonatomic, readonly) NSString *batteryMah;

/*
 <key>com.apple.power.battery.CycleCount</key> 电池循环次数
 <key>com.apple.power.battery.MaximumCapacityPercent</key> 健康度
 <key>com.apple.power.battery.raw_max_capacity</key> 最大容量
 */

@end

#pragma mark - 设备参数

@interface SSDeviceTool (SSDeviceInfo)
/**
 * 获取机器型号：iPhone13,4
 */
@property (class, nonatomic, readonly) NSString *machineModelID;
/**
 * 获取设备型号：iPhone 6S、iPhone X
 */
@property (class, nonatomic, readonly) NSString *deviceModel;
/**
 * 获取设备型号：iOS
 */
@property (class, nonatomic, readonly) NSString *systemName;
/**
 * 获取设备型号：13.3.1
 */
@property (class, nonatomic, readonly) NSString *systemVersion;
/**
 * 获取设备系统版本：iOS 13.3.1
 */
@property (class, nonatomic, readonly) NSString *systemNameAndVersion;
/**
 * 获取设备名称：SunSatan
 */
@property (class, nonatomic, readonly) NSString *deviceName;
/**
 * 获取设备IDFV(唯一设备标识)
 */
@property (class, nonatomic, readonly) NSString *idfv;
/**
 * 获取设备IDFA(广告标示符)
 */
@property (class, nonatomic, readonly) NSString *idfa;
/**
 * 获取当前设备语言：zh-Hans-CN(简体中文)
 */
@property (class, nonatomic, readonly) NSString *language;
/**
 * 获取当前地区国家：China mainland(中国大陆)
 */
@property (class, nonatomic, readonly) NSString *localeCountry;
/**
 * 最近一次重启时间 √
 */
@property (class, nonatomic, readonly) NSDate *latestRestartTime;
/**
 * 设备发售时间 √
 */
@property (class, nonatomic, readonly) NSString *saleTime;
/**
 * 设备能更新的最新的系统 √
 */
@property (class, nonatomic, readonly) NSString *latestSystemVersion;
/**
 * 设备屏幕像素密度 √
 */
@property (class, nonatomic, readonly) NSString *screenPPI;
/**
 * 设备屏幕尺寸 √
 */
@property (class, nonatomic, readonly) NSString *screenSize;
/**
 * 设备屏幕宽高比 √
 */
@property (class, nonatomic, readonly) NSString *screenAspectRatio;
/**
 * 设备是否越狱 √
 */
@property (class, nonatomic, readonly) BOOL isJailbreak;

@end

#pragma mark - CPU信息

@interface SSDeviceTool (SSCPU)
/**
 * soc 名称 √
 */
@property (class, nonatomic, readonly) NSString *SocName;
/**
 * cpu 总占用率 √
 */
@property (class, nonatomic, readonly) CGFloat CPUUsage;
@property (class, nonatomic, readonly) NSString *CPUUsageString;
/**
 * 当前 app 对 cpu 的占用率 √
 */
@property (class, nonatomic, readonly) CGFloat appCPUUsage;
@property (class, nonatomic, readonly) NSString *appCPUUsageString;
/**
 * cpu 核心数 √
 */
@property (class, nonatomic, readonly) NSUInteger CPUCoresNumber;
/**
 * gpu 核心数
 */
@property (class, nonatomic, readonly) NSUInteger GPUCoresNumber;
/**
 * cpu 架构: arm64 armv7 √
 */
@property (class, nonatomic, readonly) NSString *CPUArchitecture;

@end

#pragma mark - 内存、硬盘信息 √

@interface SSDeviceTool (SSMemory)

typedef void(^SizeBlock)(unsigned long long size);
typedef void(^SizeStringBlock)(NSString *sizeString);

/**
 * 开启定时返回内存、存储数据
 * @param timeInterval 调用Block的时间间隔
 */
- (void)startMemoryWithTimeInterval:(NSTimeInterval)timeInterval;

/**
 * 设备内存类型
 */
@property (class, nonatomic, readonly) NSString *memoryType;
/**
 * 当前 app 对 内存的占用率 √
 */
@property (class, nonatomic, readonly) int64_t appMemoryUsage;
@property (class, nonatomic, readonly) NSString *appMemoryUsageString;
/**
 * 内存总占用率 √
 */
@property (class, nonatomic, readonly) CGFloat memoryUsage;
@property (class, nonatomic, readonly) NSString *memoryUsageString;

/**
 * 设备运存(RAM)总大小
 */
@property (class, nonatomic, readonly) unsigned long long deviceMemorySize;
@property (class, nonatomic, readonly) NSString *deviceMemorySizeString;
@property (nonatomic, copy) SizeBlock memorySizeTimeBlock;
@property (nonatomic, copy) SizeStringBlock memorySizeStringTimeBlock;
/**
 * 设备运存(RAM)空闲大小
 */
@property (class, nonatomic, readonly) unsigned long long deviceMemoryFreeSize;
@property (class, nonatomic, readonly) NSString *deviceMemoryFreeSizeString;
@property (nonatomic, copy) SizeBlock memoryFreeSizeTimeBlock;
@property (nonatomic, copy) SizeStringBlock memoryFreeSizeStringTimeBlock;
/**
 * 设备运存(RAM)已使用大小
 */
@property (class, nonatomic, readonly) unsigned long long deviceMemoryUsedSize;
@property (class, nonatomic, readonly) NSString *deviceMemoryUsedSizeString;
@property (nonatomic, copy) SizeBlock memoryUsedSizeTimeBlock;
@property (nonatomic, copy) SizeStringBlock memoryUsedSizeStringTimeBlock;


/**
 * 设备存储(Disk)总大小
 */
@property (class, nonatomic, readonly) unsigned long long deviceDiskSize;
@property (class, nonatomic, readonly) NSString *deviceDiskSizeString;
@property (nonatomic, copy) SizeBlock diskSizeTimeBlock;
@property (nonatomic, copy) SizeStringBlock diskSizeStringTimeBlock;
/**
 * 设备存储(Disk)空闲大小
 */
@property (class, nonatomic, readonly) unsigned long long deviceDiskFreeSize;
@property (class, nonatomic, readonly) NSString *deviceDiskFreeSizeString;
@property (nonatomic, copy) SizeBlock diskFreeSizeTimeBlock;
@property (nonatomic, copy) SizeStringBlock diskFreeSizeStringTimeBlock;
/**
 * 设备存储(Disk)已使用大小
 */
@property (class, nonatomic, readonly) unsigned long long deviceDiskUsedSize;
@property (class, nonatomic, readonly) NSString *deviceDiskUsedSizeString;
@property (nonatomic, copy) SizeBlock diskUsedSizeTimeBlock;
@property (nonatomic, copy) SizeStringBlock diskUsedSizeStringTimeBlock;

@end

NS_ASSUME_NONNULL_END
