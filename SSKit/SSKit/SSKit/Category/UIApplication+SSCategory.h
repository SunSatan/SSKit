//
//  UIApplication+SSCategory.h
//  SSKit
//
//  Created by 孙铭健 on 2020/9/18.
//  Copyright © 2020 孙铭健. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define SSApplication [UIApplication sharedApplication]
#define SSKeyWindow [UIApplication sharedApplication].keyWindow

@interface UIApplication (SSCategory)

/**
 * 清除启动屏幕缓存：
 */
- (void)clearLaunchScreenCache;

@end

NS_ASSUME_NONNULL_END
