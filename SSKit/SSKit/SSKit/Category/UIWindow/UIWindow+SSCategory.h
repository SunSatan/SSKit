//
//  UIWindow+SSCategory.h
//  SSKit
//
//  Created by SunSatan on 2020/9/18.
//  Copyright © 2020 SunSatan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIWindow (SSCategory)

/**
 * 初始化 main window 所有流程
 */
+ (instancetype)ss_setRootViewController:(UIViewController *)rootVC;

@end

NS_ASSUME_NONNULL_END
