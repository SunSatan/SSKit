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

@property (nonatomic, strong) dispatch_source_t timer_gcd;

@end

@implementation SSTimer

#pragma mark - dealloc

- (void)dealloc
{
    NSLog(@"SSTimer -> dealloced!");
    if (_timer) [self cleanTimer];
}

#pragma mark - clean

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
                             block:(void(^)(NSTimer *timer))block
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
                             block:(void(^)(NSTimer *timer))block
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
                                      block:(void(^)(NSTimer *timer))block
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

- (void)absoluteTimerWithTimeInterval:(NSTimeInterval)timeInterval
                               target:(id)target
                              repeats:(BOOL)yesOrNo
                                block:(void(^)(dispatch_source_t timer))block
{
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue((intptr_t)"SSTime_Queue", 0));
    
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, timeInterval * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        block(timer);
    });
    dispatch_resume(timer);
}



+ (SSTimer *)GCD_timerWithTimeInterval:(NSTimeInterval)timeInterval
                             time:(dispatch_time_t)time
                           target:(id)target
                          repeats:(BOOL)yesOrNo
                            block:(void(^)(dispatch_source_t timer))block
{
    SSTimer *timerTarget = [SSTimer timerWithTarget:target selector:nil];
    timerTarget.timer_gcd = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue((intptr_t)"SSTimer_Queue", 0));
    dispatch_source_set_timer(timerTarget.timer_gcd, time, timeInterval * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timerTarget.timer_gcd, ^{
        block(timerTarget.timer_gcd);
    });
    dispatch_resume(timerTarget.timer_gcd);
    return timerTarget;
}

dispatch_time_t ss_dispatch_time_now_after_seconds(long second) {
    int64_t delta = second * NSEC_PER_SEC;
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, delta);
    return time;
}

dispatch_time_t timer_absolute_now_after_seconds(long second) {
    int64_t delta = second * NSEC_PER_SEC;
    dispatch_time_t time = dispatch_walltime(NULL, delta);
    return time;
}

dispatch_time_t timer_absolute_from_date_after_seconds(NSDate *date, long after) {
    NSTimeInterval interval = [date timeIntervalSince1970];
    double second, nanosecond;
    nanosecond = modf(interval, &second);
    struct timespec time;
    time.tv_sec = second;
    time.tv_nsec = nanosecond * NSEC_PER_SEC;
    int64_t delta = after * NSEC_PER_SEC;
    dispatch_time_t milestone = dispatch_walltime(&time, delta);
    return milestone;
}


@end

