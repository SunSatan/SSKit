//
//  AppDelegate+SSBackgroundTask.m
//  SSBackgroundTaskCategory
//
//  Created by SunSatan on 2020/9/4.
//  Copyright © 2020 SunSatan. All rights reserved.
//

#import "AppDelegate+SSBackgroundTask.h"
#import <objc/runtime.h>

static const void *timerKey = &timerKey;

@interface AppDelegate ()

@property (nonatomic, assign) UIBackgroundTaskIdentifier backgroundTaskIdentifier;
@property (nonatomic, strong) NSTimer *backgroundTimer;

@end

@implementation AppDelegate (SSBackgroundTask)

- (void)beginBackgroundTaskWithBlock:(void (^)(void))doSomething
{
    [self beginBackgroundTaskWithBlock:doSomething openTimeRemaining:NO];
}

- (void)beginBackgroundTaskWithBlock:(void (^)(void))doSomething openTimeRemaining:(BOOL)openTimeRemaining
{
    if (![self isMultitaskingSupported]) return;
    
    self.backgroundTaskIdentifier = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
        [self endBackgroundTask];
    }];
    
    doSomething();
    
    if (openTimeRemaining) [self openTimeRemaining];
}

- (void)endBackgroundTask
{
    NSLog(@"endBackgroundTask");
    __weak typeof(self) selfWeak = self;
    dispatch_async(dispatch_get_main_queue(), ^{ //为什么要放到主队列来做？
        //end task
        [[UIApplication sharedApplication] endBackgroundTask:selfWeak.backgroundTaskIdentifier];
        selfWeak.backgroundTaskIdentifier = UIBackgroundTaskInvalid;
        //close timer
        if (selfWeak) {
            [selfWeak.backgroundTimer invalidate];
            selfWeak.backgroundTimer = nil;
        }
    });
}

- (BOOL)isMultitaskingSupported
{
    return [[UIDevice currentDevice] isMultitaskingSupported];
}

- (void)openTimeRemaining
{
    if (self.backgroundTimer) return;
    
    self.backgroundTimer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        //应用程序在后台运行的最长剩余时间，一般30s
        NSTimeInterval backgroundTimeRemaining = [[UIApplication sharedApplication] backgroundTimeRemaining];
        if (backgroundTimeRemaining == DBL_MAX){ //等于最大值则未定
            NSLog(@"Background Time Remaining is Undetermined");
        } else {
            NSLog(@"Background Time Remaining is %.02f Seconds", backgroundTimeRemaining);
        }
    }];
}

#pragma mark - setter && getter

- (UIBackgroundTaskIdentifier)backgroundTaskIdentifier
{
     UIBackgroundTaskIdentifier backgroundTaskIdentifier = (UIBackgroundTaskIdentifier) objc_getAssociatedObject(self, _cmd);
    return backgroundTaskIdentifier;
}

- (void)setBackgroundTaskIdentifier:(UIBackgroundTaskIdentifier)backgroundTaskIdentifier
{
    objc_setAssociatedObject(self, _cmd, @(backgroundTaskIdentifier), OBJC_ASSOCIATION_ASSIGN);
}

- (NSTimer *)backgroundTimer
{
    return objc_getAssociatedObject(self,timerKey);
}

- (void)setBackgroundTimer:(NSTimer *)backgroundTimer
{
    objc_setAssociatedObject(self, timerKey, backgroundTimer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
