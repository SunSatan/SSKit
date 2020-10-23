//
//  SSDeviceLibrary.m
//  SSKit
//
//  Created by SunSatan on 2020/9/23.
//  Copyright © 2020 孙铭健. All rights reserved.
//

#import "SSDeviceLibrary.h"

@implementation SSDeviceLibrary

/** 数据来源于：https://www.theiphonewiki.com/wiki/Models */
/** 数据来源于：https://www.blakespot.com/ios_device_specifications_grid.html */

+ (NSString *)deviceModelWithMachineModelID:(NSString *)modelID
{
    if ([modelID isEqualToString:@"iPhone1,1"])  return @"iPhone";
    if ([modelID isEqualToString:@"iPhone1,2"])  return @"iPhone 3G";
    if ([modelID isEqualToString:@"iPhone2,1"])  return @"iPhone 3GS";
    if ([modelID isEqualToString:@"iPhone3,1"])  return @"iPhone 4";
    if ([modelID isEqualToString:@"iPhone3,2"])  return @"iPhone 4";
    if ([modelID isEqualToString:@"iPhone3,3"])  return @"iPhone 4";
    if ([modelID isEqualToString:@"iPhone4,1"])  return @"iPhone 4S";
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

    if ([modelID isEqualToString:@"iPad1,1"])  return @"iPad";
    if ([modelID isEqualToString:@"iPad2,1"])  return @"iPad 2";
    if ([modelID isEqualToString:@"iPad2,2"])  return @"iPad 2";
    if ([modelID isEqualToString:@"iPad2,3"])  return @"iPad 2";
    if ([modelID isEqualToString:@"iPad2,4"])  return @"iPad 2";
    if ([modelID isEqualToString:@"iPad3,1"])  return @"iPad 3";
    if ([modelID isEqualToString:@"iPad3,2"])  return @"iPad 3";
    if ([modelID isEqualToString:@"iPad3,3"])  return @"iPad 3";
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

    if ([modelID isEqualToString:@"iPad6,7"])  return @"iPad Pro 12.9";
    if ([modelID isEqualToString:@"iPad6,8"])  return @"iPad Pro 12.9";
    if ([modelID isEqualToString:@"iPad6,3"])  return @"iPad Pro 9.7";
    if ([modelID isEqualToString:@"iPad6,4"])  return @"iPad Pro 9.7";
    if ([modelID isEqualToString:@"iPad7,1"])  return @"iPad Pro 2 12.9";
    if ([modelID isEqualToString:@"iPad7,2"])  return @"iPad Pro 2 12.9";
    if ([modelID isEqualToString:@"iPad7,3"])  return @"iPad Pro 10.5";
    if ([modelID isEqualToString:@"iPad7,4"])  return @"iPad Pro 10.5";
    if ([modelID isEqualToString:@"iPad8,1"])  return @"iPad Pro 11";
    if ([modelID isEqualToString:@"iPad8,2"])  return @"iPad Pro 11";
    if ([modelID isEqualToString:@"iPad8,3"])  return @"iPad Pro 11";
    if ([modelID isEqualToString:@"iPad8,4"])  return @"iPad Pro 11";
    if ([modelID isEqualToString:@"iPad8,5"])  return @"iPad Pro 3 12.9";
    if ([modelID isEqualToString:@"iPad8,6"])  return @"iPad Pro 3 12.9";
    if ([modelID isEqualToString:@"iPad8,7"])  return @"iPad Pro 3 12.9";
    if ([modelID isEqualToString:@"iPad8,8"])  return @"iPad Pro 3 12.9";
    if ([modelID isEqualToString:@"iPad8,9"])  return @"iPad Pro 2 11";
    if ([modelID isEqualToString:@"iPad8,10"]) return @"iPad Pro 2 11";
    if ([modelID isEqualToString:@"iPad8,11"]) return @"iPad Pro 4 12.9";
    if ([modelID isEqualToString:@"iPad8,12"]) return @"iPad Pro 4 12.9";

    if ([modelID isEqualToString:@"iPad2,5"])  return @"iPad Mini";
    if ([modelID isEqualToString:@"iPad2,6"])  return @"iPad Mini";
    if ([modelID isEqualToString:@"iPad2,7"])  return @"iPad Mini";
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

    if ([modelID isEqualToString:@"iPod1,1"]) return @"iPod Touch";
    if ([modelID isEqualToString:@"iPod2,1"]) return @"iPod Touch 2";
    if ([modelID isEqualToString:@"iPod3,1"]) return @"iPod Touch 3";
    if ([modelID isEqualToString:@"iPod4,1"]) return @"iPod Touch 4";
    if ([modelID isEqualToString:@"iPod5,1"]) return @"iPod Touch 5";
    if ([modelID isEqualToString:@"iPod7,1"]) return @"iPod Touch 6";
    if ([modelID isEqualToString:@"iPod9,1"]) return @"iPod Touch 7";

    if ([modelID isEqualToString:@"i386"])   return @"Simulator";
    if ([modelID isEqualToString:@"x86_64"]) return @"Simulator";

    return @"未知";
}

+ (NSString *)saleTimeWithDevice:(NSString *)deviceModel
{
    if ([deviceModel isEqualToString:@"iPhone 12 Pro Max"]) return @"2020";
    if ([deviceModel isEqualToString:@"iPhone 12 Pro"])     return @"2020";
    if ([deviceModel isEqualToString:@"iPhone 12"])         return @"2020";
    if ([deviceModel isEqualToString:@"iPhone 12 mini"])    return @"2020";
    if ([deviceModel isEqualToString:@"iPhone SE 2"])       return @"2020";
    if ([deviceModel isEqualToString:@"iPhone 11 Pro Max"]) return @"2019";
    if ([deviceModel isEqualToString:@"iPhone 11 Pro"])     return @"2019";
    if ([deviceModel isEqualToString:@"iPhone 11"])         return @"2019";
    if ([deviceModel isEqualToString:@"iPhone XS Max"])     return @"2018";
    if ([deviceModel isEqualToString:@"iPhone XS"])         return @"2018";
    if ([deviceModel isEqualToString:@"iPhone XR"])         return @"2018";
    if ([deviceModel isEqualToString:@"iPhone X"])          return @"2017";
    if ([deviceModel isEqualToString:@"iPhone 8 Plus"])     return @"2017";
    if ([deviceModel isEqualToString:@"iPhone 8"])          return @"2017";
    if ([deviceModel isEqualToString:@"iPhone 7 Plus"])     return @"2016";
    if ([deviceModel isEqualToString:@"iPhone 7"])          return @"2016";
    if ([deviceModel isEqualToString:@"iPhone SE"])         return @"2016";
    if ([deviceModel isEqualToString:@"iPhone 6S Plus"])    return @"2015";
    if ([deviceModel isEqualToString:@"iPhone 6S"])         return @"2015";
    if ([deviceModel isEqualToString:@"iPhone 6 Plus"])     return @"2014";
    if ([deviceModel isEqualToString:@"iPhone 6"])          return @"2014";
    if ([deviceModel isEqualToString:@"iPhone 5S"])         return @"2013";
    if ([deviceModel isEqualToString:@"iPhone 5C"])         return @"2013";
    if ([deviceModel isEqualToString:@"iPhone 5"])          return @"2012";
    if ([deviceModel isEqualToString:@"iPhone 4S"])         return @"2011";
    if ([deviceModel isEqualToString:@"iPhone 4"])          return @"2010";
    if ([deviceModel isEqualToString:@"iPhone 3GS"])        return @"2009";
    if ([deviceModel isEqualToString:@"iPhone 3G"])         return @"2008";
    if ([deviceModel isEqualToString:@"iPhone"])            return @"2007";
    
    if ([deviceModel isEqualToString:@"iPad 8"]) return @"2020";
    if ([deviceModel isEqualToString:@"iPad 7"]) return @"2019";
    if ([deviceModel isEqualToString:@"iPad 6"]) return @"2018";
    if ([deviceModel isEqualToString:@"iPad 5"]) return @"2017";
    if ([deviceModel isEqualToString:@"iPad 4"]) return @"2012";
    if ([deviceModel isEqualToString:@"iPad 3"]) return @"2012";
    if ([deviceModel isEqualToString:@"iPad 2"]) return @"2011";
    if ([deviceModel isEqualToString:@"iPad"])   return @"2010";
    
    if ([deviceModel isEqualToString:@"iPad Air 4"]) return @"2020";
    if ([deviceModel isEqualToString:@"iPad Air 3"]) return @"2019";
    if ([deviceModel isEqualToString:@"iPad Air 2"]) return @"2014";
    if ([deviceModel isEqualToString:@"iPad Air"])   return @"2013";
    
    if ([deviceModel isEqualToString:@"iPad Pro 4 12.9"]) return @"2020";
    if ([deviceModel isEqualToString:@"iPad Pro 2 11"])   return @"2020";
    if ([deviceModel isEqualToString:@"iPad Pro 3 12.9"]) return @"2018";
    if ([deviceModel isEqualToString:@"iPad Pro 11"])     return @"2018";
    if ([deviceModel isEqualToString:@"iPad Pro 10.5"])   return @"2017";
    if ([deviceModel isEqualToString:@"iPad Pro 2 12.9"]) return @"2017";
    if ([deviceModel isEqualToString:@"iPad Pro 9.7"])    return @"2016";
    if ([deviceModel isEqualToString:@"iPad Pro 12.9"])   return @"2015";
    
    if ([deviceModel isEqualToString:@"iPad Mini 5"]) return @"2019";
    if ([deviceModel isEqualToString:@"iPad Mini 4"]) return @"2015";
    if ([deviceModel isEqualToString:@"iPad Mini 3"]) return @"2014";
    if ([deviceModel isEqualToString:@"iPad Mini 2"]) return @"2013";
    if ([deviceModel isEqualToString:@"iPad Mini"])   return @"2012";
    
    
    if ([deviceModel isEqualToString:@"iPod Touch 7"]) return @"2019";
    if ([deviceModel isEqualToString:@"iPod Touch 6"]) return @"2015";
    if ([deviceModel isEqualToString:@"iPod Touch 5"]) return @"2012";
    if ([deviceModel isEqualToString:@"iPod Touch 4"]) return @"2010";
    if ([deviceModel isEqualToString:@"iPod Touch 3"]) return @"2009";
    if ([deviceModel isEqualToString:@"iPod Touch 2"]) return @"2008";
    if ([deviceModel isEqualToString:@"iPod Touch"])   return @"2007";

    return @"未知" ;
}

