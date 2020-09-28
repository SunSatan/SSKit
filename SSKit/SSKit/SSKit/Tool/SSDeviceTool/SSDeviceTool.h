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
    SSMobileOperatorUnknown      //未知
};

@interface SSDeviceTool : NSObject



@end

#pragma mark - 设备参数

@interface SSDeviceTool (SSDeviceInfo)

+ (NSString *)pushTokenForDeviceToken:(NSData *)deviceToken; //将 deviceToken 转换成 pushToken

@property (class, nonatomic, readonly) NSString *deviceModel;         //获取设备型号：iPhone 6S、iPhone X
@property (class, nonatomic, readonly) NSString *deviceSystemVersion; //获取设备系统版本：iOS 13.3.1
@property (class, nonatomic, readonly) NSString *devicePhoneName;     //获取设备名称：SunSatan
@property (class, nonatomic, readonly) NSString *deviceIDFV;          //获取设备IDFV(唯一设备标识)
@property (class, nonatomic, readonly) NSString *deviceIDFA;          //获取设备IDFA(广告标示符)

@property (class, nonatomic, readonly) NSString *deviceLanguage;      //获取当前设备语言：zh-Hans-CN(简体中文)
@property (class, nonatomic, readonly) NSString *localeCountry; //获取当前地区国家：en_CN(中国)

@property (class, nonatomic, readonly) CGFloat deviceBatteryLevel; //获取当前设备电量

@property (class, nonatomic, readonly) NSDate *deviceLatestRestartTime; //最近一次重启时间

@end

#pragma mark - app参数

@interface SSDeviceTool (SSAppInfo)

@property (class, nonatomic, readonly) NSString *currentAppName;   //获取当前安装本app名称 Display Name
@property (class, nonatomic, readonly) NSString *currentAppVerion; //获取设备当前安装本app版本号 Verion
@property (class, nonatomic, readonly) NSString *currentAppBuild;  //获取设备当前安装本app构建号 Build

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

@property (class, nonatomic, readonly) NSString *CPUModel;
//@property (class, nonatomic, assign, readonly) NSUInteger CPUCoresNumber;

@property (class, nonatomic, readonly) NSString *deviceColorHexString;
@property (class, nonatomic, readonly) NSString *deviceEnclosureColorHexString;

@property (class, nonatomic, readonly) NSUInteger ramTotalSize;



@end





NS_ASSUME_NONNULL_END
