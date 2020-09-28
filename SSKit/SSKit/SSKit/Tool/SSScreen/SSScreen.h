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

@property (class, nonatomic, readonly) CGRect  deviceScreenBounds; //获取设备屏幕Bounds
@property (class, nonatomic, readonly) CGFloat deviceScreenWidth;  //获取设备屏幕宽度
@property (class, nonatomic, readonly) CGFloat deviceScreenHeight; //获取设备屏幕高度

@property (class, nonatomic, readonly) CGFloat statusBarHeight; //获取设备状态栏高度

@property (class, nonatomic, readonly) CGFloat navigationBarHeight;     //获取设备导航栏高度
@property (class, nonatomic, readonly) CGFloat navigationToolBarHeight; //获取设备导航工具栏高度

@property (class, nonatomic, readonly) CGFloat tabBarHeight; //获取设备标签栏高度

@property (class, nonatomic, readonly) CGRect  safeAreaFrame;  //获取设备安全区域
@property (class, nonatomic, readonly) CGFloat safeAreaLeft;   //获取设备安全区域左边距
@property (class, nonatomic, readonly) CGFloat safeAreaRight;  //获取设备安全区域右边距
@property (class, nonatomic, readonly) CGFloat safeAreaTop;    //获取设备安全区域上边距
@property (class, nonatomic, readonly) CGFloat safeAreaBottom; //获取设备安全区域下边距

@end

NS_ASSUME_NONNULL_END