+ (NSString *)SoCNameWithDevice:(NSString *)deviceModel
{
    if ([deviceModel isEqualToString:@"iPhone 12 Pro Max"]) return @"Apple A14 Bionic";
    if ([deviceModel isEqualToString:@"iPhone 12 Pro"])     return @"Apple A14 Bionic";
    if ([deviceModel isEqualToString:@"iPhone 12"])         return @"Apple A14 Bionic";
    if ([deviceModel isEqualToString:@"iPhone 12 mini"])    return @"Apple A14 Bionic";
    if ([deviceModel isEqualToString:@"iPhone SE 2"])       return @"Apple A13 Bionic";
    if ([deviceModel isEqualToString:@"iPhone 11 Pro Max"]) return @"Apple A13 Bionic";
    if ([deviceModel isEqualToString:@"iPhone 11 Pro"])     return @"Apple A13 Bionic";
    if ([deviceModel isEqualToString:@"iPhone 11"])         return @"Apple A13 Bionic";
    if ([deviceModel isEqualToString:@"iPhone XS Max"])     return @"Apple A12 Bionic";
    if ([deviceModel isEqualToString:@"iPhone XS"])         return @"Apple A12 Bionic";
    if ([deviceModel isEqualToString:@"iPhone XR"])         return @"Apple A12 Bionic";
    if ([deviceModel isEqualToString:@"iPhone X"])          return @"Apple A11 Bionic";
    if ([deviceModel isEqualToString:@"iPhone 8 Plus"])     return @"Apple A11 Bionic";
    if ([deviceModel isEqualToString:@"iPhone 8"])          return @"Apple A11 Bionic";
    if ([deviceModel isEqualToString:@"iPhone 7 Plus"])     return @"Apple A10 Fusion";
    if ([deviceModel isEqualToString:@"iPhone 7"])          return @"Apple A10 Fusion";
    if ([deviceModel isEqualToString:@"iPhone SE"])         return @"Apple A9";
    if ([deviceModel isEqualToString:@"iPhone 6S Plus"])    return @"Apple A9";
    if ([deviceModel isEqualToString:@"iPhone 6S"])         return @"Apple A9";
    if ([deviceModel isEqualToString:@"iPhone 6 Plus"])     return @"Apple A8";
    if ([deviceModel isEqualToString:@"iPhone 6"])          return @"Apple A8";
    if ([deviceModel isEqualToString:@"iPhone 5S"])         return @"Apple A7";
    if ([deviceModel isEqualToString:@"iPhone 5C"])         return @"Apple A6";
    if ([deviceModel isEqualToString:@"iPhone 5"])          return @"Apple A6";
    if ([deviceModel isEqualToString:@"iPhone 4S"])         return @"Apple A5";
    if ([deviceModel isEqualToString:@"iPhone 4"])          return @"Apple A4";
    if ([deviceModel isEqualToString:@"iPhone 3GS"])        return @"Samsung S5PC100";
    if ([deviceModel isEqualToString:@"iPhone 3G"])         return @"Samsung S5L8900";
    if ([deviceModel isEqualToString:@"iPhone"])            return @"Samsung S5L8900";
    
    if ([deviceModel isEqualToString:@"iPad 8"]) return @"2020";
    if ([deviceModel isEqualToString:@"iPad 7"]) return @"2019";
    if ([deviceModel isEqualToString:@"iPad 6"]) return @"2018";
    if ([deviceModel isEqualToString:@"iPad 5"]) return @"2017";
    if ([deviceModel isEqualToString:@"iPad 4"]) return @"2012";
    if ([deviceModel isEqualToString:@"iPad 3"]) return @"2012";
    if ([deviceModel isEqualToString:@"iPad 2"]) return @"2011";
    if ([deviceModel isEqualToString:@"iPad"])   return @"2010";
    
    if ([deviceModel isEqualToString:@"iPad Air 4"]) return @"2020";
    if ([deviceModel isEqualToString:@"iPad Air 3"]) return @"2019";
    if ([deviceModel isEqualToString:@"iPad Air 2"]) return @"2014";
    if ([deviceModel isEqualToString:@"iPad Air"])   return @"2013";
    
    if ([deviceModel isEqualToString:@"iPad Pro 4 12.9"]) return @"2020";
    if ([deviceModel isEqualToString:@"iPad Pro 2 11"])   return @"2020";
    if ([deviceModel isEqualToString:@"iPad Pro 3 12.9"]) return @"2018";
    if ([deviceModel isEqualToString:@"iPad Pro 11"])     return @"2018";
    if ([deviceModel isEqualToString:@"iPad Pro 10.5"])   return @"2017";
    if ([deviceModel isEqualToString:@"iPad Pro 2 12.9"]) return @"2017";
    if ([deviceModel isEqualToString:@"iPad Pro 9.7"])    return @"2016";
    if ([deviceModel isEqualToString:@"iPad Pro 12.9"])   return @"2015";
    
    if ([deviceModel isEqualToString:@"iPad Mini 5"]) return @"2019";
    if ([deviceModel isEqualToString:@"iPad Mini 4"]) return @"2015";
    if ([deviceModel isEqualToString:@"iPad Mini 3"]) return @"2014";
    if ([deviceModel isEqualToString:@"iPad Mini 2"]) return @"2013";
    if ([deviceModel isEqualToString:@"iPad Mini"])   return @"2012";
    
    
    if ([deviceModel isEqualToString:@"iPod Touch 7"]) return @"Apple A10 Fusion";
    if ([deviceModel isEqualToString:@"iPod Touch 6"]) return @"Apple A8";
    if ([deviceModel isEqualToString:@"iPod Touch 5"]) return @"Apple A5";
    if ([deviceModel isEqualToString:@"iPod Touch 4"]) return @"Apple A4";
    if ([deviceModel isEqualToString:@"iPod Touch 3"]) return @"Samsung S5PC100";
    if ([deviceModel isEqualToString:@"iPod Touch 2"]) return @"Samsung S5L8720";
    if ([deviceModel isEqualToString:@"iPod Touch"])   return @"Samsung S5L8900";

    if ([modelID isEqualToString:@"iPad1,1"])  return @"Apple A4";
    if ([modelID isEqualToString:@"iPad2,1"])  return @"Apple A5";
    if ([modelID isEqualToString:@"iPad2,2"])  return @"Apple A5";
    if ([modelID isEqualToString:@"iPad2,3"])  return @"Apple A5";
    if ([modelID isEqualToString:@"iPad2,4"])  return @"Apple A5";
    if ([modelID isEqualToString:@"iPad3,1"])  return @"Apple A5X";
    if ([modelID isEqualToString:@"iPad3,2"])  return @"Apple A5X";
    if ([modelID isEqualToString:@"iPad3,3"])  return @"Apple A5X";
    if ([modelID isEqualToString:@"iPad3,4"])  return @"Apple A6X";
    if ([modelID isEqualToString:@"iPad3,5"])  return @"Apple A6X";
    if ([modelID isEqualToString:@"iPad3,6"])  return @"Apple A6X";
    if ([modelID isEqualToString:@"iPad6,11"]) return @"Apple A9";
    if ([modelID isEqualToString:@"iPad6,12"]) return @"Apple A9";
    if ([modelID isEqualToString:@"iPad7,5"])  return @"Apple A10 Fusion";
    if ([modelID isEqualToString:@"iPad7,6"])  return @"Apple A10 Fusion";
    if ([modelID isEqualToString:@"iPad7,11"]) return @"Apple A10 Fusion";
    if ([modelID isEqualToString:@"iPad7,12"]) return @"Apple A10 Fusion";
    if ([modelID isEqualToString:@"iPad11,6"]) return @"Apple A12 Bionic";
    if ([modelID isEqualToString:@"iPad11,7"]) return @"Apple A12 Bionic";

    if ([modelID isEqualToString:@"iPad4,1"])  return @"Apple A7";
    if ([modelID isEqualToString:@"iPad4,2"])  return @"Apple A7";
    if ([modelID isEqualToString:@"iPad4,3"])  return @"Apple A7";
    if ([modelID isEqualToString:@"iPad5,3"])  return @"Apple A8X";
    if ([modelID isEqualToString:@"iPad5,4"])  return @"Apple A8X";
    if ([modelID isEqualToString:@"iPad11,3"]) return @"Apple A12 Bionic";
    if ([modelID isEqualToString:@"iPad11,4"]) return @"Apple A12 Bionic";
    if ([modelID isEqualToString:@"iPad13,1"]) return @"Apple A14 Bionic";
    if ([modelID isEqualToString:@"iPad13,2"]) return @"Apple A14 Bionic";

    if ([modelID isEqualToString:@"iPad6,7"])  return @"Apple A9X";
    if ([modelID isEqualToString:@"iPad6,8"])  return @"Apple A9X";
    if ([modelID isEqualToString:@"iPad6,3"])  return @"Apple A9X";
    if ([modelID isEqualToString:@"iPad6,4"])  return @"Apple A9X";
    if ([modelID isEqualToString:@"iPad7,1"])  return @"Apple A10X Fusion";
    if ([modelID isEqualToString:@"iPad7,2"])  return @"Apple A10X Fusion";
    if ([modelID isEqualToString:@"iPad7,3"])  return @"Apple A10X Fusion";
    if ([modelID isEqualToString:@"iPad7,4"])  return @"Apple A10X Fusion";
    if ([modelID isEqualToString:@"iPad8,1"])  return @"Apple A12X Bionic";
    if ([modelID isEqualToString:@"iPad8,2"])  return @"Apple A12X Bionic";
    if ([modelID isEqualToString:@"iPad8,3"])  return @"Apple A12X Bionic";
    if ([modelID isEqualToString:@"iPad8,4"])  return @"Apple A12X Bionic";
    if ([modelID isEqualToString:@"iPad8,5"])  return @"Apple A12X Bionic";
    if ([modelID isEqualToString:@"iPad8,6"])  return @"Apple A12X Bionic";
    if ([modelID isEqualToString:@"iPad8,7"])  return @"Apple A12X Bionic";
    if ([modelID isEqualToString:@"iPad8,8"])  return @"Apple A12X Bionic";
    if ([modelID isEqualToString:@"iPad8,9"])  return @"Apple A12Z";
    if ([modelID isEqualToString:@"iPad8,10"]) return @"Apple A12Z";
    if ([modelID isEqualToString:@"iPad8,11"]) return @"Apple A12Z";
    if ([modelID isEqualToString:@"iPad8,12"]) return @"Apple A12Z";

    if ([modelID isEqualToString:@"iPad2,5"])  return @"Apple A5";
    if ([modelID isEqualToString:@"iPad2,6"])  return @"Apple A5";
    if ([modelID isEqualToString:@"iPad2,7"])  return @"Apple A5";
    if ([modelID isEqualToString:@"iPad4,4"])  return @"Apple A7";
    if ([modelID isEqualToString:@"iPad4,5"])  return @"Apple A7";
    if ([modelID isEqualToString:@"iPad4,6"])  return @"Apple A7";
    if ([modelID isEqualToString:@"iPad4,7"])  return @"Apple A7";
    if ([modelID isEqualToString:@"iPad4,8"])  return @"Apple A7";
    if ([modelID isEqualToString:@"iPad4,9"])  return @"Apple A7";
    if ([modelID isEqualToString:@"iPad5,1"])  return @"Apple A8";
    if ([modelID isEqualToString:@"iPad5,2"])  return @"Apple A8";
    if ([modelID isEqualToString:@"iPad11,1"]) return @"Apple A12 Bionic";
    if ([modelID isEqualToString:@"iPad11,2"]) return @"Apple A12 Bionic";

    if ([modelID isEqualToString:@"iPod1,1"]) return @"Samsung S5L8900";
    if ([modelID isEqualToString:@"iPod2,1"]) return @"Samsung S5L8720";
    if ([modelID isEqualToString:@"iPod3,1"]) return @"Samsung S5PC100";
    if ([modelID isEqualToString:@"iPod4,1"]) return @"Apple A4";
    if ([modelID isEqualToString:@"iPod5,1"]) return @"Apple A5";
    if ([modelID isEqualToString:@"iPod7,1"]) return @"Apple A8";
    if ([modelID isEqualToString:@"iPod9,1"]) return @"Apple A10 Fusion";

    return @"未知" ;
}

