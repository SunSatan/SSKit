//
//  SSDeviceLibrary.m
//  SSKit
//
//  Created by SunSatan on 2020/9/23.
//  Copyright © 2020 孙铭健. All rights reserved.
//

#import "SSDeviceLibrary.h"

@implementation SSDeviceLibrary

/** 来源于：https://www.theiphonewiki.com/wiki/Models */
/** 来源于：https://www.blakespot.com/ios_device_specifications_grid.html */

+ (NSString *)deviceModelWithDeviceName:(NSString *)deviceName
{
    if ([deviceName isEqualToString:@"iPhone1,1"])  return @"iPhone";
    if ([deviceName isEqualToString:@"iPhone1,2"])  return @"iPhone 3G";
    if ([deviceName isEqualToString:@"iPhone2,1"])  return @"iPhone 3GS";
    if ([deviceName isEqualToString:@"iPhone3,1"])  return @"iPhone 4";
    if ([deviceName isEqualToString:@"iPhone3,2"])  return @"iPhone 4";
    if ([deviceName isEqualToString:@"iPhone3,3"])  return @"iPhone 4";
    if ([deviceName isEqualToString:@"iPhone4,1"])  return @"iPhone 4S";
    if ([deviceName isEqualToString:@"iPhone5,1"])  return @"iPhone 5";
    if ([deviceName isEqualToString:@"iPhone5,2"])  return @"iPhone 5";
    if ([deviceName isEqualToString:@"iPhone5,3"])  return @"iPhone 5C";
    if ([deviceName isEqualToString:@"iPhone5,4"])  return @"iPhone 5C";
    if ([deviceName isEqualToString:@"iPhone6,1"])  return @"iPhone 5S";
    if ([deviceName isEqualToString:@"iPhone6,2"])  return @"iPhone 5S";
    if ([deviceName isEqualToString:@"iPhone7,2"])  return @"iPhone 6";
    if ([deviceName isEqualToString:@"iPhone7,1"])  return @"iPhone 6 Plus";
    if ([deviceName isEqualToString:@"iPhone8,1"])  return @"iPhone 6S";
    if ([deviceName isEqualToString:@"iPhone8,2"])  return @"iPhone 6S Plus";
    if ([deviceName isEqualToString:@"iPhone8,4"])  return @"iPhone SE";
    if ([deviceName isEqualToString:@"iPhone9,1"])  return @"iPhone 7";
    if ([deviceName isEqualToString:@"iPhone9,3"])  return @"iPhone 7";
    if ([deviceName isEqualToString:@"iPhone9,2"])  return @"iPhone 7 Plus";
    if ([deviceName isEqualToString:@"iPhone9,4"])  return @"iPhone 7 Plus";
    if ([deviceName isEqualToString:@"iPhone10,1"]) return @"iPhone 8";
    if ([deviceName isEqualToString:@"iPhone10,4"]) return @"iPhone 8";
    if ([deviceName isEqualToString:@"iPhone10,2"]) return @"iPhone 8 Plus";
    if ([deviceName isEqualToString:@"iPhone10,5"]) return @"iPhone 8 Plus";
    if ([deviceName isEqualToString:@"iPhone10,3"]) return @"iPhone X";
    if ([deviceName isEqualToString:@"iPhone10,6"]) return @"iPhone X";
    if ([deviceName isEqualToString:@"iPhone11,8"]) return @"iPhone XR";
    if ([deviceName isEqualToString:@"iPhone11,2"]) return @"iPhone XS";
    if ([deviceName isEqualToString:@"iPhone11,6"]) return @"iPhone XS Max";
    if ([deviceName isEqualToString:@"iPhone11,4"]) return @"iPhone XS Max";
    if ([deviceName isEqualToString:@"iPhone12,1"]) return @"iPhone 11";
    if ([deviceName isEqualToString:@"iPhone12,3"]) return @"iPhone 11 Pro";
    if ([deviceName isEqualToString:@"iPhone12,5"]) return @"iPhone 11 Pro Max";
    if ([deviceName isEqualToString:@"iPhone12,8"]) return @"iPhone SE 2";
    if ([deviceName isEqualToString:@"iPhone13,1"]) return @"iPhone 12 mini";
    if ([deviceName isEqualToString:@"iPhone13,2"]) return @"iPhone 12";
    if ([deviceName isEqualToString:@"iPhone13,3"]) return @"iPhone 12 Pro";
    if ([deviceName isEqualToString:@"iPhone13,4"]) return @"iPhone 12 Pro Max";
    
    if ([deviceName isEqualToString:@"iPad1,1"])  return @"iPad";
    if ([deviceName isEqualToString:@"iPad2,1"])  return @"iPad 2";
    if ([deviceName isEqualToString:@"iPad2,2"])  return @"iPad 2";
    if ([deviceName isEqualToString:@"iPad2,3"])  return @"iPad 2";
    if ([deviceName isEqualToString:@"iPad2,4"])  return @"iPad 2";
    if ([deviceName isEqualToString:@"iPad3,1"])  return @"iPad 3";
    if ([deviceName isEqualToString:@"iPad3,2"])  return @"iPad 3";
    if ([deviceName isEqualToString:@"iPad3,3"])  return @"iPad 3";
    if ([deviceName isEqualToString:@"iPad3,4"])  return @"iPad 4";
    if ([deviceName isEqualToString:@"iPad3,5"])  return @"iPad 4";
    if ([deviceName isEqualToString:@"iPad3,6"])  return @"iPad 4";
    if ([deviceName isEqualToString:@"iPad6,11"]) return @"iPad 5";
    if ([deviceName isEqualToString:@"iPad6,12"]) return @"iPad 5";
    if ([deviceName isEqualToString:@"iPad7,5"])  return @"iPad 6";
    if ([deviceName isEqualToString:@"iPad7,6"])  return @"iPad 6";
    if ([deviceName isEqualToString:@"iPad7,11"]) return @"iPad 7";
    if ([deviceName isEqualToString:@"iPad7,12"]) return @"iPad 7";
    if ([deviceName isEqualToString:@"iPad11,6"]) return @"iPad 8";
    if ([deviceName isEqualToString:@"iPad11,7"]) return @"iPad 8";
    
    if ([deviceName isEqualToString:@"iPad4,1"])  return @"iPad Air";
    if ([deviceName isEqualToString:@"iPad4,2"])  return @"iPad Air";
    if ([deviceName isEqualToString:@"iPad4,3"])  return @"iPad Air";
    if ([deviceName isEqualToString:@"iPad5,3"])  return @"iPad Air 2";
    if ([deviceName isEqualToString:@"iPad5,4"])  return @"iPad Air 2";
    if ([deviceName isEqualToString:@"iPad11,3"]) return @"iPad Air 3";
    if ([deviceName isEqualToString:@"iPad11,4"]) return @"iPad Air 3";
    if ([deviceName isEqualToString:@"iPad13,1"]) return @"iPad Air 4";
    if ([deviceName isEqualToString:@"iPad13,2"]) return @"iPad Air 4";
    
    if ([deviceName isEqualToString:@"iPad6,7"])  return @"iPad Pro 12.9";
    if ([deviceName isEqualToString:@"iPad6,8"])  return @"iPad Pro 12.9";
    if ([deviceName isEqualToString:@"iPad6,3"])  return @"iPad Pro 9.7";
    if ([deviceName isEqualToString:@"iPad6,4"])  return @"iPad Pro 9.7";
    if ([deviceName isEqualToString:@"iPad7,1"])  return @"iPad Pro 2 12.9";
    if ([deviceName isEqualToString:@"iPad7,2"])  return @"iPad Pro 2 12.9";
    if ([deviceName isEqualToString:@"iPad7,3"])  return @"iPad Pro 10.5";
    if ([deviceName isEqualToString:@"iPad7,4"])  return @"iPad Pro 10.5";
    if ([deviceName isEqualToString:@"iPad8,1"])  return @"iPad Pro 11";
    if ([deviceName isEqualToString:@"iPad8,2"])  return @"iPad Pro 11";
    if ([deviceName isEqualToString:@"iPad8,3"])  return @"iPad Pro 11";
    if ([deviceName isEqualToString:@"iPad8,4"])  return @"iPad Pro 11";
    if ([deviceName isEqualToString:@"iPad8,5"])  return @"iPad Pro 3 12.9";
    if ([deviceName isEqualToString:@"iPad8,6"])  return @"iPad Pro 3 12.9";
    if ([deviceName isEqualToString:@"iPad8,7"])  return @"iPad Pro 3 12.9";
    if ([deviceName isEqualToString:@"iPad8,8"])  return @"iPad Pro 3 12.9";
    if ([deviceName isEqualToString:@"iPad8,9"])  return @"iPad Pro 2 11";
    if ([deviceName isEqualToString:@"iPad8,10"]) return @"iPad Pro 2 11";
    if ([deviceName isEqualToString:@"iPad8,11"]) return @"iPad Pro 4 12.9";
    if ([deviceName isEqualToString:@"iPad8,12"]) return @"iPad Pro 4 12.9";
    
    if ([deviceName isEqualToString:@"iPad2,5"])  return @"iPad Mini";
    if ([deviceName isEqualToString:@"iPad2,6"])  return @"iPad Mini";
    if ([deviceName isEqualToString:@"iPad2,7"])  return @"iPad Mini";
    if ([deviceName isEqualToString:@"iPad4,4"])  return @"iPad Mini 2";
    if ([deviceName isEqualToString:@"iPad4,5"])  return @"iPad Mini 2";
    if ([deviceName isEqualToString:@"iPad4,6"])  return @"iPad Mini 2";
    if ([deviceName isEqualToString:@"iPad4,7"])  return @"iPad Mini 3";
    if ([deviceName isEqualToString:@"iPad4,8"])  return @"iPad Mini 3";
    if ([deviceName isEqualToString:@"iPad4,9"])  return @"iPad Mini 3";
    if ([deviceName isEqualToString:@"iPad5,1"])  return @"iPad Mini 4";
    if ([deviceName isEqualToString:@"iPad5,2"])  return @"iPad Mini 4";
    if ([deviceName isEqualToString:@"iPad11,1"]) return @"iPad Mini 5";
    if ([deviceName isEqualToString:@"iPad11,2"]) return @"iPad Mini 5";
    
    if ([deviceName isEqualToString:@"iPod1,1"]) return @"iPod Touch";
    if ([deviceName isEqualToString:@"iPod2,1"]) return @"iPod Touch 2";
    if ([deviceName isEqualToString:@"iPod3,1"]) return @"iPod Touch 3";
    if ([deviceName isEqualToString:@"iPod4,1"]) return @"iPod Touch 4";
    if ([deviceName isEqualToString:@"iPod5,1"]) return @"iPod Touch 5";
    if ([deviceName isEqualToString:@"iPod7,1"]) return @"iPod Touch 6";
    if ([deviceName isEqualToString:@"iPod9,1"]) return @"iPod Touch 7";

    if ([deviceName isEqualToString:@"i386"])   return @"Simulator";
    if ([deviceName isEqualToString:@"x86_64"]) return @"Simulator";
    
    if ([deviceName isEqualToString:@"AirPods1,1"]) return @"AirPods";
    if ([deviceName isEqualToString:@"AirPods2,1"]) return @"AirPods 2";
    if ([deviceName isEqualToString:@"iProd8,1"])   return @"AirPods Pro";
    
    if ([deviceName isEqualToString:@"AppleTV2,1"]) return @"Apple TV 2";
    if ([deviceName isEqualToString:@"AppleTV3,1"]) return @"Apple TV 3";
    if ([deviceName isEqualToString:@"AppleTV3,2"]) return @"Apple TV 3";
    if ([deviceName isEqualToString:@"AppleTV5,3"]) return @"Apple TV 4";
    if ([deviceName isEqualToString:@"AppleTV6,2"]) return @"Apple TV 4K";
    
    if ([deviceName isEqualToString:@"Watch1,1"]) return @"Apple Watch";
    if ([deviceName isEqualToString:@"Watch1,2"]) return @"Apple Watch";
    if ([deviceName isEqualToString:@"Watch2,6"]) return @"Apple Watch Series 1";
    if ([deviceName isEqualToString:@"Watch2,7"]) return @"Apple Watch Series 1";
    if ([deviceName isEqualToString:@"Watch2,3"]) return @"Apple Watch Series 2";
    if ([deviceName isEqualToString:@"Watch2,4"]) return @"Apple Watch Series 2";
    if ([deviceName isEqualToString:@"Watch3,1"]) return @"Apple Watch Series 3";
    if ([deviceName isEqualToString:@"Watch3,2"]) return @"Apple Watch Series 3";
    if ([deviceName isEqualToString:@"Watch3,3"]) return @"Apple Watch Series 3";
    if ([deviceName isEqualToString:@"Watch3,4"]) return @"Apple Watch Series 3";
    if ([deviceName isEqualToString:@"Watch4,1"]) return @"Apple Watch Series 4";
    if ([deviceName isEqualToString:@"Watch4,2"]) return @"Apple Watch Series 4";
    if ([deviceName isEqualToString:@"Watch4,3"]) return @"Apple Watch Series 4";
    if ([deviceName isEqualToString:@"Watch4,4"]) return @"Apple Watch Series 4";
    
    return @"Unknown";
}

@end
