//
//  SSDeviceLibrary.h
//  SSKit
//
//  Created by SunSatan on 2020/9/23.
//  Copyright © 2020 SunSatan. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 数据来源于：https://support.apple.com/zh_CN/specs/iphone */
/** 数据来源于：https://www.theiphonewiki.com/wiki/Models */
/** 数据来源于：https://www.blakespot.com/ios_device_specifications_grid.html */

NS_ASSUME_NONNULL_BEGIN

//************ DeviceInfo Key ************//
extern NSString * const SSSaleTime;
extern NSString * const SSSoCName;
extern NSString * const SSMemoryType;
extern NSString * const SSPPI;
extern NSString * const SSScreenSize;
extern NSString * const SSLatestOSVersion;
extern NSString * const SSDeviceWidth;
extern NSString * const SSDeviceHeight;
extern NSString * const SSDeviceDepth;
extern NSString * const SSDeviceWeight;
extern NSString * const SSDisplayScreen;
extern NSString * const SSSIMCard;

//************ SocInfo Key ************//
extern NSString * const SSGPUCoresNumber;
extern NSString * const SSCPUFrequency;

@interface SSDeviceLibrary : NSObject

@property (class, nonatomic, readonly) NSDictionary *SocInfo;
@property (class, nonatomic, readonly) NSDictionary *DeviceInfo;

/**
 * 设备名称
 * @param modelID 设备的机器 model id
 */
+ (NSString *)deviceModelWithMachineModelID:(NSString *)modelID;
/**
 * 设备发售时间
 * @param deviceName 设备的名称，例如: iPhone 11 Pro Max
 */
+ (NSString *)saleTimeWithDevice:(NSString *)deviceName;
/**
 * 设备 SoC 型号
 * @param deviceName 设备的名称，例如: iPhone 11 Pro Max
 */
+ (NSString *)SoCNameWithDevice:(NSString *)deviceName;
/**
 * 设备 RAM 类型
 * @param deviceName 设备的名称，例如: iPhone 11 Pro Max
 */
+ (NSString *)memoryTypeWithDevice:(NSString *)deviceName;
/**
 * 设备屏幕像素密度 PPI
 * @param deviceName 设备的名称，例如: iPhone 11 Pro Max
 */
+ (NSUInteger)ppiWithDevice:(NSString *)deviceName;
/**
 * 设备屏幕尺寸， 默认单位为英寸
 * @param deviceName 设备的名称，例如: iPhone 11 Pro Max
 */
+ (NSUInteger)screenSizeWithDevice:(NSString *)deviceName;
/**
 * 设备能更新最高的 iOS 版本
 * @param deviceName 设备的名称，例如: iPhone 11 Pro Max
 */
+ (NSString *)latestOSVersionWithDevice:(NSString *)deviceName;
/**
 * 设备宽高比
 * @param screenSize 屏幕尺寸: 4.7
 */
+ (NSString *)aspectRatioWithScreenSize:(NSUInteger)screenSize;
/**
 * 设备 CPU 核心频率，单位是 MHz
 * @param SoCName 设备的 soc 名字: Apple A9
 */
+ (NSInteger)CPUFrequencyWithSoC:(NSString *)SoCName;
/**
 * 设备 GPU 核心数
 * @param SoCName 设备的 soc 名字: Apple A9
 */
+ (NSInteger)GPUCoresNumberWithSoC:(NSString *)SoCName;
/**
 * 设备 SIM 卡支持
 * @param deviceName 设备的名称，例如: iPhone 11 Pro Max
 */
+ (NSString *)SIMCardWithDevice:(NSString *)deviceName;
/**
 * 设备显示屏类型
 * @param deviceName 设备的名称，例如: iPhone 11 Pro Max
 */
+ (NSString *)displayScreenWithDevice:(NSString *)deviceName;
/**
 * 设备重量，默认单位为克(g)
 * @param deviceName 设备的名称，例如: iPhone 11 Pro Max
 */
+ (NSInteger)deviceWeightWithDevice:(NSString *)deviceName;
/**
 * 设备宽度，默认单位为毫米(mm)
 * @param deviceName 设备的名称，例如: iPhone 11 Pro Max
 */
+ (NSInteger)deviceWidthWithDevice:(NSString *)deviceName;
/**
 * 设备高度，默认单位为毫米(mm)
 * @param deviceName 设备的名称，例如: iPhone 11 Pro Max
 */
+ (NSInteger)deviceHeightWithDevice:(NSString *)deviceName;
/**
 * 设备厚度，默认单位为毫米(mm)
 * @param deviceName 设备的名称，例如: iPhone 11 Pro Max
 */
+ (NSInteger)deviceDepthWithDevice:(NSString *)deviceName;
/**
 * 设备尺寸：78.1 mm x 160.8 mm x 7.4 mm
 * @param deviceName 设备的名称，例如: iPhone 11 Pro Max
 */
+ (NSString *)deviceSizeWithDevice:(NSString *)deviceName;

@end

NS_ASSUME_NONNULL_END