+ (NSString *)deviceMemType:(NSString *)modelID
{
    if ([modelID isEqualToString:@"iPhone1,1"])  return @"LPDDR";
    if ([modelID isEqualToString:@"iPhone1,2"])  return @"LPDDR";
    if ([modelID isEqualToString:@"iPhone2,1"])  return @"LPDDR";
    if ([modelID isEqualToString:@"iPhone3,1"])  return @"LPDDR";
    if ([modelID isEqualToString:@"iPhone3,2"])  return @"LPDDR";
    if ([modelID isEqualToString:@"iPhone3,3"])  return @"LPDDR";
    if ([modelID isEqualToString:@"iPhone4,1"])  return @"LPDDR2";
    if ([modelID isEqualToString:@"iPhone5,1"])  return @"LPDDR2";
    if ([modelID isEqualToString:@"iPhone5,2"])  return @"LPDDR2";
    if ([modelID isEqualToString:@"iPhone5,3"])  return @"LPDDR2";
    if ([modelID isEqualToString:@"iPhone5,4"])  return @"LPDDR2";
    if ([modelID isEqualToString:@"iPhone6,1"])  return @"LPDDR3";
    if ([modelID isEqualToString:@"iPhone6,2"])  return @"LPDDR3";
    if ([modelID isEqualToString:@"iPhone7,2"])  return @"LPDDR3";
    if ([modelID isEqualToString:@"iPhone7,1"])  return @"LPDDR3";
    if ([modelID isEqualToString:@"iPhone8,1"])  return @"LPDDR4";
    if ([modelID isEqualToString:@"iPhone8,2"])  return @"LPDDR4";
    if ([modelID isEqualToString:@"iPhone8,4"])  return @"LPDDR4";
    if ([modelID isEqualToString:@"iPhone9,1"])  return @"LPDDR4";
    if ([modelID isEqualToString:@"iPhone9,3"])  return @"LPDDR4";
    if ([modelID isEqualToString:@"iPhone9,2"])  return @"LPDDR4";
    if ([modelID isEqualToString:@"iPhone9,4"])  return @"LPDDR4";
    if ([modelID isEqualToString:@"iPhone10,1"]) return @"LPDDR4";
    if ([modelID isEqualToString:@"iPhone10,4"]) return @"LPDDR4";
    if ([modelID isEqualToString:@"iPhone10,2"]) return @"LPDDR4";
    if ([modelID isEqualToString:@"iPhone10,5"]) return @"LPDDR4";
    if ([modelID isEqualToString:@"iPhone10,3"]) return @"LPDDR4";
    if ([modelID isEqualToString:@"iPhone10,6"]) return @"LPDDR4";
    if ([modelID isEqualToString:@"iPhone11,8"]) return @"LPDDR4X";
    if ([modelID isEqualToString:@"iPhone11,2"]) return @"LPDDR4X";
    if ([modelID isEqualToString:@"iPhone11,6"]) return @"LPDDR4X";
    if ([modelID isEqualToString:@"iPhone11,4"]) return @"LPDDR4X";
    if ([modelID isEqualToString:@"iPhone12,1"]) return @"LPDDR4X";
    if ([modelID isEqualToString:@"iPhone12,3"]) return @"LPDDR4X";
    if ([modelID isEqualToString:@"iPhone12,5"]) return @"LPDDR4X";
    if ([modelID isEqualToString:@"iPhone12,8"]) return @"LPDDR4X";
    if ([modelID isEqualToString:@"iPhone13,1"]) return @"LPDDR4X";
    if ([modelID isEqualToString:@"iPhone13,2"]) return @"LPDDR4X";
    if ([modelID isEqualToString:@"iPhone13,3"]) return @"LPDDR4X";
    if ([modelID isEqualToString:@"iPhone13,4"]) return @"LPDDR4X";

    if ([modelID isEqualToString:@"iPad1,1"])  return @"LPDDR";
    if ([modelID isEqualToString:@"iPad2,1"])  return @"LPDDR2";
    if ([modelID isEqualToString:@"iPad2,2"])  return @"LPDDR2";
    if ([modelID isEqualToString:@"iPad2,3"])  return @"LPDDR2";
    if ([modelID isEqualToString:@"iPad2,4"])  return @"LPDDR2";
    if ([modelID isEqualToString:@"iPad3,1"])  return @"LPDDR2";
    if ([modelID isEqualToString:@"iPad3,2"])  return @"LPDDR2";
    if ([modelID isEqualToString:@"iPad3,3"])  return @"LPDDR2";
    if ([modelID isEqualToString:@"iPad3,4"])  return @"LPDDR2";
    if ([modelID isEqualToString:@"iPad3,5"])  return @"LPDDR2";
    if ([modelID isEqualToString:@"iPad3,6"])  return @"LPDDR2";
    if ([modelID isEqualToString:@"iPad6,11"]) return @"LPDDR4";
    if ([modelID isEqualToString:@"iPad6,12"]) return @"LPDDR4";
    if ([modelID isEqualToString:@"iPad7,5"])  return @"LPDDR4";
    if ([modelID isEqualToString:@"iPad7,6"])  return @"LPDDR4";
    if ([modelID isEqualToString:@"iPad7,11"]) return @"LPDDR4X";
    if ([modelID isEqualToString:@"iPad7,12"]) return @"LPDDR4X";
    if ([modelID isEqualToString:@"iPad11,6"]) return @"LPDDR4X";
    if ([modelID isEqualToString:@"iPad11,7"]) return @"LPDDR4X";

    if ([modelID isEqualToString:@"iPad4,1"])  return @"LPDDR3";
    if ([modelID isEqualToString:@"iPad4,2"])  return @"LPDDR3";
    if ([modelID isEqualToString:@"iPad4,3"])  return @"LPDDR3";
    if ([modelID isEqualToString:@"iPad5,3"])  return @"LPDDR3";
    if ([modelID isEqualToString:@"iPad5,4"])  return @"LPDDR3";
    if ([modelID isEqualToString:@"iPad11,3"]) return @"LPDDR4X";
    if ([modelID isEqualToString:@"iPad11,4"]) return @"LPDDR4X";
    if ([modelID isEqualToString:@"iPad13,1"]) return @"LPDDR4X";
    if ([modelID isEqualToString:@"iPad13,2"]) return @"LPDDR4X";

    if ([modelID isEqualToString:@"iPad6,7"])  return @"LPDDR4";
    if ([modelID isEqualToString:@"iPad6,8"])  return @"LPDDR4";
    if ([modelID isEqualToString:@"iPad6,3"])  return @"LPDDR4";
    if ([modelID isEqualToString:@"iPad6,4"])  return @"LPDDR4";
    if ([modelID isEqualToString:@"iPad7,1"])  return @"LPDDR4";
    if ([modelID isEqualToString:@"iPad7,2"])  return @"LPDDR4";
    if ([modelID isEqualToString:@"iPad7,3"])  return @"LPDDR4";
    if ([modelID isEqualToString:@"iPad7,4"])  return @"LPDDR4";
    if ([modelID isEqualToString:@"iPad8,1"])  return @"LPDDR4X";
    if ([modelID isEqualToString:@"iPad8,2"])  return @"LPDDR4X";
    if ([modelID isEqualToString:@"iPad8,3"])  return @"LPDDR4X";
    if ([modelID isEqualToString:@"iPad8,4"])  return @"LPDDR4X";
    if ([modelID isEqualToString:@"iPad8,5"])  return @"LPDDR4X";
    if ([modelID isEqualToString:@"iPad8,6"])  return @"LPDDR4X";
    if ([modelID isEqualToString:@"iPad8,7"])  return @"LPDDR4X";
    if ([modelID isEqualToString:@"iPad8,8"])  return @"LPDDR4X";
    if ([modelID isEqualToString:@"iPad8,9"])  return @"LPDDR4X";
    if ([modelID isEqualToString:@"iPad8,10"]) return @"LPDDR4X";
    if ([modelID isEqualToString:@"iPad8,11"]) return @"LPDDR4X";
    if ([modelID isEqualToString:@"iPad8,12"]) return @"LPDDR4X";

    if ([modelID isEqualToString:@"iPad2,5"])  return @"LPDDR2";
    if ([modelID isEqualToString:@"iPad2,6"])  return @"LPDDR2";
    if ([modelID isEqualToString:@"iPad2,7"])  return @"LPDDR2";
    if ([modelID isEqualToString:@"iPad4,4"])  return @"LPDDR3";
    if ([modelID isEqualToString:@"iPad4,5"])  return @"LPDDR3";
    if ([modelID isEqualToString:@"iPad4,6"])  return @"LPDDR3";
    if ([modelID isEqualToString:@"iPad4,7"])  return @"LPDDR3";
    if ([modelID isEqualToString:@"iPad4,8"])  return @"LPDDR3";
    if ([modelID isEqualToString:@"iPad4,9"])  return @"LPDDR3";
    if ([modelID isEqualToString:@"iPad5,1"])  return @"LPDDR3";
    if ([modelID isEqualToString:@"iPad5,2"])  return @"LPDDR3";
    if ([modelID isEqualToString:@"iPad11,1"]) return @"LPDDR4X";
    if ([modelID isEqualToString:@"iPad11,2"]) return @"LPDDR4X";

    if ([modelID isEqualToString:@"iPod1,1"]) return @"LPDDR";
    if ([modelID isEqualToString:@"iPod2,1"]) return @"LPDDR";
    if ([modelID isEqualToString:@"iPod3,1"]) return @"LPDDR";
    if ([modelID isEqualToString:@"iPod4,1"]) return @"LPDDR";
    if ([modelID isEqualToString:@"iPod5,1"]) return @"LPDDR2";
    if ([modelID isEqualToString:@"iPod7,1"]) return @"LPDDR3";
    if ([modelID isEqualToString:@"iPod9,1"]) return @"LPDDR4";

    return @"未知";
}

