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
 * 设备名称
 * @param modelID 设备的 model id
 */
+ (NSString *)deviceModel:(NSString *)modelID;
/**
 * 设备发售时间
 * @param modelID 设备的 model id
 */
+ (NSString *)deviceSaleTime:(NSString *)modelID;
/**
 * 设备 Soc 型号
 * @param modelID 设备的 model id
 */
+ (NSString *)deviceSoCName:(NSString *)modelID;
/**
 * 设备 RAM 类型
 * @param modelID 设备的 model id
 */
+ (NSString *)deviceMemType:(NSString *)modelID;
/**
 * 设备屏幕像素密度 PPI
 * @param modelID 设备的 model id
 */
+ (NSString *)devicePPI:(NSString *)modelID;
/**
 * 设备屏幕尺寸
 * @param modelID 设备的 model id
 */
+ (NSString *)deviceScreenSize:(NSString *)modelID;
/**
 * 设备能更新最高的iOS版本
 * @param modelID 设备的 model id
 */
+ (NSString *)deviceLatestOSVersion:(NSString *)modelID;


@end

NS_ASSUME_NONNULL_END
