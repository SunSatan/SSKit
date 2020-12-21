//
//  SSTimer.m
//  SSTimer
//
//  Created by SunSatan on 19/8/9.
//  Copyright © 2019年 SunSatan. All rights reserved.
//

#import "SSTimer.h"

@interface SSTimer ()

@property (nonatomic, assign) SEL selector;  // 因为要替换timer的selector，所以SSTTimer需要存储target的selector
@property (nonatomic, weak)   id  target;    // 弱引用原本是timer的target，将timer的target变为自己(SSTTimer)
@property (nonatomic, assign) NSUInteger loopNumber; // 循环次数

@property (nonatomic, strong) NSTimer *timer; // 真正的NSTimer
@property (nonatomic, strong) dispatch_source_t timer_gcd; // source 实现的timer

@end

@implementation SSTimer

#pragma mark - dealloc

- (void)dealloc
{
    NSLog(@"SSTimer -> dealloced!");
    if (_timer) [self cleanTimer];
}

#pragma mark - init

+ (SSTimer *)timerWithTarget:(_Nullable id)target selector:(_Nullable SEL)selector loopNumber:(NSUInteger)loopNumber
{
    SSTimer *timerTarget   = SSTimer.new;
    timerTarget.target     = target;
    timerTarget.selector   = selector;
    timerTarget.loopNumber = loopNumber;
    return timerTarget;
}

#pragma mark - clean

- (void)cleanTimer
{
    NSLog(@"Clean Timer!");
    [_timer invalidate];
    _timer = nil;
}

#pragma mark - Target-action method

+ (SSTimer *)timerWithTimeInterval:(NSTimeInterval)timeInterval
                            target:(id)target
                          selector:(SEL)selector
                          userInfo:(nullable id)userInfo
                           repeats:(BOOL)yesOrNo
{
    NSUInteger loopNumber = yesOrNo?NSUIntegerMax:1;
    SSTimer *timerTarget = [SSTimer timerWithTarget:target selector:selector loopNumber:loopNumber];
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
    NSUInteger loopNumber = yesOrNo?NSUIntegerMax:1;
    SSTimer *timerTarget = [SSTimer timerWithTarget:target selector:selector loopNumber:loopNumber];
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
    NSUInteger loopNumber = yesOrNo?NSUIntegerMax:1;
    SSTimer *timerTarget = [SSTimer timerWithTarget:target selector:selector loopNumber:loopNumber];
    timerTarget.timer = [NSTimer scheduledTimerWithTimeInterval:timeInterval
                                                         target:timerTarget
                                                       selector:@selector(timerInvoke:)
                                                       userInfo:userInfo
                                                        repeats:yesOrNo];
    return timerTarget;
}

- (void)timerInvoke:(NSTimer *)timer
{
    //判断 target 是否被释放, 循环次数是否还够
    if (_target && _loopNumber) {
        if (![_target respondsToSelector:_selector]) {
            NSLog(@"未找到 NSTimer 的 selector！");
            [self cleanTimer];
            return;
        }
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [_target performSelector:_selector withObject:timer.userInfo];//执行target中的方法
        #pragma clang diagnostic pop
        _loopNumber--;
    } else {
        [self cleanTimer];
    }
}

#pragma mark - block method

+ (SSTimer *)timerWithTimeInterval:(NSTimeInterval)timeInterval
                            target:(id)target
                           repeats:(BOOL)yesOrNo
                             block:(timerAction)block
{
    NSUInteger loopNumber = yesOrNo?NSUIntegerMax:1;
    SSTimer *timerTarget = [SSTimer timerWithTarget:target selector:nil loopNumber:loopNumber];
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
                             block:(timerAction)block
{
    NSUInteger loopNumber = yesOrNo?NSUIntegerMax:1;
    SSTimer *timerTarget = [SSTimer timerWithTarget:target selector:nil loopNumber:loopNumber];
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
                                      block:(timerAction)block
{
    NSUInteger loopNumber = yesOrNo?NSUIntegerMax:1;
    SSTimer *timerTarget = [SSTimer timerWithTarget:target selector:nil loopNumber:loopNumber];
    timerTarget.timer = [NSTimer scheduledTimerWithTimeInterval:timeInterval
                                                         target:timerTarget
                                                       selector:@selector(blcokInvoke:)
                                                       userInfo:[block copy]
                                                        repeats:yesOrNo];
    return timerTarget;
}

- (void)blcokInvoke:(NSTimer *)timer
{
    // 取出放在userInfo中的block
    timerAction block = timer.userInfo;
    
    // 判断target是否被释放
    if (_target) {
        !block?:block(timer); // 执行block
    } else {
        [self cleanTimer]; // 清除timer
    }
}

#pragma mark - GCDTimer method

+ (SSTimer *)GCD_timerWithTimeInterval:(NSTimeInterval)timeInterval
                                  time:(dispatch_time_t)time
                                target:(id)target
                               repeats:(BOOL)yesOrNo
                                 block:(GCD_timerAction)block
{
    NSUInteger loopNumber = yesOrNo?NSUIntegerMax:1;
    SSTimer *timerTarget = [SSTimer timerWithTarget:target selector:nil loopNumber:loopNumber];
    timerTarget.timer_gcd = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue((intptr_t)"SSTimer_Queue", 0));
    dispatch_source_set_timer(timerTarget.timer_gcd, time, timeInterval * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(timerTarget.timer_gcd, ^{
        if (timerTarget.target) {
            !block?:block(timerTarget.timer_gcd);
        } else {
            [timerTarget cancelTimer];
        }
        
    });
    dispatch_resume(timerTarget.timer_gcd);
    return timerTarget;
}

#pragma mark - GCDTimer stop and cancel

- (void)stopTimer
{
    NSLog(@"stop Timer!");
    dispatch_resume(_timer_gcd);
}

- (void)cancelTimer
{
    NSLog(@"Cancel Timer!");
    dispatch_source_cancel(_timer_gcd);
    _timer_gcd = nil;
}

#pragma mark - dispatch_time method

dispatch_time_t ss_dispatch_time_now_after_millisecond(long milliseconds)
{
    return dispatch_time(DISPATCH_TIME_NOW, milliseconds * NSEC_PER_MSEC);
}

dispatch_time_t ss_timer_absolute_now_after_millisecond(long milliseconds)
{
    return dispatch_walltime(NULL, milliseconds * NSEC_PER_MSEC);
}

dispatch_time_t ss_timer_absolute_from_date_after_seconds(NSDate *date, long afterSeconds)
{
    NSTimeInterval interval = date.timeIntervalSince1970;
    double second, nanosecond;
    nanosecond = modf(interval, &second);
    struct timespec time;
    time.tv_sec = second;
    time.tv_nsec = nanosecond * NSEC_PER_SEC;
    int64_t delta = afterSeconds * NSEC_PER_SEC;
    dispatch_time_t milestone = dispatch_walltime(&time, delta);
    return milestone;
}

@end

