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
typedef void(^AltitudeDataBack) (double altitude);
typedef void(^LocaleNameDataBack) (NSString *LocaleName);

@interface SSLocation : NSObject

/// 开启数据自动更新
- (void)startUpdatingLocationWithTarget:(id)target;

/// 经纬度数据更新回调，需要手动开启更新。
@property (nonatomic, copy) LonAndLatDataBack  lonAndLatDataBack;
/// 海拔高度数据更新回调，需要手动开启更新。
@property (nonatomic, copy) AltitudeDataBack   altitudeDataBack;
/// 定位位置具体名称更新回调，需要手动开启更新。准确到街道：中国四川省成都市武侯区吉庆四路。
@property (nonatomic, copy) LocaleNameDataBack localeNameDataBack;

@end

NS_ASSUME_NONNULL_END
