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

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    sleep(2);
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[ViewController new]];
    
    self.window = [UIWindow ss_setRootViewController:nav];
    
    return YES;
}

@end
