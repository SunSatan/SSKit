//
//  UIApplication+SSCategory.m
//  SSKit
//
//  Created by SunSatan on 2020/9/18.
//  Copyright © 2020 SunSatan. All rights reserved.
//

#import "UIApplication+SSCategory.h"

@implementation UIApplication (SSCategory)

- (void)ss_clearLaunchScreenCache
{
    NSError *error;
    [NSFileManager.defaultManager removeItemAtPath:[NSString stringWithFormat:@"%@/Library/SplashBoard",NSHomeDirectory()] error:&error];
}

@end
