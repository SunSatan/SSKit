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

typedef NS_ENUM(NSUInteger, SSMobileOperator) {
    SSMobileOperatorChinaTelecom,//中国电信
    SSMobileOperatorChinaUnicom, //中国联通
    SSMobileOperatorChinaMobile, //中国移动
    SSMobileOperatorOther      //其他
};

@interface SSDeviceTool : NSObject

+ (NSString *)pushTokenForDeviceToken:(NSData *)deviceToken; //将 deviceToken 转换成 pushToken

@end

#pragma mark - 设备参数

@interface SSDeviceTool (SSDeviceInfo)

@property (class, nonatomic, readonly) NSString *deviceModel;         //获取设备型号：iPhone 6S、iPhone X
@property (class, nonatomic, readonly) NSString *deviceSystemVersion; //获取设备系统版本：iOS 13.3.1
@property (class, nonatomic, readonly) NSString *devicePhoneName;     //获取设备名称：SunSatan
@property (class, nonatomic, readonly) NSString *deviceIDFV;          //获取设备IDFV(唯一设备标识)
@property (class, nonatomic, readonly) NSString *deviceIDFA;          //获取设备IDFA(广告标示符)

@property (class, nonatomic, readonly) NSString *deviceLanguage;      //获取当前设备语言：zh-Hans-CN(简体中文)
@property (class, nonatomic, readonly) NSString *localeCountry; //获取当前地区国家：en_CN(中国)

@property (class, nonatomic, readonly) CGFloat deviceBatteryLevel; //获取当前设备电量
@property (class, nonatomic, readonly) UIDeviceBatteryState deviceBatteryState;

@property (class, nonatomic, readonly) NSDate *deviceLatestRestartTime; //最近一次重启时间

@property (class, nonatomic, readonly) NSString *deviceColorHexString;
@property (class, nonatomic, readonly) NSString *deviceEnclosureColorHexString;

@end

#pragma mark - app参数

@interface SSDeviceTool (SSAppInfo)

@property (class, nonatomic, readonly) NSString *currentAppName;   //获取当前安装本app名称 Display Name
@property (class, nonatomic, readonly) NSString *currentAppVerion; //获取设备当前安装本app版本号 Verion
@property (class, nonatomic, readonly) NSString *currentAppBuild;  //获取设备当前安装本app构建号 Build

@property (class, nonatomic, readonly) NSUInteger appDiskSize; //app 包体积大小

@end

#pragma mark - 网络参数

@interface SSDeviceTool (SSNetwork)

@property (class, nonatomic, readonly) NSString *networkProvider; //网络服务商、未完成

@end

#pragma mark - FPS

typedef void(^FPSDispalyBlock)(CGFloat FPS, NSString *FPSString);

@interface SSDeviceTool (FPS)

- (void)startCalculateFPS:(FPSDispalyBlock)FPSDispalyBlock;
- (void)endCalculateFPS;

@end

#pragma mark - CPU信息

@interface SSDeviceTool (SSCPU)

@property (class, nonatomic, readonly) NSString *CPUModel; //cpu 名称
@property (class, nonatomic, readonly) NSUInteger CPUCoresNumber; //cpu 核心数
@property (class, nonatomic, readonly) NSUInteger CPUMaxFrequency; //cpu 最高频率
@property (class, nonatomic, readonly) NSUInteger CPUCurrentFrequency; //cpu 当前频率

@end

#pragma mark - 内存、硬盘信息

@interface SSDeviceTool (SSMemory)

@property (class, nonatomic, readonly) unsigned long long deviceMemorySize;
@property (class, nonatomic, readonly) NSString *deviceMemorySizeString;

@property (class, nonatomic, readonly) unsigned long long deviceMemoryFreeSize;
@property (class, nonatomic, readonly) NSString *deviceMemoryFreeSizeString;

@property (class, nonatomic, readonly) unsigned long long deviceMemoryUsedSize;
@property (class, nonatomic, readonly) NSString *deviceMemoryUsedSizeString;

@property (class, nonatomic, readonly) unsigned long long deviceDiskSize;
@property (class, nonatomic, readonly) NSString *deviceDiskSizeString;

@property (class, nonatomic, readonly) unsigned long long deviceDiskFreeSize;
@property (class, nonatomic, readonly) NSString *deviceDiskFreeSizeString;

@property (class, nonatomic, readonly) unsigned long long deviceDiskUsedSize;
@property (class, nonatomic, readonly) NSString *deviceDiskUsedSizeString;

@end





NS_ASSUME_NONNULL_END
