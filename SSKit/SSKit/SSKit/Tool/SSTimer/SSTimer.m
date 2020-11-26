//
//  SSTimer.m
//  SSTimer
//
//  Created by SunSatan on 19/8/9.
//  Copyright © 2019年 SunSatan. All rights reserved.
//

#import "SSTimer.h"
#import "SSWeakProxy.h"

@interface SSTimer ()

@property (nonatomic, strong) NSTimer *timer;// 真正的NSTimer
@property (nonatomic, assign) SEL selector;  // 因为要替换timer的selector，所以SSTTimer需要存储target的selector
@property (nonatomic, weak)   id  target;    // 弱引用原本是timer的target，将timer的target变为自己(SSTTimer)

@end

@implementation SSTimer

#pragma mark - dealloc && clean

- (void)dealloc
{
    NSLog(@"SSTimer dealloced!");
    if (_timer) {
        [self cleanTimer];
    }
}

- (void)cleanTimer
{
    NSLog(@"clean timer!");
    [_timer invalidate];
    _timer = nil;
}

#pragma mark - init

+ (SSTimer *)timerWithTarget:(_Nullable id)target
                    selector:(_Nullable SEL)selector
{
    SSTimer *timerTarget = [[SSTimer alloc]init];
    timerTarget.target    = [SSWeakProxy proxyWithTarget:target];
    timerTarget.selector  = selector;
    return timerTarget;
}

#pragma mark - Target-action method

+ (SSTimer *)timerWithTimeInterval:(NSTimeInterval)timeInterval
                            target:(id)target
                          selector:(SEL)selector
                          userInfo:(nullable id)userInfo
                           repeats:(BOOL)yesOrNo
{
    SSTimer *timerTarget = [SSTimer timerWithTarget:target selector:selector];
    timerTarget.timer = [NSTimer timerWithTimeInterval:timeInterval
                                                target:timerTarget
                                              selector:@selector(timerInvoke:)
                                              userInfo:userInfo
                                               repeats:yesOrNo];
    return timerTarget;
}

+ (SSTimer *)timerWithTimeInterval:(NSTimeInterval)timeInterval
                            target:(id)target
                          selector:(SEL)selector
                          userInfo:(nullable id)userInfo
                           repeats:(BOOL)yesOrNo
                       runLoopMode:(NSRunLoopMode)runLoopMode
{
    SSTimer *timerTarget = [SSTimer timerWithTarget:target selector:selector];
    timerTarget.timer = [NSTimer timerWithTimeInterval:timeInterval
                                                target:timerTarget
                                              selector:@selector(timerInvoke:)
                                              userInfo:userInfo
                                               repeats:yesOrNo];
    [[NSRunLoop currentRunLoop] addTimer:timerTarget.timer forMode:runLoopMode];
    return timerTarget;
}

+ (SSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)timeInterval
                                     target:(id)target
                                   selector:(SEL)selector
                                   userInfo:(nullable id)userInfo
                                    repeats:(BOOL)yesOrNo
{
    SSTimer *timerTarget = [SSTimer timerWithTarget:target selector:selector];
    timerTarget.timer = [NSTimer scheduledTimerWithTimeInterval:timeInterval
                                                         target:timerTarget
                                                       selector:@selector(timerInvoke:)
                                                       userInfo:userInfo
                                                        repeats:yesOrNo];
    return timerTarget;
}

- (void)timerInvoke:(NSTimer *)timer
{
    //判断target是否被释放
    if (_target) {
        if (![_target respondsToSelector:_selector]) {
            NSLog(@"未找到 NSTimer 的 selector方法！");
            [self cleanTimer];
            return;
        }
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [_target performSelector:_selector withObject:timer.userInfo];//执行target中的方法
        #pragma clang diagnostic pop
    } else {
        [self cleanTimer];
    }
}

#pragma mark - block method

+ (SSTimer *)timerWithTimeInterval:(NSTimeInterval)timeInterval
                            target:(id)target
                           repeats:(BOOL)yesOrNo
                             block:(void (^)(NSTimer *timer))block
{
    SSTimer *timerTarget = [SSTimer timerWithTarget:target selector:nil];
    timerTarget.timer = [NSTimer timerWithTimeInterval:timeInterval
                                                target:timerTarget
                                              selector:@selector(blcokInvoke:)
                                              userInfo:[block copy]
                                               repeats:yesOrNo];
    return timerTarget;
}

+ (SSTimer *)timerWithTimeInterval:(NSTimeInterval)timeInterval
                            target:(id)target
                           repeats:(BOOL)yesOrNo
                       runLoopMode:(NSRunLoopMode)runLoopMode
                             block:(void (^)(NSTimer *timer))block
{
    SSTimer *timerTarget = [SSTimer timerWithTarget:target selector:nil];
    timerTarget.timer = [NSTimer timerWithTimeInterval:timeInterval
                                                target:timerTarget
                                              selector:@selector(blcokInvoke:)
                                              userInfo:[block copy]
                                               repeats:yesOrNo];
    [[NSRunLoop currentRunLoop] addTimer:timerTarget.timer forMode:runLoopMode];
    return timerTarget;
}

+ (SSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)timeInterval
                                     target:(id)target
                                    repeats:(BOOL)yesOrNo
                                      block:(void (^)(NSTimer *timer))block
{
    SSTimer *timerTarget = [SSTimer timerWithTarget:target selector:nil];
    timerTarget.timer = [NSTimer scheduledTimerWithTimeInterval:timeInterval
                                                         target:timerTarget
                                                       selector:@selector(blcokInvoke:)
                                                       userInfo:[block copy]
                                                        repeats:yesOrNo];
    return timerTarget;
}

- (void)blcokInvoke:(NSTimer *)timer
{
    //之前将要执行的block copy放在userInfo中，取出
    void (^block)(NSTimer *timer) = timer.userInfo;
    
    //判断target是否被释放
    if (_target) {
        if (block) {
            block(timer);//执行block
        }
    } else {
        [self cleanTimer];//清除timer
    }
}

- (void)timerefgfdfdc
{
    
}
@end

