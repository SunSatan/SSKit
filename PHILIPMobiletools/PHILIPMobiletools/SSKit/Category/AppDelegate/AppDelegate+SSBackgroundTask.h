//
//  AppDelegate+SSBackgroundTask.h
//  SSBackgroundTaskCategory
//
//  Created by SunSatan on 2020/9/4.
//  Copyright © 2020 SunSatan. All rights reserved.
//

#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate (SSBackgroundTask) //应用切换到后台后，仍能执行某些任务
/**
 * 开启后台任务，在app切换至后台时预留时间搞事情
 */
- (void)ss_beginBackgroundTaskWithBlock:(void (^)(void))doSomething;
- (void)ss_beginBackgroundTaskWithBlock:(void (^)(void))doSomething openTimeRemaining:(BOOL)openTimeRemaining;
/**
 * 一定要结束后台任务
 */
- (void)ss_endBackgroundTask;

@end

NS_ASSUME_NONNULL_END
