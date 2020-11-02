//
//  AppDelegate.m
//  SSKit
//
//  Created by SunSatan on 2020/9/17.
//  Copyright © 2020 SunSatan. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "SSKit.h"
#import "XMLReader.h"


@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    sleep(2);
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[ViewController new]];
    
    self.window = [UIWindow ss_setRootViewController:nav];
    
    return YES;
}

 - (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
{
    NSString *path = url.relativeString;
    path = [path stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@", path);
    path = [[NSBundle mainBundle] pathForResource:@"log" ofType:@"ips"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSString *str = [NSString.alloc initWithData:data encoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSDictionary *dic = [XMLReader dictionaryForXMLData:data options:XMLReaderOptionsProcessNamespaces error:&error];
    NSLog(@"%@", dic);
    
    return YES;
}

@end
