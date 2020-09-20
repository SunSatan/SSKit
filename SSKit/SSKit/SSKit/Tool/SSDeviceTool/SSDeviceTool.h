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

#define SCREEN_BOUNDS [UIScreen mainScreen].bounds
#define SCREEN_SIZE   [UIScreen mainScreen].bounds.size
#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

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
/**
 * 获取设备屏幕宽度
 */
@property (class, nonatomic, assign) CGFloat deviceScreenWidth;
/**
 * 获取设备屏幕高度
 */
@property (class, nonatomic, assign) CGFloat deviceScreenHeight;
/**
 * 获取设备状态栏高度
 */
@property (class, nonatomic, assign) CGFloat statusBarHeight;
/**
 * 获取设备导航栏高度
 */
@property (class, nonatomic, assign) CGFloat navigationBarHeight;
/**
 * 获取设备导航工具栏高度
 */
@property (class, nonatomic, assign) CGFloat navigationToolBarHeight;
/**
 * 获取设备标签栏高度
 */
@property (class, nonatomic, assign) CGFloat tabBarHeight;
/**
 * 获取设备安全区域
 */
@property (class, nonatomic, assign) CGRect safeAreaFrame;
/**
 * 获取设备安全区域左边距
 */
@property (class, nonatomic, assign) CGFloat safeAreaLeft;
/**
 * 获取设备安全区域右边距
 */
@property (class, nonatomic, assign) CGFloat safeAreaRight;
/**
 * 获取设备安全区域上边距
 */
@property (class, nonatomic, assign) CGFloat safeAreaTop;
/**
 * 获取设备安全区域下边距
 */
@property (class, nonatomic, assign) CGFloat safeAreaBottom;

@end

#pragma mark - 设备参数

@interface SSDeviceTool (SSDeviceInfo)

/**
 * deviceToken 转换成 pushToken
 */
+ (NSString *)pushTokenForDeviceToken:(NSData *)deviceToken;
/**
 * 获取设备型号：iPhone 6S、iPhone X
 */
@property (class, nonatomic, strong) NSString *deviceModel;
/**
 * 获取设备系统版本：iOS 13.3.1
 */
@property (class, nonatomic, strong) NSString *deviceSystemVersion;
/**
 * 获取设备名称：SunSatan
 */
@property (class, nonatomic, strong) NSString *devicePhoneName;
/**
 * 获取设备IDFV(唯一设备标识)
 */
@property (class, nonatomic, strong) NSString *deviceIDFV;
/**
 * 获取设备IDFA(广告标示符)
 */
@property (class, nonatomic, strong) NSString *deviceIDFA;
/**
 * 获取当前设备语言：zh-Hans-CN(简体中文)
 */
@property (class, nonatomic, strong) NSString *deviceLanguage;
/**
 * 获取当前设备电量
 */
@property (class, nonatomic, assign) CGFloat deviceBatteryLevel;

@end

#pragma mark - app参数
@interface SSDeviceTool (SSAppInfo)

/**
 * 获取当前安装本app名称：DeviceTool
 */
@property (class, nonatomic, strong) NSString *currentAppName;
/**
 * 获取设备当前安装本app版本号 Verion
 */
@property (class, nonatomic, strong) NSString *currentAppVerion;
/**
 * 获取设备当前安装本app构建号 Build
 */
@property (class, nonatomic, strong) NSString *currentAppBuild;

@end

NS_ASSUME_NONNULL_END
