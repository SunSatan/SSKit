//
//  SSScreen.h
//  SSKit
//
//  Created by 孙铭健 on 2020/9/28.
//  Copyright © 2020 孙铭健. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SSScreen : NSObject
/// 设备屏幕Bounds
@property (class, nonatomic, readonly) CGRect  deviceScreenBounds;
/// 设备屏幕宽度
@property (class, nonatomic, readonly) CGFloat deviceScreenWidth;
/// 设备屏幕高度
@property (class, nonatomic, readonly) CGFloat deviceScreenHeight;
/// 设备状态栏高度
@property (class, nonatomic, readonly) CGFloat statusBarHeight;
/// 设备导航栏高度
@property (class, nonatomic, readonly) CGFloat navigationBarHeight;
/// 设备导航工具栏高度
@property (class, nonatomic, readonly) CGFloat navigationToolBarHeight;
/// 设备标签栏高度
@property (class, nonatomic, readonly) CGFloat tabBarHeight;
/// 设备安全区域
@property (class, nonatomic, readonly) CGRect  safeAreaFrame;
/// 设备安全区域左边距
@property (class, nonatomic, readonly) CGFloat safeAreaLeft;
/// 设备安全区域右边距
@property (class, nonatomic, readonly) CGFloat safeAreaRight;
/// 设备安全区域上边距
@property (class, nonatomic, readonly) CGFloat safeAreaTop;
/// 获取设备安全区域下边距
@property (class, nonatomic, readonly) CGFloat safeAreaBottom;
/// 设备支持的最高FPS
@property (class, nonatomic, readonly) NSInteger maxFPS;
/// 屏幕原生高
@property (class, nonatomic, readonly) NSInteger screenNativeHeight;
/// 屏幕原生宽
@property (class, nonatomic, readonly) NSInteger screenNativeWidth;
/// 屏幕分辨率
@property (class, nonatomic, readonly) NSString *screenRes;

@end

NS_ASSUME_NONNULL_END
