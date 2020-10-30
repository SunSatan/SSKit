//
//  UIApplication+SSCategory.h
//  SSKit
//
//  Created by SunSatan on 2020/9/18.
//  Copyright © 2020 SunSatan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define SSApplication UIApplication.sharedApplication
#define SSKeyWindow   UIApplication.sharedApplication.keyWindow
#define SSRootViewController UIApplication.sharedApplication.keyWindow.rootViewController

@interface UIApplication (SSCategory)

/**
 * 清除启动屏幕缓存：
 */
- (void)ss_clearLaunchScreenCache;

@end

NS_ASSUME_NONNULL_END
