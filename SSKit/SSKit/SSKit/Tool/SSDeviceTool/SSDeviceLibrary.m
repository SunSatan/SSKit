//
//  SSDeviceLibrary.m
//  SSKit
//
//  Created by SunSatan on 2020/9/23.
//  Copyright © 2020 SunSatan. All rights reserved.
//

#import "SSDeviceLibrary.h"

NSString * const SSGPUCoresNumber = @"GPUCoresNumber";
NSString * const SSCPUFrequency   = @"CPUFrequency";

NSString * const SSSaleTime        = @"SaleTime";
NSString * const SSSoCName         = @"SoCName";
NSString * const SSMemoryType      = @"MemoryType";
NSString * const SSPPI             = @"PPI";
NSString * const SSScreenSize      = @"ScreenSize";
NSString * const SSLatestOSVersion = @"LatestOSVersion";
NSString * const SSDeviceWidth     = @"DeviceWidth";
NSString * const SSDeviceHeight    = @"DeviceHeight";
NSString * const SSDeviceDepth     = @"DeviceDepth";
NSString * const SSDeviceWeight    = @"DeviceWeight";
NSString * const SSDisplayScreen   = @"DisplayScreen";
NSString * const SSSIMCard         = @"SIMCard";

static NSString * const SSLatestOSVersionNow = @"至今最新";
static NSString * const SSSingleSIMCard = @"单卡单待";
static NSString * const SSDualSIMCard   = @"双卡双待";
static NSString * const SSNoSIMCard   = @"不支持SIM卡";

@implementation SSDeviceLibrary

+ (NSString *)deviceModelWithMachineModelID:(NSString *)modelID
{
    if ([modelID isEqualToString:@"iPhone5,1"])  return @"iPhone 5";
    if ([modelID isEqualToString:@"iPhone5,2"])  return @"iPhone 5";
    if ([modelID isEqualToString:@"iPhone5,3"])  return @"iPhone 5C";
    if ([modelID isEqualToString:@"iPhone5,4"])  return @"iPhone 5C";
    if ([modelID isEqualToString:@"iPhone6,1"])  return @"iPhone 5S";
    if ([modelID isEqualToString:@"iPhone6,2"])  return @"iPhone 5S";
    if ([modelID isEqualToString:@"iPhone7,2"])  return @"iPhone 6";
    if ([modelID isEqualToString:@"iPhone7,1"])  return @"iPhone 6 Plus";
    if ([modelID isEqualToString:@"iPhone8,1"])  return @"iPhone 6S";
    if ([modelID isEqualToString:@"iPhone8,2"])  return @"iPhone 6S Plus";
    if ([modelID isEqualToString:@"iPhone8,4"])  return @"iPhone SE";
    if ([modelID isEqualToString:@"iPhone9,1"])  return @"iPhone 7";
    if ([modelID isEqualToString:@"iPhone9,3"])  return @"iPhone 7";
    if ([modelID isEqualToString:@"iPhone9,2"])  return @"iPhone 7 Plus";
    if ([modelID isEqualToString:@"iPhone9,4"])  return @"iPhone 7 Plus";
    if ([modelID isEqualToString:@"iPhone10,1"]) return @"iPhone 8";
    if ([modelID isEqualToString:@"iPhone10,4"]) return @"iPhone 8";
    if ([modelID isEqualToString:@"iPhone10,2"]) return @"iPhone 8 Plus";
    if ([modelID isEqualToString:@"iPhone10,5"]) return @"iPhone 8 Plus";
    if ([modelID isEqualToString:@"iPhone10,3"]) return @"iPhone X";
    if ([modelID isEqualToString:@"iPhone10,6"]) return @"iPhone X";
    if ([modelID isEqualToString:@"iPhone11,8"]) return @"iPhone XR";
    if ([modelID isEqualToString:@"iPhone11,2"]) return @"iPhone XS";
    if ([modelID isEqualToString:@"iPhone11,6"]) return @"iPhone XS Max";
    if ([modelID isEqualToString:@"iPhone11,4"]) return @"iPhone XS Max";
    if ([modelID isEqualToString:@"iPhone12,1"]) return @"iPhone 11";
    if ([modelID isEqualToString:@"iPhone12,3"]) return @"iPhone 11 Pro";
    if ([modelID isEqualToString:@"iPhone12,5"]) return @"iPhone 11 Pro Max";
    if ([modelID isEqualToString:@"iPhone12,8"]) return @"iPhone SE 2";
    if ([modelID isEqualToString:@"iPhone13,1"]) return @"iPhone 12 mini";
    if ([modelID isEqualToString:@"iPhone13,2"]) return @"iPhone 12";
    if ([modelID isEqualToString:@"iPhone13,3"]) return @"iPhone 12 Pro";
    if ([modelID isEqualToString:@"iPhone13,4"]) return @"iPhone 12 Pro Max";
    
    if ([modelID isEqualToString:@"iPad3,4"])  return @"iPad 4";
    if ([modelID isEqualToString:@"iPad3,5"])  return @"iPad 4";
    if ([modelID isEqualToString:@"iPad3,6"])  return @"iPad 4";
    if ([modelID isEqualToString:@"iPad6,11"]) return @"iPad 5";
    if ([modelID isEqualToString:@"iPad6,12"]) return @"iPad 5";
    if ([modelID isEqualToString:@"iPad7,5"])  return @"iPad 6";
    if ([modelID isEqualToString:@"iPad7,6"])  return @"iPad 6";
    if ([modelID isEqualToString:@"iPad7,11"]) return @"iPad 7";
    if ([modelID isEqualToString:@"iPad7,12"]) return @"iPad 7";
    if ([modelID isEqualToString:@"iPad11,6"]) return @"iPad 8";
    if ([modelID isEqualToString:@"iPad11,7"]) return @"iPad 8";

    if ([modelID isEqualToString:@"iPad4,1"])  return @"iPad Air";
    if ([modelID isEqualToString:@"iPad4,2"])  return @"iPad Air";
    if ([modelID isEqualToString:@"iPad4,3"])  return @"iPad Air";
    if ([modelID isEqualToString:@"iPad5,3"])  return @"iPad Air 2";
    if ([modelID isEqualToString:@"iPad5,4"])  return @"iPad Air 2";
    if ([modelID isEqualToString:@"iPad11,3"]) return @"iPad Air 3";
    if ([modelID isEqualToString:@"iPad11,4"]) return @"iPad Air 3";
    if ([modelID isEqualToString:@"iPad13,1"]) return @"iPad Air 4";
    if ([modelID isEqualToString:@"iPad13,2"]) return @"iPad Air 4";

    if ([modelID isEqualToString:@"iPad6,7"])  return @"iPad Pro 12.9\"";
    if ([modelID isEqualToString:@"iPad6,8"])  return @"iPad Pro 12.9\"";
    if ([modelID isEqualToString:@"iPad6,3"])  return @"iPad Pro 9.7\"";
    if ([modelID isEqualToString:@"iPad6,4"])  return @"iPad Pro 9.7\"";
    if ([modelID isEqualToString:@"iPad7,1"])  return @"iPad Pro 2 12.9\"";
    if ([modelID isEqualToString:@"iPad7,2"])  return @"iPad Pro 2 12.9\"";
    if ([modelID isEqualToString:@"iPad7,3"])  return @"iPad Pro 10.5\"";
    if ([modelID isEqualToString:@"iPad7,4"])  return @"iPad Pro 10.5\"";
    if ([modelID isEqualToString:@"iPad8,1"])  return @"iPad Pro 11\"";
    if ([modelID isEqualToString:@"iPad8,2"])  return @"iPad Pro 11\"";
    if ([modelID isEqualToString:@"iPad8,3"])  return @"iPad Pro 11\"";
    if ([modelID isEqualToString:@"iPad8,4"])  return @"iPad Pro 11\"";
    if ([modelID isEqualToString:@"iPad8,5"])  return @"iPad Pro 3 12.9\"";
    if ([modelID isEqualToString:@"iPad8,6"])  return @"iPad Pro 3 12.9\"";
    if ([modelID isEqualToString:@"iPad8,7"])  return @"iPad Pro 3 12.9\"";
    if ([modelID isEqualToString:@"iPad8,8"])  return @"iPad Pro 3 12.9\"";
    if ([modelID isEqualToString:@"iPad8,9"])  return @"iPad Pro 2 11\"";
    if ([modelID isEqualToString:@"iPad8,10"]) return @"iPad Pro 2 11\"";
    if ([modelID isEqualToString:@"iPad8,11"]) return @"iPad Pro 4 12.9\"";
    if ([modelID isEqualToString:@"iPad8,12"]) return @"iPad Pro 4 12.9\"";

    if ([modelID isEqualToString:@"iPad4,4"])  return @"iPad Mini 2";
    if ([modelID isEqualToString:@"iPad4,5"])  return @"iPad Mini 2";
    if ([modelID isEqualToString:@"iPad4,6"])  return @"iPad Mini 2";
    if ([modelID isEqualToString:@"iPad4,7"])  return @"iPad Mini 3";
    if ([modelID isEqualToString:@"iPad4,8"])  return @"iPad Mini 3";
    if ([modelID isEqualToString:@"iPad4,9"])  return @"iPad Mini 3";
    if ([modelID isEqualToString:@"iPad5,1"])  return @"iPad Mini 4";
    if ([modelID isEqualToString:@"iPad5,2"])  return @"iPad Mini 4";
    if ([modelID isEqualToString:@"iPad11,1"]) return @"iPad Mini 5";
    if ([modelID isEqualToString:@"iPad11,2"]) return @"iPad Mini 5";

    if ([modelID isEqualToString:@"iPod7,1"]) return @"iPod Touch 6";
    if ([modelID isEqualToString:@"iPod9,1"]) return @"iPod Touch 7";

    return @"未知";
}