+ (NSString *)devicePPI:(NSString *)modelID
{
    if ([modelID isEqualToString:@"iPhone1,1"])  return @"163 ppi";
    if ([modelID isEqualToString:@"iPhone1,2"])  return @"163 ppi";
    if ([modelID isEqualToString:@"iPhone2,1"])  return @"163 ppi";
    if ([modelID isEqualToString:@"iPhone3,1"])  return @"326 ppi";
    if ([modelID isEqualToString:@"iPhone3,2"])  return @"326 ppi";
    if ([modelID isEqualToString:@"iPhone3,3"])  return @"326 ppi";
    if ([modelID isEqualToString:@"iPhone4,1"])  return @"326 ppi";
    if ([modelID isEqualToString:@"iPhone5,1"])  return @"326 ppi";
    if ([modelID isEqualToString:@"iPhone5,2"])  return @"326 ppi";
    if ([modelID isEqualToString:@"iPhone5,3"])  return @"326 ppi";
    if ([modelID isEqualToString:@"iPhone5,4"])  return @"326 ppi";
    if ([modelID isEqualToString:@"iPhone6,1"])  return @"326 ppi";
    if ([modelID isEqualToString:@"iPhone6,2"])  return @"326 ppi";
    if ([modelID isEqualToString:@"iPhone7,2"])  return @"326 ppi";
    if ([modelID isEqualToString:@"iPhone7,1"])  return @"401 ppi";
    if ([modelID isEqualToString:@"iPhone8,1"])  return @"326 ppi";
    if ([modelID isEqualToString:@"iPhone8,2"])  return @"401 ppi";
    if ([modelID isEqualToString:@"iPhone8,4"])  return @"326 ppi";
    if ([modelID isEqualToString:@"iPhone9,1"])  return @"326 ppi";
    if ([modelID isEqualToString:@"iPhone9,3"])  return @"326 ppi";
    if ([modelID isEqualToString:@"iPhone9,2"])  return @"401 ppi";
    if ([modelID isEqualToString:@"iPhone9,4"])  return @"401 ppi";
    if ([modelID isEqualToString:@"iPhone10,1"]) return @"326 ppi";
    if ([modelID isEqualToString:@"iPhone10,4"]) return @"326 ppi";
    if ([modelID isEqualToString:@"iPhone10,2"]) return @"401 ppi";
    if ([modelID isEqualToString:@"iPhone10,5"]) return @"401 ppi";
    if ([modelID isEqualToString:@"iPhone10,3"]) return @"458 ppi";
    if ([modelID isEqualToString:@"iPhone10,6"]) return @"458 ppi";
    if ([modelID isEqualToString:@"iPhone11,8"]) return @"326 ppi";
    if ([modelID isEqualToString:@"iPhone11,2"]) return @"458 ppi";
    if ([modelID isEqualToString:@"iPhone11,6"]) return @"458 ppi";
    if ([modelID isEqualToString:@"iPhone11,4"]) return @"458 ppi";
    if ([modelID isEqualToString:@"iPhone12,1"]) return @"326 ppi";
    if ([modelID isEqualToString:@"iPhone12,3"]) return @"458 ppi";
    if ([modelID isEqualToString:@"iPhone12,5"]) return @"458 ppi";
    if ([modelID isEqualToString:@"iPhone12,8"]) return @"326 ppi";
    if ([modelID isEqualToString:@"iPhone13,1"]) return @"476 ppi";
    if ([modelID isEqualToString:@"iPhone13,2"]) return @"460 ppi";
    if ([modelID isEqualToString:@"iPhone13,3"]) return @"460 ppi";
    if ([modelID isEqualToString:@"iPhone13,4"]) return @"458 ppi";

    if ([modelID isEqualToString:@"iPad1,1"])  return @"132 ppi";
    if ([modelID isEqualToString:@"iPad2,1"])  return @"132 ppi";
    if ([modelID isEqualToString:@"iPad2,2"])  return @"132 ppi";
    if ([modelID isEqualToString:@"iPad2,3"])  return @"132 ppi";
    if ([modelID isEqualToString:@"iPad2,4"])  return @"132 ppi";
    if ([modelID isEqualToString:@"iPad3,1"])  return @"264 ppi";
    if ([modelID isEqualToString:@"iPad3,2"])  return @"264 ppi";
    if ([modelID isEqualToString:@"iPad3,3"])  return @"264 ppi";
    if ([modelID isEqualToString:@"iPad3,4"])  return @"264 ppi";
    if ([modelID isEqualToString:@"iPad3,5"])  return @"264 ppi";
    if ([modelID isEqualToString:@"iPad3,6"])  return @"264 ppi";
    if ([modelID isEqualToString:@"iPad6,11"]) return @"264 ppi";
    if ([modelID isEqualToString:@"iPad6,12"]) return @"264 ppi";
    if ([modelID isEqualToString:@"iPad7,5"])  return @"264 ppi";
    if ([modelID isEqualToString:@"iPad7,6"])  return @"264 ppi";
    if ([modelID isEqualToString:@"iPad7,11"]) return @"264 ppi";
    if ([modelID isEqualToString:@"iPad7,12"]) return @"264 ppi";
    if ([modelID isEqualToString:@"iPad11,6"]) return @"264 ppi";
    if ([modelID isEqualToString:@"iPad11,7"]) return @"264 ppi";

    if ([modelID isEqualToString:@"iPad4,1"])  return @"264 ppi";
    if ([modelID isEqualToString:@"iPad4,2"])  return @"264 ppi";
    if ([modelID isEqualToString:@"iPad4,3"])  return @"264 ppi";
    if ([modelID isEqualToString:@"iPad5,3"])  return @"264 ppi";
    if ([modelID isEqualToString:@"iPad5,4"])  return @"264 ppi";
    if ([modelID isEqualToString:@"iPad11,3"]) return @"264 ppi";
    if ([modelID isEqualToString:@"iPad11,4"]) return @"264 ppi";
    if ([modelID isEqualToString:@"iPad13,1"]) return @"264 ppi";
    if ([modelID isEqualToString:@"iPad13,2"]) return @"264 ppi";

    if ([modelID isEqualToString:@"iPad6,7"])  return @"264 ppi";
    if ([modelID isEqualToString:@"iPad6,8"])  return @"264 ppi";
    if ([modelID isEqualToString:@"iPad6,3"])  return @"264 ppi";
    if ([modelID isEqualToString:@"iPad6,4"])  return @"264 ppi";
    if ([modelID isEqualToString:@"iPad7,1"])  return @"264 ppi";
    if ([modelID isEqualToString:@"iPad7,2"])  return @"264 ppi";
    if ([modelID isEqualToString:@"iPad7,3"])  return @"264 ppi";
    if ([modelID isEqualToString:@"iPad7,4"])  return @"264 ppi";
    if ([modelID isEqualToString:@"iPad8,1"])  return @"264 ppi";
    if ([modelID isEqualToString:@"iPad8,2"])  return @"264 ppi";
    if ([modelID isEqualToString:@"iPad8,3"])  return @"264 ppi";
    if ([modelID isEqualToString:@"iPad8,4"])  return @"264 ppi";
    if ([modelID isEqualToString:@"iPad8,5"])  return @"264 ppi";
    if ([modelID isEqualToString:@"iPad8,6"])  return @"264 ppi";
    if ([modelID isEqualToString:@"iPad8,7"])  return @"264 ppi";
    if ([modelID isEqualToString:@"iPad8,8"])  return @"264 ppi";
    if ([modelID isEqualToString:@"iPad8,9"])  return @"264 ppi";
    if ([modelID isEqualToString:@"iPad8,10"]) return @"264 ppi";
    if ([modelID isEqualToString:@"iPad8,11"]) return @"264 ppi";
    if ([modelID isEqualToString:@"iPad8,12"]) return @"264 ppi";

    if ([modelID isEqualToString:@"iPad2,5"])  return @"163 ppi";
    if ([modelID isEqualToString:@"iPad2,6"])  return @"163 ppi";
    if ([modelID isEqualToString:@"iPad2,7"])  return @"163 ppi";
    if ([modelID isEqualToString:@"iPad4,4"])  return @"326 ppi";
    if ([modelID isEqualToString:@"iPad4,5"])  return @"326 ppi";
    if ([modelID isEqualToString:@"iPad4,6"])  return @"326 ppi";
    if ([modelID isEqualToString:@"iPad4,7"])  return @"326 ppi";
    if ([modelID isEqualToString:@"iPad4,8"])  return @"326 ppi";
    if ([modelID isEqualToString:@"iPad4,9"])  return @"326 ppi";
    if ([modelID isEqualToString:@"iPad5,1"])  return @"264 ppi";
    if ([modelID isEqualToString:@"iPad5,2"])  return @"264 ppi";
    if ([modelID isEqualToString:@"iPad11,1"]) return @"264 ppi";
    if ([modelID isEqualToString:@"iPad11,2"]) return @"264 ppi";

    if ([modelID isEqualToString:@"iPod1,1"]) return @"163 ppi";
    if ([modelID isEqualToString:@"iPod2,1"]) return @"163 ppi";
    if ([modelID isEqualToString:@"iPod3,1"]) return @"163 ppi";
    if ([modelID isEqualToString:@"iPod4,1"]) return @"326 ppi";
    if ([modelID isEqualToString:@"iPod5,1"]) return @"326 ppi";
    if ([modelID isEqualToString:@"iPod7,1"]) return @"326 ppi";
    if ([modelID isEqualToString:@"iPod9,1"]) return @"326 ppi";

    return @"未知";
}

