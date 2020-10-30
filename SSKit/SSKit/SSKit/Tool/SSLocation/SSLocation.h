//
//  SSLocation.h
//  SSKit
//
//  Created by SunSatan on 2020/9/28.
//  Copyright © 2020 SunSatan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^LonAndLatDataBack)(double lon, double lat);
typedef void(^AltitudeDataBack)(double altitude);

@interface SSLocation : NSObject

+ (instancetype)share;

///设置 target 可以自动关闭数据更新，不然就需要手动关闭数据自动更新。
@property (nonatomic, weak) id target;

/// 经纬度数据更新回调，需要手动开启更新。
@property (nonatomic, copy) LonAndLatDataBack lonAndLatDataBack;
/// 海拔高度数据更新回调，需要手动开启更新。
@property (nonatomic, copy) AltitudeDataBack  altitudeDataBack;

/// 开启数据自动更新
- (void)startUpdatingLocation;
/// 关闭数据自动更新
- (void)stopUpdatingLocation;


@end

NS_ASSUME_NONNULL_END