+ (NSString *)saleTimeWithDevice:(NSString *)deviceName
{
    return self.DeviceInfo[deviceName][SSSaleTime];
}

+ (NSString *)SoCNameWithDevice:(NSString *)deviceName
{
    return self.DeviceInfo[deviceName][SSSoCName];
}

+ (NSString *)memoryTypeWithDevice:(NSString *)deviceName
{
    return self.DeviceInfo[deviceName][SSMemoryType];
}

+ (NSUInteger)ppiWithDevice:(NSString *)deviceName
{
    return [self.DeviceInfo[deviceName][SSPPI] integerValue];
}

+ (float)screenSizeWithDevice:(NSString *)deviceName
{
    return [self.DeviceInfo[deviceName][SSScreenSize] integerValue];
}

+ (NSString *)latestOSVersionWithDevice:(NSString *)deviceName
{
    return self.DeviceInfo[deviceName][SSLatestOSVersion];
}

+ (NSString *)aspectRatioWithScreenSize:(float)screenSize
{
    if (screenSize <= 3.5)  return @"2:3";
    if (screenSize <= 4)    return @"9:16";
    if (screenSize <= 4.7)  return @"9:16";
    if (screenSize <= 5.4)  return @"9:19.5";
    if (screenSize <= 5.5)  return @"9:16";
    if (screenSize <= 5.8)  return @"9:19.5";
    if (screenSize <= 6.1)  return @"9:19.5";
    if (screenSize <= 6.5)  return @"9:19.5";
    if (screenSize <= 6.7)  return @"9:19.5";
    if (screenSize <= 7.9)  return @"3:4";
    if (screenSize <= 9.7)  return @"3:4";
    if (screenSize <= 10.2) return @"3:4";
    if (screenSize <= 10.5) return @"3:4";
    if (screenSize <= 10.9) return @"7:10";
    if (screenSize <= 11)   return @"7:10";
    if (screenSize <= 12.9) return @"3:4";
    
    return @"未知";
}