+ (NSString *)deviceScreenSize:(NSString *)modelID
{
    if ([modelID isEqualToString:@"iPhone1,1"])  return @"3.5\"";
    if ([modelID isEqualToString:@"iPhone1,2"])  return @"3.5\"";
    if ([modelID isEqualToString:@"iPhone2,1"])  return @"3.5\"";
    if ([modelID isEqualToString:@"iPhone3,1"])  return @"3.5\"";
    if ([modelID isEqualToString:@"iPhone3,2"])  return @"3.5\"";
    if ([modelID isEqualToString:@"iPhone3,3"])  return @"3.5\"";
    if ([modelID isEqualToString:@"iPhone4,1"])  return @"3.5\"";
    if ([modelID isEqualToString:@"iPhone5,1"])  return @"4\"";
    if ([modelID isEqualToString:@"iPhone5,2"])  return @"4\"";
    if ([modelID isEqualToString:@"iPhone5,3"])  return @"4\"";
    if ([modelID isEqualToString:@"iPhone5,4"])  return @"4\"";
    if ([modelID isEqualToString:@"iPhone6,1"])  return @"4\"";
    if ([modelID isEqualToString:@"iPhone6,2"])  return @"4\"";
    if ([modelID isEqualToString:@"iPhone7,2"])  return @"4.7\"";
    if ([modelID isEqualToString:@"iPhone7,1"])  return @"5.5\"";
    if ([modelID isEqualToString:@"iPhone8,1"])  return @"4.7\"";
    if ([modelID isEqualToString:@"iPhone8,2"])  return @"5.5\"";
    if ([modelID isEqualToString:@"iPhone8,4"])  return @"4\"";
    if ([modelID isEqualToString:@"iPhone9,1"])  return @"4.7\"";
    if ([modelID isEqualToString:@"iPhone9,3"])  return @"4.7\"";
    if ([modelID isEqualToString:@"iPhone9,2"])  return @"5.5\"";
    if ([modelID isEqualToString:@"iPhone9,4"])  return @"5.5\"";
    if ([modelID isEqualToString:@"iPhone10,1"]) return @"4.7\"";
    if ([modelID isEqualToString:@"iPhone10,4"]) return @"4.7\"";
    if ([modelID isEqualToString:@"iPhone10,2"]) return @"5.5\"";
    if ([modelID isEqualToString:@"iPhone10,5"]) return @"5.5\"";
    if ([modelID isEqualToString:@"iPhone10,3"]) return @"5.8\"";
    if ([modelID isEqualToString:@"iPhone10,6"]) return @"5.8\"";
    if ([modelID isEqualToString:@"iPhone11,8"]) return @"6.1\"";
    if ([modelID isEqualToString:@"iPhone11,2"]) return @"5.8\"";
    if ([modelID isEqualToString:@"iPhone11,6"]) return @"6.5\"";
    if ([modelID isEqualToString:@"iPhone11,4"]) return @"6.5\"";
    if ([modelID isEqualToString:@"iPhone12,1"]) return @"6.1\"";
    if ([modelID isEqualToString:@"iPhone12,3"]) return @"5.8\"";
    if ([modelID isEqualToString:@"iPhone12,5"]) return @"6.5\"";
    if ([modelID isEqualToString:@"iPhone12,8"]) return @"4.7\"";
    if ([modelID isEqualToString:@"iPhone13,1"]) return @"5.4\"";
    if ([modelID isEqualToString:@"iPhone13,2"]) return @"6.1\"";
    if ([modelID isEqualToString:@"iPhone13,3"]) return @"6.1\"";
    if ([modelID isEqualToString:@"iPhone13,4"]) return @"6.7\"";
    
    if ([modelID isEqualToString:@"iPad1,1"])  return @"9.7\"";
    if ([modelID isEqualToString:@"iPad2,1"])  return @"9.7\"";
    if ([modelID isEqualToString:@"iPad2,2"])  return @"9.7\"";
    if ([modelID isEqualToString:@"iPad2,3"])  return @"9.7\"";
    if ([modelID isEqualToString:@"iPad2,4"])  return @"9.7\"";
    if ([modelID isEqualToString:@"iPad3,1"])  return @"9.7\"";
    if ([modelID isEqualToString:@"iPad3,2"])  return @"9.7\"";
    if ([modelID isEqualToString:@"iPad3,3"])  return @"9.7\"";
    if ([modelID isEqualToString:@"iPad3,4"])  return @"9.7\"";
    if ([modelID isEqualToString:@"iPad3,5"])  return @"9.7\"";
    if ([modelID isEqualToString:@"iPad3,6"])  return @"9.7\"";
    if ([modelID isEqualToString:@"iPad6,11"]) return @"9.7\"";
    if ([modelID isEqualToString:@"iPad6,12"]) return @"9.7\"";
    if ([modelID isEqualToString:@"iPad7,5"])  return @"9.7\"";
    if ([modelID isEqualToString:@"iPad7,6"])  return @"9.7\"";
    if ([modelID isEqualToString:@"iPad7,11"]) return @"10.2\"";
    if ([modelID isEqualToString:@"iPad7,12"]) return @"10.2\"";
    if ([modelID isEqualToString:@"iPad11,6"]) return @"10.2\"";
    if ([modelID isEqualToString:@"iPad11,7"]) return @"10.2\"";
    
    if ([modelID isEqualToString:@"iPad4,1"])  return @"9.7\"";
    if ([modelID isEqualToString:@"iPad4,2"])  return @"9.7\"";
    if ([modelID isEqualToString:@"iPad4,3"])  return @"9.7\"";
    if ([modelID isEqualToString:@"iPad5,3"])  return @"9.7\"";
    if ([modelID isEqualToString:@"iPad5,4"])  return @"9.7\"";
    if ([modelID isEqualToString:@"iPad11,3"]) return @"10.5\"";
    if ([modelID isEqualToString:@"iPad11,4"]) return @"10.5\"";
    if ([modelID isEqualToString:@"iPad13,1"]) return @"10.9\"";
    if ([modelID isEqualToString:@"iPad13,2"]) return @"10.9\"";
    
    if ([modelID isEqualToString:@"iPad6,7"])  return @"12.9\"";
    if ([modelID isEqualToString:@"iPad6,8"])  return @"12.9\"";
    if ([modelID isEqualToString:@"iPad6,3"])  return @"9.7\"";
    if ([modelID isEqualToString:@"iPad6,4"])  return @"9.7\"";
    if ([modelID isEqualToString:@"iPad7,1"])  return @"12.9\"";
    if ([modelID isEqualToString:@"iPad7,2"])  return @"12.9\"";
    if ([modelID isEqualToString:@"iPad7,3"])  return @"10.5\"";
    if ([modelID isEqualToString:@"iPad7,4"])  return @"10.5\"";
    if ([modelID isEqualToString:@"iPad8,1"])  return @"11\"";
    if ([modelID isEqualToString:@"iPad8,2"])  return @"11\"";
    if ([modelID isEqualToString:@"iPad8,3"])  return @"11\"";
    if ([modelID isEqualToString:@"iPad8,4"])  return @"11\"";
    if ([modelID isEqualToString:@"iPad8,5"])  return @"12.9\"";
    if ([modelID isEqualToString:@"iPad8,6"])  return @"12.9\"";
    if ([modelID isEqualToString:@"iPad8,7"])  return @"12.9\"";
    if ([modelID isEqualToString:@"iPad8,8"])  return @"12.9\"";
    if ([modelID isEqualToString:@"iPad8,9"])  return @"11\"";
    if ([modelID isEqualToString:@"iPad8,10"]) return @"11\"";
    if ([modelID isEqualToString:@"iPad8,11"]) return @"12.9\"";
    if ([modelID isEqualToString:@"iPad8,12"]) return @"12.9\"";
    
    if ([modelID isEqualToString:@"iPad2,5"])  return @"7.9\"";
    if ([modelID isEqualToString:@"iPad2,6"])  return @"7.9\"";
    if ([modelID isEqualToString:@"iPad2,7"])  return @"7.9\"";
    if ([modelID isEqualToString:@"iPad4,4"])  return @"7.9\"";
    if ([modelID isEqualToString:@"iPad4,5"])  return @"7.9\"";
    if ([modelID isEqualToString:@"iPad4,6"])  return @"7.9\"";
    if ([modelID isEqualToString:@"iPad4,7"])  return @"7.9\"";
    if ([modelID isEqualToString:@"iPad4,8"])  return @"7.9\"";
    if ([modelID isEqualToString:@"iPad4,9"])  return @"7.9\"";
    if ([modelID isEqualToString:@"iPad5,1"])  return @"7.9\"";
    if ([modelID isEqualToString:@"iPad5,2"])  return @"7.9\"";
    if ([modelID isEqualToString:@"iPad11,1"]) return @"7.9\"";
    if ([modelID isEqualToString:@"iPad11,2"]) return @"7.9\"";
    
    if ([modelID isEqualToString:@"iPod1,1"]) return @"3.5\"";
    if ([modelID isEqualToString:@"iPod2,1"]) return @"3.5\"";
    if ([modelID isEqualToString:@"iPod3,1"]) return @"3.5\"";
    if ([modelID isEqualToString:@"iPod4,1"]) return @"3.5\"";
    if ([modelID isEqualToString:@"iPod5,1"]) return @"4\"";
    if ([modelID isEqualToString:@"iPod7,1"]) return @"4.7\"";
    
    return @"未知";
}

