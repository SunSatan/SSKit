//
//  UIWindow+SSCategory.m
//  SSKit
//
//  Created by SunSatan on 2020/9/18.
//  Copyright © 2020 SunSatan. All rights reserved.
//

#import "UIWindow+SSCategory.h"

@implementation UIWindow (SSCategory)

+ (instancetype)ss_setRootViewController:(UIViewController *)rootVC
{
    NSParameterAssert(rootVC);
    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [window setRootViewController:rootVC];
    [window makeKeyAndVisible];
    return window;
}

@end