+ (NSInteger)CPUFrequencyWithSoC:(NSString *)SoCName
{
    return [self.SocInfo[SoCName][SSCPUFrequency] integerValue];
}

+ (NSInteger)GPUCoresNumberWithSoC:(NSString *)SoCName
{
    return [self.SocInfo[SoCName][SSGPUCoresNumber] integerValue];
}

+ (float)deviceWidthWithDevice:(NSString *)deviceName
{
    return [self.DeviceInfo[deviceName][SSDeviceWidth] floatValue];
}

+ (float)deviceHeightWithDevice:(NSString *)deviceName
{
    return [self.DeviceInfo[deviceName][SSDeviceHeight] floatValue];
}

+ (float)deviceDepthWithDevice:(NSString *)deviceName
{
    return [self.DeviceInfo[deviceName][SSDeviceDepth] floatValue];
}

+ (NSString *)deviceSizeWithDevice:(NSString *)deviceName
{
    return [NSString stringWithFormat:@"%.1lf mm x %.1lf mm x %.1lf mm",
            [self deviceWidthWithDevice:deviceName],
            [self deviceHeightWithDevice:deviceName],
            [self deviceDepthWithDevice:deviceName]];
}

+ (NSInteger)deviceWeightWithDevice:(NSString *)deviceName
{
    return [self.DeviceInfo[deviceName][SSDeviceWeight] integerValue];
}

+ (NSString *)displayScreenWithDevice:(NSString *)deviceName
{
    return self.DeviceInfo[deviceName][SSDisplayScreen];
}

+ (NSString *)SIMCardWithDevice:(NSString *)deviceName
{
    return self.DeviceInfo[deviceName][SSSIMCard];
}

#pragma mark - 数据表

+ (NSDictionary *)SocInfo
{
    static NSDictionary *SocInfo;
    if (!SocInfo) {
        SocInfo = @{
            @"Apple A14 Bionic":@{SSGPUCoresNumber:@(4),
                                  SSCPUFrequency:@(3000)},
            @"Apple A12Z":@{SSGPUCoresNumber:@(8),
                            SSCPUFrequency:@(2490)},
            @"Apple A13 Bionic":@{SSGPUCoresNumber:@(4),
                                  SSCPUFrequency:@(2650)},
            @"Apple A12X Bionic":@{SSGPUCoresNumber:@(7),
                                   SSCPUFrequency:@(2490)},
            @"Apple A12 Bionic":@{SSGPUCoresNumber:@(4),
                                  SSCPUFrequency:@(2490)},
            @"Apple A11 Bionic":@{SSGPUCoresNumber:@(3),
                                  SSCPUFrequency:@(2360)},
            @"Apple A10X Fusion":@{SSGPUCoresNumber:@(12),
                                   SSCPUFrequency:@(2360)},
            @"Apple A10 Fusion":@{SSGPUCoresNumber:@(6),
                                  SSCPUFrequency:@(2340)},
            @"Apple A9X":@{SSGPUCoresNumber:@(12),
                           SSCPUFrequency:@(2260)},
            @"Apple A9":@{SSGPUCoresNumber:@(6),
                          SSCPUFrequency:@(1850)},
            @"Apple A8X":@{SSGPUCoresNumber:@(8),
                           SSCPUFrequency:@(1500)},
            @"Apple A8":@{SSGPUCoresNumber:@(4),
                          SSCPUFrequency:@(1400)},
            @"Apple A7":@{SSGPUCoresNumber:@(4),
                          SSCPUFrequency:@(1300)},
            @"Apple A6X":@{SSGPUCoresNumber:@(4),
                           SSCPUFrequency:@(1400)},
            @"Apple A6":@{SSGPUCoresNumber:@(3),
                          SSCPUFrequency:@(1300)}
        };
    }
    return SocInfo;
}