+ (NSString *)deviceLatestOSVersion:(NSString *)modelID
{
    if ([modelID isEqualToString:@"iPhone1,1"])  return @"iOS 3.1.3";
    if ([modelID isEqualToString:@"iPhone1,2"])  return @"iOS 4.2.1";
    if ([modelID isEqualToString:@"iPhone2,1"])  return @"iOS 6.1.6";
    if ([modelID isEqualToString:@"iPhone3,1"])  return @"iOS 7.1.2";
    if ([modelID isEqualToString:@"iPhone3,2"])  return @"iOS 7.1.2";
    if ([modelID isEqualToString:@"iPhone3,3"])  return @"iOS 7.1.2";
    if ([modelID isEqualToString:@"iPhone4,1"])  return @"iOS 9.3.3";
    if ([modelID isEqualToString:@"iPhone5,1"])  return @"iOS 10.3.3";
    if ([modelID isEqualToString:@"iPhone5,2"])  return @"iOS 10.3.3";
    if ([modelID isEqualToString:@"iPhone5,3"])  return @"iOS 10.3.3";
    if ([modelID isEqualToString:@"iPhone5,4"])  return @"iOS 10.3.3";
    if ([modelID isEqualToString:@"iPhone6,1"])  return @"iOS 12.2";
    if ([modelID isEqualToString:@"iPhone6,2"])  return @"iOS 12.2";
    if ([modelID isEqualToString:@"iPhone7,2"])  return @"iOS 12.2";
    if ([modelID isEqualToString:@"iPhone7,1"])  return @"iOS 12.2";
    if ([modelID isEqualToString:@"iPhone8,1"])  return @"现今最新";
    if ([modelID isEqualToString:@"iPhone8,2"])  return @"现今最新";
    if ([modelID isEqualToString:@"iPhone8,4"])  return @"现今最新";
    if ([modelID isEqualToString:@"iPhone9,1"])  return @"现今最新";
    if ([modelID isEqualToString:@"iPhone9,3"])  return @"现今最新";
    if ([modelID isEqualToString:@"iPhone9,2"])  return @"现今最新";
    if ([modelID isEqualToString:@"iPhone9,4"])  return @"现今最新";
    if ([modelID isEqualToString:@"iPhone10,1"]) return @"现今最新";
    if ([modelID isEqualToString:@"iPhone10,4"]) return @"现今最新";
    if ([modelID isEqualToString:@"iPhone10,2"]) return @"现今最新";
    if ([modelID isEqualToString:@"iPhone10,5"]) return @"现今最新";
    if ([modelID isEqualToString:@"iPhone10,3"]) return @"现今最新";
    if ([modelID isEqualToString:@"iPhone10,6"]) return @"现今最新";
    if ([modelID isEqualToString:@"iPhone11,8"]) return @"现今最新";
    if ([modelID isEqualToString:@"iPhone11,2"]) return @"现今最新";
    if ([modelID isEqualToString:@"iPhone11,6"]) return @"现今最新";
    if ([modelID isEqualToString:@"iPhone11,4"]) return @"现今最新";
    if ([modelID isEqualToString:@"iPhone12,1"]) return @"现今最新";
    if ([modelID isEqualToString:@"iPhone12,3"]) return @"现今最新";
    if ([modelID isEqualToString:@"iPhone12,5"]) return @"现今最新";
    if ([modelID isEqualToString:@"iPhone12,8"]) return @"现今最新";
    if ([modelID isEqualToString:@"iPhone13,1"]) return @"现今最新";
    if ([modelID isEqualToString:@"iPhone13,2"]) return @"现今最新";
    if ([modelID isEqualToString:@"iPhone13,3"]) return @"现今最新";
    if ([modelID isEqualToString:@"iPhone13,4"]) return @"现今最新";

    if ([modelID isEqualToString:@"iPad1,1"])  return @"iOS 5.1.1";
    if ([modelID isEqualToString:@"iPad2,1"])  return @"iOS 9.3.3";
    if ([modelID isEqualToString:@"iPad2,2"])  return @"iOS 9.3.3";
    if ([modelID isEqualToString:@"iPad2,3"])  return @"iOS 9.3.3";
    if ([modelID isEqualToString:@"iPad2,4"])  return @"iOS 9.3.3";
    if ([modelID isEqualToString:@"iPad3,1"])  return @"iOS 9.3.3";
    if ([modelID isEqualToString:@"iPad3,2"])  return @"iOS 9.3.3";
    if ([modelID isEqualToString:@"iPad3,3"])  return @"iOS 9.3.3";
    if ([modelID isEqualToString:@"iPad3,4"])  return @"iOS 10.3.3";
    if ([modelID isEqualToString:@"iPad3,5"])  return @"iOS 10.3.3";
    if ([modelID isEqualToString:@"iPad3,6"])  return @"iOS 10.3.3";
    if ([modelID isEqualToString:@"iPad6,11"]) return @"现今最新";
    if ([modelID isEqualToString:@"iPad6,12"]) return @"现今最新";
    if ([modelID isEqualToString:@"iPad7,5"])  return @"现今最新";
    if ([modelID isEqualToString:@"iPad7,6"])  return @"现今最新";
    if ([modelID isEqualToString:@"iPad7,11"]) return @"现今最新";
    if ([modelID isEqualToString:@"iPad7,12"]) return @"现今最新";
    if ([modelID isEqualToString:@"iPad11,6"]) return @"现今最新";
    if ([modelID isEqualToString:@"iPad11,7"]) return @"现今最新";

    if ([modelID isEqualToString:@"iPad4,1"])  return @"iOS 12.2";
    if ([modelID isEqualToString:@"iPad4,2"])  return @"iOS 12.2";
    if ([modelID isEqualToString:@"iPad4,3"])  return @"iOS 12.2";
    if ([modelID isEqualToString:@"iPad5,3"])  return @"iOS 12.2";
    if ([modelID isEqualToString:@"iPad5,4"])  return @"iOS 12.2";
    if ([modelID isEqualToString:@"iPad11,3"]) return @"现今最新";
    if ([modelID isEqualToString:@"iPad11,4"]) return @"现今最新";
    if ([modelID isEqualToString:@"iPad13,1"]) return @"现今最新";
    if ([modelID isEqualToString:@"iPad13,2"]) return @"现今最新";

    if ([modelID isEqualToString:@"iPad6,7"])  return @"现今最新";
    if ([modelID isEqualToString:@"iPad6,8"])  return @"现今最新";
    if ([modelID isEqualToString:@"iPad6,3"])  return @"现今最新";
    if ([modelID isEqualToString:@"iPad6,4"])  return @"现今最新";
    if ([modelID isEqualToString:@"iPad7,1"])  return @"现今最新";
    if ([modelID isEqualToString:@"iPad7,2"])  return @"现今最新";
    if ([modelID isEqualToString:@"iPad7,3"])  return @"现今最新";
    if ([modelID isEqualToString:@"iPad7,4"])  return @"现今最新";
    if ([modelID isEqualToString:@"iPad8,1"])  return @"现今最新";
    if ([modelID isEqualToString:@"iPad8,2"])  return @"现今最新";
    if ([modelID isEqualToString:@"iPad8,3"])  return @"现今最新";
    if ([modelID isEqualToString:@"iPad8,4"])  return @"现今最新";
    if ([modelID isEqualToString:@"iPad8,5"])  return @"现今最新";
    if ([modelID isEqualToString:@"iPad8,6"])  return @"现今最新";
    if ([modelID isEqualToString:@"iPad8,7"])  return @"现今最新";
    if ([modelID isEqualToString:@"iPad8,8"])  return @"现今最新";
    if ([modelID isEqualToString:@"iPad8,9"])  return @"现今最新";
    if ([modelID isEqualToString:@"iPad8,10"]) return @"现今最新";
    if ([modelID isEqualToString:@"iPad8,11"]) return @"现今最新";
    if ([modelID isEqualToString:@"iPad8,12"]) return @"现今最新";

    if ([modelID isEqualToString:@"iPad2,5"])  return @"iOS 9.3.3";
    if ([modelID isEqualToString:@"iPad2,6"])  return @"iOS 9.3.3";
    if ([modelID isEqualToString:@"iPad2,7"])  return @"iOS 9.3.3";
    if ([modelID isEqualToString:@"iPad4,4"])  return @"iOS 12.2";
    if ([modelID isEqualToString:@"iPad4,5"])  return @"iOS 12.2";
    if ([modelID isEqualToString:@"iPad4,6"])  return @"iOS 12.2";
    if ([modelID isEqualToString:@"iPad4,7"])  return @"iOS 12.2";
    if ([modelID isEqualToString:@"iPad4,8"])  return @"iOS 12.2";
    if ([modelID isEqualToString:@"iPad4,9"])  return @"iOS 12.2";
    if ([modelID isEqualToString:@"iPad5,1"])  return @"现今最新";
    if ([modelID isEqualToString:@"iPad5,2"])  return @"现今最新";
    if ([modelID isEqualToString:@"iPad11,1"]) return @"现今最新";
    if ([modelID isEqualToString:@"iPad11,2"]) return @"现今最新";

    if ([modelID isEqualToString:@"iPod1,1"]) return @"iOS 3.1.3";
    if ([modelID isEqualToString:@"iPod2,1"]) return @"iOS 4.2.1";
    if ([modelID isEqualToString:@"iPod3,1"]) return @"iOS 5.1.1";
    if ([modelID isEqualToString:@"iPod4,1"]) return @"iOS 6.1.6";
    if ([modelID isEqualToString:@"iPod5,1"]) return @"iOS 9.3.3";
    if ([modelID isEqualToString:@"iPod7,1"]) return @"iOS 12.2";
    if ([modelID isEqualToString:@"iPod9,1"]) return @"现今最新";

    return @"未知";
}

