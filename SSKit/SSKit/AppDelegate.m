//
//  AppDelegate.m
//  SSKit
//
//  Created by 孙铭健 on 2020/9/17.
//  Copyright © 2020 孙铭健. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "SSKit.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

static double GetCPUFrequency(void)
{
    volatile NSTimeInterval times[500] = {0.0};
    
    int sum = 0;
    
    for(int i = 0; i < 20; i++)
    {
        times[i] = [[NSProcessInfo processInfo] systemUptime];
#if 0
        sum += freqTest(10000);
#else
        int count = 10000;
        asm volatile(
                 "0:"
                     //loop 1
                     "add     x2,  x2,  x1  \n"
                     "add     x3,  x3,  x2  \n"
                     "add     x4,  x4,  x3  \n"
                     "add     x5,  x5,  x4  \n"
                     "add     x6,  x6,  x5  \n"
                     "add     x7,  x7,  x6  \n"
                     "add     x8,  x8,  x7  \n"
                     "add     x9,  x9,  x8  \n"
                     "add     x10, x10, x9  \n"
                     "add     x11, x11, x10 \n"
                     "add     x12, x12, x11 \n"
                     "add     x14, x14, x12 \n"
                     "add     x1,  x1,  x14 \n"
                     
                     //loop 2
                     "add     x2,  x2,  x1  \n"
                     "add     x3,  x3,  x2  \n"
                     "add     x4,  x4,  x3  \n"
                     "add     x5,  x5,  x4  \n"
                     "add     x6,  x6,  x5  \n"
                     "add     x7,  x7,  x6  \n"
                     "add     x8,  x8,  x7  \n"
                     "add     x9,  x9,  x8  \n"
                     "add     x10, x10, x9  \n"
                     "add     x11, x11, x10 \n"
                     "add     x12, x12, x11 \n"
                     "add     x14, x14, x12 \n"
                     "add     x1,  x1,  x14 \n"
                     
                     //loop 3
                     "add     x2,  x2,  x1  \n"
                     "add     x3,  x3,  x2  \n"
                     "add     x4,  x4,  x3  \n"
                     "add     x5,  x5,  x4  \n"
                     "add     x6,  x6,  x5  \n"
                     "add     x7,  x7,  x6  \n"
                     "add     x8,  x8,  x7  \n"
                     "add     x9,  x9,  x8  \n"
                     "add     x10, x10, x9  \n"
                     "add     x11, x11, x10 \n"
                     "add     x12, x12, x11 \n"
                     "add     x14, x14, x12 \n"
                     "add     x1,  x1,  x14 \n"
                     
                     //loop 4
                     "add     x2,  x2,  x1  \n"
                     "add     x3,  x3,  x2  \n"
                     "add     x4,  x4,  x3  \n"
                     "add     x5,  x5,  x4  \n"
                     "add     x6,  x6,  x5  \n"
                     "add     x7,  x7,  x6  \n"
                     "add     x8,  x8,  x7  \n"
                     "add     x9,  x9,  x8  \n"
                     "add     x10, x10, x9  \n"
                     "add     x11, x11, x10 \n"
                     "add     x12, x12, x11 \n"
                     "add     x14, x14, x12 \n"
                     "add     x1,  x1,  x14 \n"
                     
                     //loop 5
                     "add     x2,  x2,  x1  \n"
                     "add     x3,  x3,  x2  \n"
                     "add     x4,  x4,  x3  \n"
                     "add     x5,  x5,  x4  \n"
                     "add     x6,  x6,  x5  \n"
                     "add     x7,  x7,  x6  \n"
                     "add     x8,  x8,  x7  \n"
                     "add     x9,  x9,  x8  \n"
                     "add     x10, x10, x9  \n"
                     "add     x11, x11, x10 \n"
                     "add     x12, x12, x11 \n"
                     "add     x14, x14, x12 \n"
                     "add     x1,  x1,  x14 \n"
                     
                     //loop 6
                     "add     x2,  x2,  x1  \n"
                     "add     x3,  x3,  x2  \n"
                     "add     x4,  x4,  x3  \n"
                     "add     x5,  x5,  x4  \n"
                     "add     x6,  x6,  x5  \n"
                     "add     x7,  x7,  x6  \n"
                     "add     x8,  x8,  x7  \n"
                     "add     x9,  x9,  x8  \n"
                     "add     x10, x10, x9  \n"
                     "add     x11, x11, x10 \n"
                     "add     x12, x12, x11 \n"
                     "add     x14, x14, x12 \n"
                     "add     x1,  x1,  x14 \n"
                     
                     //loop 7
                     "add     x2,  x2,  x1  \n"
                     "add     x3,  x3,  x2  \n"
                     "add     x4,  x4,  x3  \n"
                     "add     x5,  x5,  x4  \n"
                     "add     x6,  x6,  x5  \n"
                     "add     x7,  x7,  x6  \n"
                     "add     x8,  x8,  x7  \n"
                     "add     x9,  x9,  x8  \n"
                     "add     x10, x10, x9  \n"
                     "add     x11, x11, x10 \n"
                     "add     x12, x12, x11 \n"
                     "add     x14, x14, x12 \n"
                     "add     x1,  x1,  x14 \n"
                     
                     //loop 8
                     "add     x2,  x2,  x1  \n"
                     "add     x3,  x3,  x2  \n"
                     "add     x4,  x4,  x3  \n"
                     "add     x5,  x5,  x4  \n"
                     "add     x6,  x6,  x5  \n"
                     "add     x7,  x7,  x6  \n"
                     "add     x8,  x8,  x7  \n"
                     "add     x9,  x9,  x8  \n"
                     "add     x10, x10, x9  \n"
                     "add     x11, x11, x10 \n"
                     "add     x12, x12, x11 \n"
                     "add     x14, x14, x12 \n"
                     "add     x1,  x1,  x14 \n"
                     
                     //loop 9
                     "add     x2,  x2,  x1  \n"
                     "add     x3,  x3,  x2  \n"
                     "add     x4,  x4,  x3  \n"
                     "add     x5,  x5,  x4  \n"
                     "add     x6,  x6,  x5  \n"
                     "add     x7,  x7,  x6  \n"
                     "add     x8,  x8,  x7  \n"
                     "add     x9,  x9,  x8  \n"
                     "add     x10, x10, x9  \n"
                     "add     x11, x11, x10 \n"
                     "add     x12, x12, x11 \n"
                     "add     x14, x14, x12 \n"
                     "add     x1,  x1,  x14 \n"
                     
                     //loop q10
                     "add     x2,  x2,  x1  \n"
                     "add     x3,  x3,  x2  \n"
                     "add     x4,  x4,  x3  \n"
                     "add     x5,  x5,  x4  \n"
                     "add     x6,  x6,  x5  \n"
                     "add     x7,  x7,  x6  \n"
                     "add     x8,  x8,  x7  \n"
                     "add     x9,  x9,  x8  \n"
                     "add     x10, x10, x9  \n"
                     "add     x11, x11, x10 \n"
                     "add     x12, x12, x11 \n"
                     "add     x14, x14, x12 \n"
                     "add     x1,  x1,  x14 \n"
                     
                     "subs    %x0, %x0, #1  \n"
                     "bne     0b            \n"
                     
                     :
                     "=r"(count)
                     :
                     "0"(count)
                     : "cc", "memory", "x1", "x2", "x3","x4", "x5",  "x6", "x7", "x8","x9", "x10",  "x11", "x12", "x13","x14"
                     );
#endif
        times[i] = 1000.0*([[NSProcessInfo processInfo] systemUptime] - times[i]);//for ms
    }
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[ViewController new]];
    
    self.window = [UIWindow ss_setRootViewController:nav];
    
    return YES;
}

@end
