//
//  AppDelegate.m
//  PHILIPMobiletools
//
//  Created by 孙铭健 on 2020/11/3.
//

#import "AppDelegate.h"
#import "SSKit.h"
#import "SSBaseTabBarController.h"
#import "SSHealth/SSHealth.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [UIWindow ss_setRootViewController:SSBaseTabBarController.new];
    
    [SSHealth.shareHealth requestAllHealthAuthority];
     
    return YES;
}

@end
