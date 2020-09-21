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

#pragma mark - 屏幕参数

@interface SSDeviceTool (SSDeviceScreen)

@property (class, nonatomic, assign) CGRect  deviceScreenBounds; //获取设备屏幕Bounds
@property (class, nonatomic, assign) CGFloat deviceScreenWidth;  //获取设备屏幕宽度
@property (class, nonatomic, assign) CGFloat deviceScreenHeight; //获取设备屏幕高度

@property (class, nonatomic, assign) CGFloat statusBarHeight; //获取设备状态栏高度

@property (class, nonatomic, assign) CGFloat navigationBarHeight;     //获取设备导航栏高度
@property (class, nonatomic, assign) CGFloat navigationToolBarHeight; //获取设备导航工具栏高度

@property (class, nonatomic, assign) CGFloat tabBarHeight; //获取设备标签栏高度

@property (class, nonatomic, assign) CGRect  safeAreaFrame;  //获取设备安全区域
@property (class, nonatomic, assign) CGFloat safeAreaLeft;   //获取设备安全区域左边距
@property (class, nonatomic, assign) CGFloat safeAreaRight;  //获取设备安全区域右边距
@property (class, nonatomic, assign) CGFloat safeAreaTop;    //获取设备安全区域上边距
@property (class, nonatomic, assign) CGFloat safeAreaBottom; //获取设备安全区域下边距

@end

#pragma mark - 设备参数

@interface SSDeviceTool (SSDeviceInfo)

+ (NSString *)pushTokenForDeviceToken:(NSData *)deviceToken; //将 deviceToken 转换成 pushToken

@property (class, nonatomic, strong) NSString *deviceModel;         //获取设备型号：iPhone 6S、iPhone X
@property (class, nonatomic, strong) NSString *deviceSystemVersion; //获取设备系统版本：iOS 13.3.1
@property (class, nonatomic, strong) NSString *devicePhoneName;     //获取设备名称：SunSatan
@property (class, nonatomic, strong) NSString *deviceIDFV;          //获取设备IDFV(唯一设备标识)
@property (class, nonatomic, strong) NSString *deviceIDFA;          //获取设备IDFA(广告标示符)

@property (class, nonatomic, strong) NSString *deviceLanguage;      //获取当前设备语言：zh-Hans-CN(简体中文)
@property (class, nonatomic, strong) NSString *localeCountry; //获取当前地区国家：en_CN(中国)

@property (class, nonatomic, assign) CGFloat deviceBatteryLevel; //获取当前设备电量

@end

#pragma mark - app参数

@interface SSDeviceTool (SSAppInfo)

@property (class, nonatomic, strong) NSString *currentAppName;   //获取当前安装本app名称 Display Name
@property (class, nonatomic, strong) NSString *currentAppVerion; //获取设备当前安装本app版本号 Verion
@property (class, nonatomic, strong) NSString *currentAppBuild;  //获取设备当前安装本app构建号 Build

@end

#pragma mark - 网络参数

@interface SSDeviceTool (SSNetwork)

@property (class, nonatomic, strong) NSString *networkProvider; //网络服务商、未完成

@end

#pragma mark - fps

typedef void(^FPSDispalyBlock)(CGFloat FPS, NSString *FPSString);

@interface SSDeviceTool (FPS)

- (void)startCalculateFPS:(FPSDispalyBlock)FPSDispalyBlock;
- (void)endCalculateFPS;

@end

NS_ASSUME_NONNULL_END
