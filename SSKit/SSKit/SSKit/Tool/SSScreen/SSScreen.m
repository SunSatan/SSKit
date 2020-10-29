//
//  SSScreen.m
//  SSKit
//
//  Created by 孙铭健 on 2020/9/28.
//  Copyright © 2020 孙铭健. All rights reserved.
//

#import "SSScreen.h"
#import "SSDeviceLibrary.h"

@implementation SSScreen

+ (CGRect)screenBounds
{
    return UIScreen.mainScreen.bounds;
}

+ (CGFloat)screenWidth
{
    return UIScreen.mainScreen.bounds.size.width;
}

+ (CGFloat)screenHeight
{
    return UIScreen.mainScreen.bounds.size.height;
}

+ (CGFloat)statusBarHeight
{
    CGFloat statusBarHeight = 0;
    if (@available(iOS 13.0, *)) {
        UIStatusBarManager *statusBarManager = UIApplication.sharedApplication.windows.firstObject.windowScene.statusBarManager;
        statusBarHeight = statusBarManager.statusBarFrame.size.height;
    } else {
        statusBarHeight = UIApplication.sharedApplication.statusBarFrame.size.height;
    }
    return statusBarHeight;
}

+ (CGFloat)navigationBarHeight
{
    UINavigationController *navigationController = UINavigationController.alloc.init;
    CGFloat navigationBarHeight = navigationController.navigationBar.frame.size.height;
    return navigationBarHeight;
}

+ (CGFloat)navigationToolBarHeight
{
    UINavigationController *navigationController = UINavigationController.alloc.init;
    CGFloat toolBarHeight = navigationController.toolbar.frame.size.height;
    return toolBarHeight;
}

+ (CGFloat)tabBarHeight
{
    UITabBarController *tabBarController = UITabBarController.alloc.init;
    CGFloat tabBarHeight = tabBarController.tabBar.frame.size.height;
    return tabBarHeight;
}

+ (CGRect)safeAreaFrame
{
    CGRect safeAreaFrame = CGRectZero;
    if (@available(iOS 11.0, *)) {
        UIViewController *vc = UIViewController.alloc.init;
        safeAreaFrame = vc.view.safeAreaLayoutGuide.layoutFrame;
    }
    return safeAreaFrame;
}

+ (CGFloat)safeAreaLeft
{
    CGFloat safeAreaLeft = 0;
    if (@available(iOS 11.0, *)) {
        UIViewController *vc = UIViewController.alloc.init;
        safeAreaLeft = vc.view.safeAreaInsets.left;
    }
    return safeAreaLeft;
}

+ (CGFloat)safeAreaRight
{
    CGFloat safeAreaRight = 0;
    if (@available(iOS 11.0, *)) {
        UIViewController *vc = UIViewController.alloc.init;
        safeAreaRight = vc.view.safeAreaInsets.right;
    }
    return safeAreaRight;
}

+ (CGFloat)safeAreaTop
{
    CGFloat safeAreaTop = 0;
    if (@available(iOS 11.0, *)) {
        UIViewController *vc = UIViewController.alloc.init;
        safeAreaTop = vc.view.safeAreaInsets.top;
    }
    return safeAreaTop;
}

+ (CGFloat)safeAreaBottom
{
    CGFloat safeAreaBottom = 0 ;
    if (@available(iOS 11.0, *)) {
        UIViewController *vc = UIViewController.alloc.init;
        safeAreaBottom = vc.view.safeAreaInsets.bottom;
    }
    return safeAreaBottom;
}

+ (NSInteger)maxFPS
{
    return UIScreen.mainScreen.maximumFramesPerSecond;
}

+ (CGRect)screenNativeBounds
{
    return UIScreen.mainScreen.nativeBounds;
}

+ (NSInteger)screenNativeWidth
{
    return UIScreen.mainScreen.nativeBounds.size.width;
}

+ (NSInteger)screenNativeHeight
{
    return UIScreen.mainScreen.nativeBounds.size.height;
}

+ (NSString *)screenRes
{
    return [NSString stringWithFormat:@"%ld x %ld", self.screenNativeWidth, self.screenNativeHeight];
}



@end