+ (NSDictionary *)DeviceInfo
{
    static NSDictionary *deviceInfo;
    if (!deviceInfo) {
        deviceInfo = @{
#pragma mark - iPhone
            @"iPhone 12 Pro Max":@{SSSaleTime:@"2020-10-16",
                                   SSSoCName:@"Apple A14 Bionic",
                                   SSMemoryType:@"LPDDR4X",
                                   SSPPI:@(458),
                                   SSScreenSize:@(6.7),
                                   SSLatestOSVersion:SSLatestOSVersionNow,
                                   SSDeviceWidth:@(78.1),
                                   SSDeviceHeight:@(160.8),
                                   SSDeviceDepth:@(7.4),
                                   SSDeviceWeight:@(226),
                                   SSDisplayScreen:@"超视网膜 XDR 显示屏",
                                   SSSIMCard:SSDualSIMCard},
            @"iPhone 12 Pro":@{SSSaleTime:@"2020-10-16",
                               SSSoCName:@"Apple A14 Bionic",
                               SSMemoryType:@"LPDDR4X",
                               SSPPI:@(460),
                               SSScreenSize:@(6.1),
                               SSLatestOSVersion:SSLatestOSVersionNow,
                               SSDeviceWidth:@(71.5),
                               SSDeviceHeight:@(146.7),
                               SSDeviceDepth:@(7.4),
                               SSDeviceWeight:@(187),
                               SSDisplayScreen:@"超视网膜 XDR 显示屏",
                               SSSIMCard:SSDualSIMCard},
            @"iPhone 12":@{SSSaleTime:@"2020-10-16",
                           SSSoCName:@"Apple A14 Bionic",
                           SSMemoryType:@"LPDDR4X",
                           SSPPI:@(460),
                           SSScreenSize:@(.1),
                           SSLatestOSVersion:SSLatestOSVersionNow,
                           SSDeviceWidth:@(71.5),
                           SSDeviceHeight:@(146.7),
                           SSDeviceDepth:@(7.4),
                           SSDeviceWeight:@(162),
                           SSDisplayScreen:@"超视网膜 XDR 显示屏",
                           SSSIMCard:SSDualSIMCard},
            @"iPhone 12 mini":@{SSSaleTime:@"2020-10-16",
                                SSSoCName:@"Apple A14 Bionic",
                                SSMemoryType:@"LPDDR4X",
                                SSPPI:@(476),
                                SSScreenSize:@(5.4),
                                SSLatestOSVersion:SSLatestOSVersionNow,
                                SSDeviceWidth:@(64.2),
                                SSDeviceHeight:@(131.5),
                                SSDeviceDepth:@(7.4),
                                SSDeviceWeight:@(133),
                                SSDisplayScreen:@"超视网膜 XDR 显示屏",
                                SSSIMCard:SSSingleSIMCard},
            @"iPhone SE 2":@{SSSaleTime:@"2020-4-15",
                             SSSoCName:@"Apple A13 Bionic",
                             SSMemoryType:@"LPDDR4X",
                             SSPPI:@(326),
                             SSScreenSize:@(4.7),
                             SSLatestOSVersion:SSLatestOSVersionNow,
                             SSDeviceWidth:@(67.3),
                             SSDeviceHeight:@(138.4),
                             SSDeviceDepth:@(7.3),
                             SSDeviceWeight:@(148),
                             SSDisplayScreen:@"视网膜高清 LCD 显示屏",
                             SSSIMCard:SSSingleSIMCard},
            @"iPhone 11 Pro Max":@{SSSaleTime:@"2019-9-11",
                                   SSSoCName:@"Apple A13 Bionic",
                                   SSMemoryType:@"LPDDR4X",
                                   SSPPI:@(458),
                                   SSScreenSize:@(6.5),
                                   SSLatestOSVersion:SSLatestOSVersionNow,
                                   SSDeviceWidth:@(77.8),
                                   SSDeviceHeight:@(158.0),
                                   SSDeviceDepth:@(8.1),
                                   SSDeviceWeight:@(226),
                                   SSDisplayScreen:@"超视网膜 XDR 显示屏",
                                   SSSIMCard:SSDualSIMCard},
            @"iPhone 11 Pro":@{SSSaleTime:@"2019-9-11",
                               SSSoCName:@"Apple A13 Bionic",
                               SSMemoryType:@"LPDDR4X",
                               SSPPI:@(458),
                               SSScreenSize:@(5.8),
                               SSLatestOSVersion:SSLatestOSVersionNow,
                               SSDeviceWidth:@(71.4),
                               SSDeviceHeight:@(144.0),
                               SSDeviceDepth:@(8.1),
                               SSDeviceWeight:@(188),
                               SSDisplayScreen:@"超视网膜 XDR 显示屏",
                               SSSIMCard:SSDualSIMCard},
            @"iPhone 11":@{SSSaleTime:@"2019-9-11",
                           SSSoCName:@"Apple A13 Bionic",
                           SSMemoryType:@"LPDDR4X",
                           SSPPI:@(326),
                           SSScreenSize:@(6.1),
                           SSLatestOSVersion:SSLatestOSVersionNow,
                           SSDeviceWidth:@(75.7),
                           SSDeviceHeight:@(150.9),
                           SSDeviceDepth:@(8.3),
                           SSDeviceWeight:@(194),
                           SSDisplayScreen:@"视网膜高清 LCD 显示屏",
                           SSSIMCard:SSDualSIMCard},
            @"iPhone XS Max":@{SSSaleTime:@"2018-9-13",
                               SSSoCName:@"Apple A12 Bionic",
                               SSMemoryType:@"LPDDR4X",
                               SSPPI:@(458),
                               SSScreenSize:@(6.5),
                               SSLatestOSVersion:SSLatestOSVersionNow,
                               SSDeviceWidth:@(77.4),
                               SSDeviceHeight:@(157.5),
                               SSDeviceDepth:@(7.7),
                               SSDeviceWeight:@(208),
                               SSDisplayScreen:@"超视网膜高清 OLED 显示屏",
                               SSSIMCard:SSDualSIMCard},
            @"iPhone XS":@{SSSaleTime:@"2018-9-13",
                          SSSoCName:@"Apple A12 Bionic",
                          SSMemoryType:@"LPDDR4X",
                          SSPPI:@(458),
                          SSScreenSize:@(5.8),
                          SSLatestOSVersion:SSLatestOSVersionNow,
                          SSDeviceWidth:@(70.9),
                          SSDeviceHeight:@(143.6),
                          SSDeviceDepth:@(7.7),
                          SSDeviceWeight:@(177),
                          SSDisplayScreen:@"超视网膜高清 OLED 显示屏",
                           SSSIMCard:SSSingleSIMCard},
            @"iPhone XR":@{SSSaleTime:@"2018-9-13",
                           SSSoCName:@"Apple A12 Bionic",
                           SSMemoryType:@"LPDDR4X",
                           SSPPI:@(326),
                           SSScreenSize:@(6.1),
                           SSLatestOSVersion:SSLatestOSVersionNow,
                           SSDeviceWidth:@(75.7),
                           SSDeviceHeight:@(150.9),
                           SSDeviceDepth:@(8.3),
                           SSDeviceWeight:@(194),
                           SSDisplayScreen:@"视网膜高清 LCD 显示屏",
                           SSSIMCard:SSDualSIMCard},
            @"iPhone X":@{SSSaleTime:@"2017-9-13",
                          SSSoCName:@"Apple A11 Bionic",
                          SSMemoryType:@"LPDDR4",
                          SSPPI:@(458),
                          SSScreenSize:@(5.8),
                          SSLatestOSVersion:SSLatestOSVersionNow,
                          SSDeviceWidth:@(70.9),
                          SSDeviceHeight:@(143.6),
                          SSDeviceDepth:@(7.7),
                          SSDeviceWeight:@(174),
                          SSDisplayScreen:@"超视网膜高清 OLED 显示屏",
                          SSSIMCard:SSSingleSIMCard},
            @"iPhone 8 Plus":@{SSSaleTime:@"2017-9-13",
                               SSSoCName:@"Apple A11 Bionic",
                               SSMemoryType:@"LPDDR4",
                               SSPPI:@(401),
                               SSScreenSize:@(5.5),
                               SSLatestOSVersion:SSLatestOSVersionNow,
                               SSDeviceWidth:@(78.1),
                               SSDeviceHeight:@(158.4),
                               SSDeviceDepth:@(7.5),
                               SSDeviceWeight:@(202),
                               SSDisplayScreen:@"视网膜高清 LCD 显示屏",
                               SSSIMCard:SSSingleSIMCard},
            @"iPhone 8":@{SSSaleTime:@"2017-9-13",
                          SSSoCName:@"Apple A11 Bionic",
                          SSMemoryType:@"LPDDR4",
                          SSPPI:@(326),
                          SSScreenSize:@(4.7),
                          SSLatestOSVersion:SSLatestOSVersionNow,
                          SSDeviceWidth:@(67.3),
                          SSDeviceHeight:@(138.4),
                          SSDeviceDepth:@(7.3),
                          SSDeviceWeight:@(148),
                          SSDisplayScreen:@"视网膜高清 LCD 显示屏",
                          SSSIMCard:SSSingleSIMCard},
            @"iPhone 7 Plus":@{SSSaleTime:@"2016-9-8",
                               SSSoCName:@"Apple A10 Fusion",
                               SSMemoryType:@"LPDDR4",
                               SSPPI:@(401),
                               SSScreenSize:@(5.5),
                               SSLatestOSVersion:SSLatestOSVersionNow,
                               SSDeviceWidth:@(77.9),
                               SSDeviceHeight:@(158.2),
                               SSDeviceDepth:@(7.3),
                               SSDeviceWeight:@(188),
                               SSDisplayScreen:@"视网膜高清 LCD 显示屏",
                               SSSIMCard:SSSingleSIMCard},
            @"iPhone 7":@{SSSaleTime:@"2016-9-8",
                          SSSoCName:@"Apple A10 Fusion",
                          SSMemoryType:@"LPDDR4",
                          SSPPI:@(326),
                          SSScreenSize:@(4.7),
                          SSLatestOSVersion:SSLatestOSVersionNow,
                          SSDeviceWidth:@(67.1),
                          SSDeviceHeight:@(138.3),
                          SSDeviceDepth:@(7.1),
                          SSDeviceWeight:@(138),
                          SSDisplayScreen:@"视网膜高清 LCD 显示屏",
                          SSSIMCard:SSSingleSIMCard},
            @"iPhone SE":@{SSSaleTime:@"2016-3-21",
                           SSSoCName:@"Apple A9",
                           SSMemoryType:@"LPDDR4",
                           SSPPI:@(326),
                           SSScreenSize:@(4),
                           SSLatestOSVersion:SSLatestOSVersionNow,
                           SSDeviceWidth:@(58.6),
                           SSDeviceHeight:@(123.8),
                           SSDeviceDepth:@(7.6),
                           SSDeviceWeight:@(113),
                           SSDisplayScreen:@"视网膜 LCD 显示屏",
                           SSSIMCard:SSSingleSIMCard},
            @"iPhone 6S Plus":@{SSSaleTime:@"2015-9-10",
                                SSSoCName:@"Apple A9",
                                SSMemoryType:@"LPDDR4",
                                SSPPI:@(401),
                                SSScreenSize:@(5.5),
                                SSLatestOSVersion:SSLatestOSVersionNow,
                                SSDeviceWidth:@(77.9),
                                SSDeviceHeight:@(158.2),
                                SSDeviceDepth:@(7.3),
                                SSDeviceWeight:@(192),
                                SSDisplayScreen:@"视网膜高清 LCD 显示屏",
                                SSSIMCard:SSSingleSIMCard},
            @"iPhone 6S":@{SSSaleTime:@"2015-9-10",
                           SSSoCName:@"Apple A9",
                           SSMemoryType:@"LPDDR4",
                           SSPPI:@(326),
                           SSScreenSize:@(4.7),
                           SSLatestOSVersion:SSLatestOSVersionNow,
                           SSDeviceWidth:@(67.1),
                           SSDeviceHeight:@(138.3),
                           SSDeviceDepth:@(7.1),
                           SSDeviceWeight:@(143),
                           SSDisplayScreen:@"视网膜高清 LCD 显示屏",
                           SSSIMCard:SSSingleSIMCard},
            @"iPhone 6 Plus":@{SSSaleTime:@"2014-9-9",
                               SSSoCName:@"Apple A8",
                               SSMemoryType:@"LPDDR3",
                               SSPPI:@(401),
                               SSScreenSize:@(5.5),
                               SSLatestOSVersion:@"iOS 12.2",
                               SSDeviceWidth:@(77.8),
                               SSDeviceHeight:@(158.1),
                               SSDeviceDepth:@(7.1),
                               SSDeviceWeight:@(172),
                               SSDisplayScreen:@"视网膜高清 LED 显示屏",
                               SSSIMCard:SSSingleSIMCard},
            @"iPhone 6":@{SSSaleTime:@"2014-9-9",
                          SSSoCName:@"Apple A8",
                          SSMemoryType:@"LPDDR3",
                          SSPPI:@(326),
                          SSScreenSize:@(4.7),
                          SSLatestOSVersion:@"iOS 12.2",
                          SSDeviceWidth:@(67.0),
                          SSDeviceHeight:@(138.1),
                          SSDeviceDepth:@(6.9),
                          SSDeviceWeight:@(129),
                          SSDisplayScreen:@"视网膜高清 LED 显示屏",
                          SSSIMCard:SSSingleSIMCard},
            @"iPhone 5S":@{SSSaleTime:@"2013-9-12",
                          SSSoCName:@"Apple A7",
                          SSMemoryType:@"LPDDR2",
                          SSPPI:@(326),
                          SSScreenSize:@(4),
                          SSLatestOSVersion:@"iOS 12.2",
                          SSDeviceWidth:@(58.6),
                          SSDeviceHeight:@(123.8),
                          SSDeviceDepth:@(7.6),
                          SSDeviceWeight:@(112),
                          SSDisplayScreen:@"视网膜 LED 显示屏",
                           SSSIMCard:SSSingleSIMCard},
            @"iPhone 5C":@{SSSaleTime:@"2013-9-12",
                           SSSoCName:@"Apple A6",
                           SSMemoryType:@"LPDDR2",
                           SSPPI:@(326),
                           SSScreenSize:@(4),
                           SSLatestOSVersion:@"iOS 10.3.3",
                           SSDeviceWidth:@(59.2),
                           SSDeviceHeight:@(124.4),
                           SSDeviceDepth:@(8.97),
                           SSDeviceWeight:@(132),
                           SSDisplayScreen:@"视网膜 LED 显示屏",
                           SSSIMCard:SSSingleSIMCard},
            @"iPhone 5":@{SSSaleTime:@"2012-9-21",
                          SSSoCName:@"Apple A6",
                          SSMemoryType:@"LPDDR2",
                          SSPPI:@(326),
                          SSScreenSize:@(4),
                          SSLatestOSVersion:@"iOS 10.3.3",
                          SSDeviceWidth:@(58.6),
                          SSDeviceHeight:@(123.8),
                          SSDeviceDepth:@(7.6),
                          SSDeviceWeight:@(112),
                          SSDisplayScreen:@"视网膜 LED 显示屏",
                          SSSIMCard:SSSingleSIMCard
            },
#pragma mark - iPod Touch
            @"iPod Touch 7":@{SSSaleTime:@"2019-5-28",
                              SSSoCName:@"Apple A10 Fusion",
                              SSMemoryType:@"LPDDR4",
                              SSPPI:@(326),
                              SSScreenSize:@(4),
                              SSLatestOSVersion:SSLatestOSVersionNow,
                              SSDeviceWidth:@(58.6),
                              SSDeviceHeight:@(123.4),
                              SSDeviceDepth:@(6.1),
                              SSDeviceWeight:@(88),
                              SSDisplayScreen:@"视网膜 LED 显示屏",
                              SSSIMCard:SSNoSIMCard},
            @"iPod Touch 6":@{SSSaleTime:@"2015-7-16",
                              SSSoCName:@"Apple A8",
                              SSMemoryType:@"LPDDR3",
                              SSPPI:@(326),
                              SSScreenSize:@(4),
                              SSLatestOSVersion:@"iOS 12.2",
                              SSDeviceWidth:@(58.6),
                              SSDeviceHeight:@(123.4),
                              SSDeviceDepth:@(6.1),
                              SSDeviceWeight:@(88),
                              SSDisplayScreen:@"视网膜 LED 显示屏",
                              SSSIMCard:SSNoSIMCard},
#pragma mark - iPad
            @"iPad 8":@{SSSaleTime:@"2020-9-16",
                        SSSoCName:@"Apple A12 Bionic",
                        SSMemoryType:@"LPDDR4X",
                        SSPPI:@(264),
                        SSScreenSize:@(10.2),
                        SSLatestOSVersion:SSLatestOSVersionNow,
                        SSDeviceWidth:@(174.1),
                        SSDeviceHeight:@(250.6),
                        SSDeviceDepth:@(7.5),
                        SSDeviceWeight:@(490),
                        SSDisplayScreen:@"视网膜 LED 显示屏",
                        SSSIMCard:SSSingleSIMCard},
            @"iPad 7":@{SSSaleTime:@"2019-9-24",
                        SSSoCName:@"Apple A10 Fusion",
                        SSMemoryType:@"LPDDR4",
                        SSPPI:@(264),
                        SSScreenSize:@(10.2),
                        SSLatestOSVersion:SSLatestOSVersionNow,
                        SSDeviceWidth:@(174.1),
                        SSDeviceHeight:@(250.6),
                        SSDeviceDepth:@(7.5),
                        SSDeviceWeight:@(483),
                        SSDisplayScreen:@"视网膜 LED 显示屏",
                        SSSIMCard:SSSingleSIMCard},
            @"iPad 6":@{SSSaleTime:@"2018-3-27",
                        SSSoCName:@"Apple A10 Fusion",
                        SSMemoryType:@"LPDDR4",
                        SSPPI:@(264),
                        SSScreenSize:@(9.7),
                        SSLatestOSVersion:SSLatestOSVersionNow,
                        SSDeviceWidth:@(169.5),
                        SSDeviceHeight:@(240),
                        SSDeviceDepth:@(7.5),
                        SSDeviceWeight:@(469),
                        SSDisplayScreen:@"视网膜 LED 显示屏",
                        SSSIMCard:SSSingleSIMCard},
            @"iPad 5":@{SSSaleTime:@"2017-3-21",
                        SSSoCName:@"Apple A9",
                        SSMemoryType:@"LPDDR4",
                        SSPPI:@(264),
                        SSScreenSize:@(9.7),
                        SSLatestOSVersion:SSLatestOSVersionNow,
                        SSDeviceWidth:@(169.5),
                        SSDeviceHeight:@(240),
                        SSDeviceDepth:@(7.5),
                        SSDeviceWeight:@(469),
                        SSDisplayScreen:@"视网膜 LED 显示屏",
                        SSSIMCard:SSSingleSIMCard
            },
            @"iPad 4":@{SSSaleTime:@"2012-11-1",
                        SSSoCName:@"Apple A6X",
                        SSMemoryType:@"LPDDR2",
                        SSPPI:@(264),
                        SSScreenSize:@(9.7),
                        SSLatestOSVersion:@"iOS 10.3.3",
                        SSDeviceWidth:@(185.7),
                        SSDeviceHeight:@(241.2),
                        SSDeviceDepth:@(9.4),
                        SSDeviceWeight:@(652),
                        SSDisplayScreen:@"视网膜 LED 显示屏",
                        SSSIMCard:SSSingleSIMCard},
#pragma mark - iPad mini
            @"iPad mini 5":@{SSSaleTime:@"2019-3-18",
                             SSSoCName:@"Apple A12 Bionic",
                             SSMemoryType:@"LPDDR4X",
                             SSPPI:@(326),
                             SSScreenSize:@(7.9),
                             SSLatestOSVersion:SSLatestOSVersionNow,
                             SSDeviceWidth:@(134.8),
                             SSDeviceHeight:@(203.2),
                             SSDeviceDepth:@(6.1),
                             SSDeviceWeight:@(300.5),
                             SSDisplayScreen:@"视网膜 LED 显示屏",
                             SSSIMCard:SSSingleSIMCard},
            @"iPad mini 4":@{SSSaleTime:@"2015-9-9",
                             SSSoCName:@"Apple A8",
                             SSMemoryType:@"LPDDR3",
                             SSPPI:@(326),
                             SSScreenSize:@(7.9),
                             SSLatestOSVersion:SSLatestOSVersionNow,
                             SSDeviceWidth:@(134.8),
                             SSDeviceHeight:@(203.2),
                             SSDeviceDepth:@(6.1),
                             SSDeviceWeight:@(298.8),
                             SSDisplayScreen:@"视网膜 LED 显示屏",
                             SSSIMCard:SSSingleSIMCard},
            @"iPad mini 3":@{SSSaleTime:@"2014-10-16",
                             SSSoCName:@"Apple A7",
                             SSMemoryType:@"LPDDR3",
                             SSPPI:@(326),
                             SSScreenSize:@(7.9),
                             SSLatestOSVersion:@"iOS 12.2",
                             SSDeviceWidth:@(134.7),
                             SSDeviceHeight:@(200),
                             SSDeviceDepth:@(7.5),
                             SSDeviceWeight:@(331),
                             SSDisplayScreen:@"视网膜 LED 显示屏",
                             SSSIMCard:SSSingleSIMCard},
            @"iPad mini 2":@{SSSaleTime:@"2013-11-12",
                             SSSoCName:@"Apple A7",
                             SSMemoryType:@"LPDDR3",
                             SSPPI:@(326),
                             SSScreenSize:@(7.9),
                             SSLatestOSVersion:@"iOS 12.2",
                             SSDeviceWidth:@(134.7),
                             SSDeviceHeight:@(200),
                             SSDeviceDepth:@(7.5),
                             SSDeviceWeight:@(331),
                             SSDisplayScreen:@"视网膜 LED 显示屏",
                             SSSIMCard:SSSingleSIMCard},
#pragma mark - iPad air
            @"iPad Air 4":@{SSSaleTime:@"2020-9-21",
                             SSSoCName:@"Apple A14 Bionic",
                             SSMemoryType:@"LPDDR4X",
                             SSPPI:@(264),
                             SSScreenSize:@(10.9),
                             SSLatestOSVersion:SSLatestOSVersionNow,
                             SSDeviceWidth:@(178.5),
                             SSDeviceHeight:@(247.6),
                             SSDeviceDepth:@(6.1),
                             SSDeviceWeight:@(458),
                             SSDisplayScreen:@"视网膜 LED 显示屏",
                             SSSIMCard:SSSingleSIMCard},
            @"iPad Air 3":@{SSSaleTime:@"2019-3-18",
                             SSSoCName:@"Apple A12 Bionic",
                             SSMemoryType:@"LPDDR4X",
                             SSPPI:@(264),
                             SSScreenSize:@(10.5),
                             SSLatestOSVersion:SSLatestOSVersionNow,
                             SSDeviceWidth:@(174.1),
                             SSDeviceHeight:@(250.6),
                             SSDeviceDepth:@(6.1),
                             SSDeviceWeight:@(456),
                             SSDisplayScreen:@"视网膜 LED 显示屏",
                             SSSIMCard:SSSingleSIMCard},
            @"iPad Air 2":@{SSSaleTime:@"2014-0-16",
                             SSSoCName:@"Apple A8X",
                             SSMemoryType:@"LPDDR3",
                             SSPPI:@(264),
                             SSScreenSize:@(9.7),
                             SSLatestOSVersion:@"iOS 12.2",
                             SSDeviceWidth:@(169.5),
                             SSDeviceHeight:@(240),
                             SSDeviceDepth:@(6.1),
                             SSDeviceWeight:@(437),
                             SSDisplayScreen:@"视网膜 LED 显示屏",
                             SSSIMCard:SSSingleSIMCard},
            @"iPad Air":@{SSSaleTime:@"2013-11-1",
                             SSSoCName:@"Apple A7",
                             SSMemoryType:@"LPDDR3",
                             SSPPI:@(264),
                             SSScreenSize:@(9.7),
                             SSLatestOSVersion:@"iOS 12.2",
                             SSDeviceWidth:@(169.5),
                             SSDeviceHeight:@(240),
                             SSDeviceDepth:@(7.5),
                             SSDeviceWeight:@(469),
                             SSDisplayScreen:@"视网膜 LED 显示屏",
                             SSSIMCard:SSSingleSIMCard},
#pragma mark - iPad Pro
            @"iPad Pro 4 12.9\"":@{SSSaleTime:@"2020-3-23",
                             SSSoCName:@"Apple A12Z",
                             SSMemoryType:@"LPDDR4X",
                             SSPPI:@(264),
                             SSScreenSize:@(12.9),
                             SSLatestOSVersion:SSLatestOSVersionNow,
                             SSDeviceWidth:@(214.9),
                             SSDeviceHeight:@(280.6),
                             SSDeviceDepth:@(5.9),
                             SSDeviceWeight:@(641),
                             SSDisplayScreen:@"视网膜 LED 显示屏",
                             SSSIMCard:SSSingleSIMCard},
            @"iPad Pro 2 11\"":@{SSSaleTime:@"2020-3-23",
                             SSSoCName:@"Apple A12Z",
                             SSMemoryType:@"LPDDR4X",
                             SSPPI:@(264),
                             SSScreenSize:@(11),
                             SSLatestOSVersion:SSLatestOSVersionNow,
                             SSDeviceWidth:@(178.5),
                             SSDeviceHeight:@(247.6),
                             SSDeviceDepth:@(5.9),
                             SSDeviceWeight:@(471),
                             SSDisplayScreen:@"视网膜 LED 显示屏",
                             SSSIMCard:SSSingleSIMCard},
            @"iPad Pro 3 12.9\"":@{SSSaleTime:@"2018-10-30",
                             SSSoCName:@"Apple A12X Bionic",
                             SSMemoryType:@"LPDDR4X",
                             SSPPI:@(264),
                             SSScreenSize:@(12.9),
                             SSLatestOSVersion:SSLatestOSVersionNow,
                             SSDeviceWidth:@(214.9),
                             SSDeviceHeight:@(280.6),
                             SSDeviceDepth:@(5.9),
                             SSDeviceWeight:@(631),
                             SSDisplayScreen:@"视网膜 LED 显示屏",
                             SSSIMCard:SSSingleSIMCard},
            @"iPad Pro 11\"":@{SSSaleTime:@"2018-10-30",
                             SSSoCName:@"Apple A12X Bionic",
                             SSMemoryType:@"LPDDR4X",
                             SSPPI:@(264),
                             SSScreenSize:@(11),
                             SSLatestOSVersion:SSLatestOSVersionNow,
                             SSDeviceWidth:@(178.5),
                             SSDeviceHeight:@(247.6),
                             SSDeviceDepth:@(5.9),
                             SSDeviceWeight:@(468),
                             SSDisplayScreen:@"视网膜 LED 显示屏",
                             SSSIMCard:SSSingleSIMCard},
            @"iPad Pro 2 12.9\"":@{SSSaleTime:@"2017-6-6",
                             SSSoCName:@"Apple A10X Fusion",
                             SSMemoryType:@"LPDDR4",
                             SSPPI:@(264),
                             SSScreenSize:@(12.9),
                             SSLatestOSVersion:SSLatestOSVersionNow,
                             SSDeviceWidth:@(220.6),
                             SSDeviceHeight:@(305.7),
                             SSDeviceDepth:@(6.9),
                             SSDeviceWeight:@(677),
                             SSDisplayScreen:@"视网膜 LED 显示屏",
                             SSSIMCard:SSSingleSIMCard},
            @"iPad Pro 10.5\"":@{SSSaleTime:@"2017-6-6",
                             SSSoCName:@"Apple A10X Fusion",
                             SSMemoryType:@"LPDDR4",
                             SSPPI:@(264),
                             SSScreenSize:@(10.5),
                             SSLatestOSVersion:SSLatestOSVersionNow,
                             SSDeviceWidth:@(174.1),
                             SSDeviceHeight:@(250.6),
                             SSDeviceDepth:@(6.1),
                             SSDeviceWeight:@(469),
                             SSDisplayScreen:@"视网膜 LED 显示屏",
                             SSSIMCard:SSSingleSIMCard},
            @"iPad Pro 9.7\"":@{SSSaleTime:@"2016-3-22",
                             SSSoCName:@"Apple A9X",
                             SSMemoryType:@"LPDDR4",
                             SSPPI:@(264),
                             SSScreenSize:@(9.7),
                             SSLatestOSVersion:SSLatestOSVersionNow,
                             SSDeviceWidth:@(169.5),
                             SSDeviceHeight:@(240),
                             SSDeviceDepth:@(6.1),
                             SSDeviceWeight:@(437),
                             SSDisplayScreen:@"视网膜 LED 显示屏",
                             SSSIMCard:SSSingleSIMCard},
            @"iPad Pro 12.9\"":@{SSSaleTime:@"2015-11-11",
                             SSSoCName:@"Apple A9X",
                             SSMemoryType:@"LPDDR4",
                             SSPPI:@(264),
                             SSScreenSize:@(12.9),
                             SSLatestOSVersion:SSLatestOSVersionNow,
                             SSDeviceWidth:@(220.6),
                             SSDeviceHeight:@(305.7),
                             SSDeviceDepth:@(6.9),
                             SSDeviceWeight:@(713),
                             SSDisplayScreen:@"视网膜 LED 显示屏",
                             SSSIMCard:SSSingleSIMCard}
        };
    }
    return deviceInfo;
}

@end