+ (NSString *)deviceAspectRatio:(NSString *)screenSize
{
    if ([screenSize isEqualToString:@"3.5\""])  return @"2:3";
    if ([screenSize isEqualToString:@"4\""])    return @"9:16";
    if ([screenSize isEqualToString:@"4.7\""])  return @"9:16";
    if ([screenSize isEqualToString:@"5.5\""])  return @"9:16";
    if ([screenSize isEqualToString:@"5.8\""])  return @"9:19.5";
    if ([screenSize isEqualToString:@"6.1\""])  return @"9:19.5";
    if ([screenSize isEqualToString:@"6.5\""])  return @"9:19.5";
    if ([screenSize isEqualToString:@"5.4\""])  return @"9:19.5";
    if ([screenSize isEqualToString:@"6.7\""])  return @"9:19.5";
    if ([screenSize isEqualToString:@"9.7\""])  return @"3:4";
    if ([screenSize isEqualToString:@"10.2\""]) return @"3:4";
    if ([screenSize isEqualToString:@"10.5\""]) return @"3:4";
    if ([screenSize isEqualToString:@"10.9\""]) return @"7:10";
    if ([screenSize isEqualToString:@"11\""])   return @"7:10";
    if ([screenSize isEqualToString:@"12.9\""]) return @"3:4";
    if ([screenSize isEqualToString:@"7.9\""])  return @"3:4";
    
    return @"未知";
}

