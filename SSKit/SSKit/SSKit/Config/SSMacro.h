//
//  SSMacro.h
//  SSKit
//
//  Created by 孙铭健 on 2020/9/18.
//  Copyright © 2020 孙铭健. All rights reserved.
//

#ifndef SSMacro_h
#define SSMacro_h

#pragma mark - 通用常量宏定义

#define iOS(x) @available(iOS x, *)

#define weakify   autoreleasepool{} __weak   typeof(self) selfWeak = self
#define strongify autoreleasepool{} __strong typeof(selfWeak) self = selfWeak;

#define WeakObj(o)   autoreleasepool{} __weak   typeof(o) o##Weak = o##Strong;
#define StrongObj(o) autoreleasepool{} __strong typeof(o) o##Strong = o##Weak;

//分支预测优化
#define fastpath(x) (__builtin_expect(!!x, 1))
#define slowpath(x) (__builtin_expect(!!x, 0))

//自定义提示框和NSLog
#ifdef DEBUG
    #define SSLog(fmt) NSLog((@"\n[函数名:%s]\n" "[行号:%d]\n" "[打印信息: %@]\n"), __FUNCTION__, __LINE__, fmt)

    #define SSParameterLog(fmt,...) NSLog((@"\n[函数名:%s]\n" "[行号:%d]\n" fmt), __FUNCTION__, __LINE__, ##__VA_ARGS__);

    #define SSAlertLog(fmt, ...) { UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"[函数名:%s]\n [行号 %d] ", __PRETTY_FUNCTION__, __LINE__] message:[NSString stringWithFormat:fmt, ##__VA_ARGS__]  delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil]; [alert show]; }
#else
    #define NSLog(...) nil
    #define SSLog(...) nil
    #define SSParameterLog(...) nil
    #define SSAlertLog(...) nil
#endif

//线程
#define GlobalQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define MainQueue   dispatch_get_main_queue()

//沙盒路径
#define PATH_OF_APP_HOME    NSHomeDirectory()
#define PATH_OF_TEMPORARY        NSTemporaryDirectory()
#define PATH_OF_DOCUMENT    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];

//定义通知
#define NotificationCenter [NSNotificationCenter defaultCenter]
#define UserDefaults       [NSUserDefaults standardUserDefaults]

#define MainBundle [NSBundle mainBundle]

#endif /* SSMacro_h */
