//
//  SSTimer.h
//  SSTimer
//
//  Created by SunSatan on 19/8/9.
//  Copyright © 2019年 SunSatan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// SSTimer 为了解决 NSTimer 循环引用
// 通过引入中间类 SSTimer，替换 NSTimer 的 target。
// 并利用 SSTimer 弱引用的 target，让 SSTimer 和 NSTimer 自动管理生命周期，只需要创建和使用，不需要手动释放。
// 重写了 NSTimer 常用的四个方法，包括 block 方法，因为需要使用 target，所以重写的 block 方法需要多传一个 target 参数。
// 多添加了两个可以修改 RunloopMode 的参数的方法。

@interface SSTimer : NSObject

#pragma mark - clean timer

// 本身不需要手动调用，提供给想要在viewWillDisappear中释放timer的

- (void)cleanTimer;

#pragma mark - Target-action

+ (SSTimer *)timerWithTimeInterval:(NSTimeInterval)timeInterval
                            target:(id)target
                          selector:(SEL)selector
                          userInfo:(nullable id)userInfo
                           repeats:(BOOL)yesOrNo;

+ (SSTimer *)timerWithTimeInterval:(NSTimeInterval)timeInterval
                            target:(id)target
                          selector:(SEL)selector
                          userInfo:(nullable id)userInfo
                           repeats:(BOOL)yesOrNo
                       runLoopMode:(NSRunLoopMode)runLoopMode;

+ (SSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)timeInterval
                                     target:(id)target
                                   selector:(SEL)selector
                                   userInfo:(nullable id)userInfo
                                    repeats:(BOOL)yesOrNo;

#pragma mark - block

// 因为需要target来自动释放，所以需要多传一个target

+ (SSTimer *)timerWithTimeInterval:(NSTimeInterval)timeInterval
                            target:(id)target
                           repeats:(BOOL)yesOrNo
                             block:(void (^)(NSTimer *timer))block;

+ (SSTimer *)timerWithTimeInterval:(NSTimeInterval)timeInterval
                            target:(id)target
                           repeats:(BOOL)yesOrNo
                       runLoopMode:(NSRunLoopMode)runLoopMode
                             block:(void (^)(NSTimer *timer))block;

+ (SSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)timeInterval
                                     target:(id)target
                                    repeats:(BOOL)yesOrNo
                                      block:(void (^)(NSTimer *timer))block;

@end

NS_ASSUME_NONNULL_END

