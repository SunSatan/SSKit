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

+ (NSString *)deviceModelWithDeviceName:(NSString *)deviceName;

@end

NS_ASSUME_NONNULL_END
