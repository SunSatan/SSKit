//
//  SSDeviceLibrary.h
//  SSKit
//
//  Created by SunSatan on 2020/9/23.
//  Copyright © 2020 孙铭健. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SSDeviceLibrary : NSObject
/**
 * 设备名称 √
 * @param modelID 设备的机器 model id
 */
+ (NSString *)deviceModelWithMachineModelID:(NSString *)modelID;
/**
 * 设备发售时间 √
 * @param deviceModel 设备的名称，例如: iPhone 11 Pro Max
 */
+ (NSString *)saleTimeWithDevice:(NSString *)deviceModel;
/**
 * 设备 SoC 型号
 * @param deviceModel 设备的名称，例如: iPhone 11 Pro Max
 */
+ (NSString *)SoCNameWithDevice:(NSString *)deviceModel;
/**
 * 设备 RAM 类型
 * @param deviceModel 设备的名称，例如: iPhone 11 Pro Max
 */
+ (NSString *)memoryTypeWithDevice:(NSString *)deviceModel;
/**
 * 设备屏幕像素密度 PPI
 * @param deviceModel 设备的名称，例如: iPhone 11 Pro Max
 */
+ (NSString *)ppiWithDevice:(NSString *)deviceModel;
/**
 * 设备屏幕尺寸
 * @param deviceModel 设备的名称，例如: iPhone 11 Pro Max
 */
+ (NSString *)screenSizeWithDevice:(NSString *)deviceModel;
/**
 * 设备能更新最高的 iOS 版本
 * @param deviceModel 设备的名称，例如: iPhone 11 Pro Max
 */
+ (NSString *)latestOSVersionWithDevice:(NSString *)deviceModel;
/**
 * 设备宽高比
 * @param deviceModel 设备的名称，例如: iPhone 11 Pro Max
 */
+ (NSString *)aspectRatioWithDevice:(NSString *)deviceModel;
/**
 * 设备 GPU 核心数
 * @param deviceModel 设备的名称，例如: iPhone 11 Pro Max
 */
+ (NSString *)GPUCoresNumberWithDevice:(NSString *)deviceModel;
/**
 * 设备 CPU 核心频率
 * @param SoCName 设备的 soc 名字
 * @param showMHz 频率单位显示 MHz，默认显示为 GHz
 */
+ (NSString *)CPUFrequencyWithSoC:(NSString *)SoCName showMHz:(BOOL)showMHz;

@end

NS_ASSUME_NONNULL_END