+ (NSString *)deviceBatteryMah:(NSString *)modelID
{
    if ([modelID isEqualToString:@"iPhone1,1"])  return @"未知";
    if ([modelID isEqualToString:@"iPhone1,2"])  return @"未知";
    if ([modelID isEqualToString:@"iPhone2,1"])  return @"未知";
    if ([modelID isEqualToString:@"iPhone3,1"])  return @"1420 mAh";
    if ([modelID isEqualToString:@"iPhone3,2"])  return @"1420 mAh";
    if ([modelID isEqualToString:@"iPhone3,3"])  return @"1420 mAh";
    if ([modelID isEqualToString:@"iPhone4,1"])  return @"1420 mAh";
    if ([modelID isEqualToString:@"iPhone5,1"])  return @"1440 mAh";
    if ([modelID isEqualToString:@"iPhone5,2"])  return @"1440 mAh";
    if ([modelID isEqualToString:@"iPhone5,3"])  return @"1510 mAh";
    if ([modelID isEqualToString:@"iPhone5,4"])  return @"1510 mAh";
    if ([modelID isEqualToString:@"iPhone6,1"])  return @"1550 mAh";
    if ([modelID isEqualToString:@"iPhone6,2"])  return @"1550 mAh";
    if ([modelID isEqualToString:@"iPhone7,2"])  return @"1810 mAh";
    if ([modelID isEqualToString:@"iPhone7,1"])  return @"2915 mAh";
    if ([modelID isEqualToString:@"iPhone8,1"])  return @"1715 mAh";
    if ([modelID isEqualToString:@"iPhone8,2"])  return @"2750 mAh";
    if ([modelID isEqualToString:@"iPhone8,4"])  return @"1624 mAh";
    if ([modelID isEqualToString:@"iPhone9,1"])  return @"1960 mAh";
    if ([modelID isEqualToString:@"iPhone9,3"])  return @"1960 mAh";
    if ([modelID isEqualToString:@"iPhone9,2"])  return @"2900 mAh";
    if ([modelID isEqualToString:@"iPhone9,4"])  return @"2900 mAh";
    if ([modelID isEqualToString:@"iPhone10,1"]) return @"1821 mAh";
    if ([modelID isEqualToString:@"iPhone10,4"]) return @"1821 mAh";
    if ([modelID isEqualToString:@"iPhone10,2"]) return @"2675 mAh";
    if ([modelID isEqualToString:@"iPhone10,5"]) return @"2675 mAh";
    if ([modelID isEqualToString:@"iPhone10,3"]) return @"2716 mAh";
    if ([modelID isEqualToString:@"iPhone10,6"]) return @"2716 mAh";
    if ([modelID isEqualToString:@"iPhone11,8"]) return @"2942 mAh";
    if ([modelID isEqualToString:@"iPhone11,2"]) return @"2658 mAh";
    if ([modelID isEqualToString:@"iPhone11,6"]) return @"3174 mAh";
    if ([modelID isEqualToString:@"iPhone11,4"]) return @"3174 mAh";
    if ([modelID isEqualToString:@"iPhone12,1"]) return @"3110 mAh";
    if ([modelID isEqualToString:@"iPhone12,3"]) return @"3174 mAh";
    if ([modelID isEqualToString:@"iPhone12,5"]) return @"3969 mAh";
    if ([modelID isEqualToString:@"iPhone12,8"]) return @"1821 mAh";
    if ([modelID isEqualToString:@"iPhone13,1"]) return @"2227 mAh";
    if ([modelID isEqualToString:@"iPhone13,2"]) return @"2851 mAh";
    if ([modelID isEqualToString:@"iPhone13,3"]) return @"2815 mAh";
    if ([modelID isEqualToString:@"iPhone13,4"]) return @"3687 mAh";

    if ([modelID isEqualToString:@"iPad1,1"])  return @"6930 mAh";
    if ([modelID isEqualToString:@"iPad2,1"])  return @"6930 mAh";
    if ([modelID isEqualToString:@"iPad2,2"])  return @"6930 mAh";
    if ([modelID isEqualToString:@"iPad2,3"])  return @"6930 mAh";
    if ([modelID isEqualToString:@"iPad2,4"])  return @"6930 mAh";
    if ([modelID isEqualToString:@"iPad3,1"])  return @"11666 mAh";
    if ([modelID isEqualToString:@"iPad3,2"])  return @"11666 mAh";
    if ([modelID isEqualToString:@"iPad3,3"])  return @"11666 mAh";
    if ([modelID isEqualToString:@"iPad3,4"])  return @"11560 mAh";
    if ([modelID isEqualToString:@"iPad3,5"])  return @"11560 mAh";
    if ([modelID isEqualToString:@"iPad3,6"])  return @"11560 mAh";
    if ([modelID isEqualToString:@"iPad6,11"]) return @"8756 mAh";
    if ([modelID isEqualToString:@"iPad6,12"]) return @"8756 mAh";
    if ([modelID isEqualToString:@"iPad7,5"])  return @"7340 mAh";
    if ([modelID isEqualToString:@"iPad7,6"])  return @"7340 mAh";
    if ([modelID isEqualToString:@"iPad7,11"]) return @"6430 mAh";
    if ([modelID isEqualToString:@"iPad7,12"]) return @"6430 mAh";
    if ([modelID isEqualToString:@"iPad11,6"]) return @"8758 mAh";
    if ([modelID isEqualToString:@"iPad11,7"]) return @"8758 mAh";

    if ([modelID isEqualToString:@"iPad4,1"])  return @"8827 mAh";
    if ([modelID isEqualToString:@"iPad4,2"])  return @"8827 mAh";
    if ([modelID isEqualToString:@"iPad4,3"])  return @"8827 mAh";
    if ([modelID isEqualToString:@"iPad5,3"])  return @"7340 mAh";
    if ([modelID isEqualToString:@"iPad5,4"])  return @"7340 mAh";
    if ([modelID isEqualToString:@"iPad11,3"]) return @"8170 mAh";
    if ([modelID isEqualToString:@"iPad11,4"]) return @"8170 mAh";
    if ([modelID isEqualToString:@"iPad13,1"]) return @"7586 mAh";
    if ([modelID isEqualToString:@"iPad13,2"]) return @"7586 mAh";

    if ([modelID isEqualToString:@"iPad6,7"])  return @"10307 mAh";
    if ([modelID isEqualToString:@"iPad6,8"])  return @"10307 mAh";
    if ([modelID isEqualToString:@"iPad6,3"])  return @"10212 mAh";
    if ([modelID isEqualToString:@"iPad6,4"])  return @"10212 mAh";
    if ([modelID isEqualToString:@"iPad7,1"])  return @"10307 mAh";
    if ([modelID isEqualToString:@"iPad7,2"])  return @"10307 mAh";
    if ([modelID isEqualToString:@"iPad7,3"])  return @"8282 mAh";
    if ([modelID isEqualToString:@"iPad7,4"])  return @"8282 mAh";
    if ([modelID isEqualToString:@"iPad8,1"])  return @"7812 mAh";
    if ([modelID isEqualToString:@"iPad8,2"])  return @"7812 mAh";
    if ([modelID isEqualToString:@"iPad8,3"])  return @"7812 mAh";
    if ([modelID isEqualToString:@"iPad8,4"])  return @"7812 mAh";
    if ([modelID isEqualToString:@"iPad8,5"])  return @"9706 mAh";
    if ([modelID isEqualToString:@"iPad8,6"])  return @"9706 mAh";
    if ([modelID isEqualToString:@"iPad8,7"])  return @"9706 mAh";
    if ([modelID isEqualToString:@"iPad8,8"])  return @"9706 mAh";
    if ([modelID isEqualToString:@"iPad8,9"])  return @"7540 mAh";
    if ([modelID isEqualToString:@"iPad8,10"]) return @"7540 mAh";
    if ([modelID isEqualToString:@"iPad8,11"]) return @"9706 mAh";
    if ([modelID isEqualToString:@"iPad8,12"]) return @"9706 mAh";

    if ([modelID isEqualToString:@"iPad2,5"])  return @"4440 mAh";
    if ([modelID isEqualToString:@"iPad2,6"])  return @"4440 mAh";
    if ([modelID isEqualToString:@"iPad2,7"])  return @"4440 mAh";
    if ([modelID isEqualToString:@"iPad4,4"])  return @"6000 mAh";
    if ([modelID isEqualToString:@"iPad4,5"])  return @"6000 mAh";
    if ([modelID isEqualToString:@"iPad4,6"])  return @"6000 mAh";
    if ([modelID isEqualToString:@"iPad4,7"])  return @"6000 mAh";
    if ([modelID isEqualToString:@"iPad4,8"])  return @"6000 mAh";
    if ([modelID isEqualToString:@"iPad4,9"])  return @"6000 mAh";
    if ([modelID isEqualToString:@"iPad5,1"])  return @"5124 mAh";
    if ([modelID isEqualToString:@"iPad5,2"])  return @"5124 mAh";
    if ([modelID isEqualToString:@"iPad11,1"]) return @"5140 mAh";
    if ([modelID isEqualToString:@"iPad11,2"]) return @"5140 mAh";

    return @"未知";
}

+ (NSString *)deviceCPUFrequency:(NSString *)SoCName showMHz:(BOOL)showMHz
{
    if (showMHz) {
        if ([SoCName isEqualToString:@"Samsung S5L8900"])   return @"412 MHz";
        if ([SoCName isEqualToString:@"Samsung S5L8720"])   return @"532 MHz";
        if ([SoCName isEqualToString:@"Samsung S5PC100"])   return @"600 MHz";
        if ([SoCName isEqualToString:@"Apple A4"])          return @"1000 MHz";
        if ([SoCName isEqualToString:@"Apple A5"])          return @"1000 MHz";
        if ([SoCName isEqualToString:@"Apple A5X"])         return @"1000 MHz";
        if ([SoCName isEqualToString:@"Apple A6"])          return @"1300 MHz";
        if ([SoCName isEqualToString:@"Apple A6X"])         return @"1400 MHz";
        if ([SoCName isEqualToString:@"Apple A7"])          return @"1300 MHz";
        if ([SoCName isEqualToString:@"Apple A8"])          return @"1400 MHz";
        if ([SoCName isEqualToString:@"Apple A8X"])         return @"1500 MHz";
        if ([SoCName isEqualToString:@"Apple A9"])          return @"1850 MHz";
        if ([SoCName isEqualToString:@"Apple A9X"])         return @"2260 MHz";
        if ([SoCName isEqualToString:@"Apple A10 Fusion"])  return @"2340 MHz";
        if ([SoCName isEqualToString:@"Apple A10X Fusion"]) return @"2360 MHz";
        if ([SoCName isEqualToString:@"Apple A11 Bionic"])  return @"2360 MHz";
        if ([SoCName isEqualToString:@"Apple A12 Bionic"])  return @"2490 MHz";
        if ([SoCName isEqualToString:@"Apple A12X Bionic"]) return @"2490 MHz";
        if ([SoCName isEqualToString:@"Apple A13 Bionic"])  return @"2650 MHz";
        if ([SoCName isEqualToString:@"Apple A12Z"])        return @"2490 MHz";
        if ([SoCName isEqualToString:@"Apple A14 Bionic"])  return @"3000 MHz";
    }
    if ([SoCName isEqualToString:@"Samsung S5L8900"])   return @"412 MHz";
    if ([SoCName isEqualToString:@"Samsung S5L8720"])   return @"532 MHz";
    if ([SoCName isEqualToString:@"Samsung S5PC100"])   return @"600 MHz";
    if ([SoCName isEqualToString:@"Apple A4"])          return @"1.0 GHz";
    if ([SoCName isEqualToString:@"Apple A5"])          return @"1.0 GHz";
    if ([SoCName isEqualToString:@"Apple A5X"])         return @"1.0 GHz";
    if ([SoCName isEqualToString:@"Apple A6"])          return @"1.3 GHz";
    if ([SoCName isEqualToString:@"Apple A6X"])         return @"1.4 GHz";
    if ([SoCName isEqualToString:@"Apple A7"])          return @"1.3 GHz";
    if ([SoCName isEqualToString:@"Apple A8"])          return @"1.4 GHz";
    if ([SoCName isEqualToString:@"Apple A8X"])         return @"1.5 GHz";
    if ([SoCName isEqualToString:@"Apple A9"])          return @"1.85 GHz";
    if ([SoCName isEqualToString:@"Apple A9X"])         return @"2.26 GHz";
    if ([SoCName isEqualToString:@"Apple A10 Fusion"])  return @"2.34 GHz";
    if ([SoCName isEqualToString:@"Apple A10X Fusion"]) return @"2.36 GHz";
    if ([SoCName isEqualToString:@"Apple A11 Bionic"])  return @"2.36 GHz";
    if ([SoCName isEqualToString:@"Apple A12 Bionic"])  return @"2.49 GHz";
    if ([SoCName isEqualToString:@"Apple A12X Bionic"]) return @"2.49 GHz";
    if ([SoCName isEqualToString:@"Apple A13 Bionic"])  return @"2.65 GHz";
    if ([SoCName isEqualToString:@"Apple A12Z"])        return @"2.49 GHz";
    if ([SoCName isEqualToString:@"Apple A14 Bionic"])  return @"2.99 GHz";
    
    return @"未知" ;
}

@end
