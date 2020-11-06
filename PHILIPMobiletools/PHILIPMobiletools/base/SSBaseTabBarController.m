//
//  SSBaseTabBarController.m
//  PHILIPMobiletools
//
//  Created by 孙铭健 on 2020/11/3.
//

#import "SSBaseTabBarController.h"
#import "SSBaseNavigationController.h"
#import "SSHomeViewController.h"
#import "SSHealthViewController.h"
#import "SSToolsViewController.h"

#import "SSKit.h"

@interface SSBaseTabBarController ()

@end

@implementation SSBaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configTabbar:SSHomeViewController.class
                 title:@"首页"
                 image:SSImageNamed(@"tabbar_home_unselect")
               seImage:SSImageNamed(@"tabbar_home_select")];
    
    [self configTabbar:SSToolsViewController.class
                 title:@"工具箱"
                 image:SSImageNamed(@"tabbar_tools_unselect")
               seImage:SSImageNamed(@"tabbar_tools_select")];
    
    [self configTabbar:SSHealthViewController.class
                 title:@"健康"
                 image:SSImageNamed(@"tabbar_health_unselect")
               seImage:SSImageNamed(@"tabbar_health_select")];
    
}

- (void)configTabbar:(Class)class
               title:(NSString *)title
               image:(UIImage *)image
             seImage:(UIImage *)seImage
{
    SSBaseNavigationController *nav = [[SSBaseNavigationController alloc]initWithRootViewController:class.new];
    nav.tabBarItem = [[UITabBarItem alloc]initWithTitle:title image:image selectedImage:seImage];
    [self addChildViewController:nav];
}

@end
