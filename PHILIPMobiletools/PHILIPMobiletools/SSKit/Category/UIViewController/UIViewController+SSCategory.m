//
//  UIViewController+SSCategory.m
//  SSKit
//
//  Created by SunSatan on 2020/9/18.
//  Copyright © 2020 SunSatan. All rights reserved.
//

#import "UIViewController+SSCategory.h"

@implementation UIViewController (SSCategory)

#pragma mark - navigation Transparent

- (void)ss_navigationBarTransparent;
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self ss_navigationBarHiddenUnderline];
}

- (void)ss_navigationBarNoTTransparent
{
    //导航栏的背景图和下划线都置空，就会回到默认的设置了
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self ss_navigationBarShowUnderline];
}

- (void)ss_navigationBarHiddenUnderline
{
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)ss_navigationBarShowUnderline
{
    [self.navigationController.navigationBar setShadowImage:nil];
}

#pragma mark - navigation title

- (void)ss_navigationTitle:(NSString *)title textColor:(UIColor *)textColor fontSize:(CGFloat)fontSize
{
    UILabel *titleLabel = [[UILabel alloc] init];
    if (fontSize > 0) {
        titleLabel.font = [UIFont boldSystemFontOfSize:fontSize];
    }
    if (textColor) {
        titleLabel.textColor = textColor;
    }
    
    titleLabel.text = title;
    self.navigationItem.titleView = titleLabel;
}

- (void)ss_navigationTitle:(NSString *)title
{
    [self ss_navigationTitle:title textColor:nil fontSize:17];
}

- (void)ss_navigationTitle:(NSString *)title textColor:(UIColor *)textColor
{
    [self ss_navigationTitle:title textColor:textColor fontSize:17];
}

- (void)ss_navigationTiTle:(NSString *)title fontSize:(CGFloat)fontSize
{
    [self ss_navigationTitle:title textColor:nil fontSize:fontSize];
}

#pragma mark - navigation push pop

- (void)ss_navigationAnimatedPushViewController:(UIViewController *)vc
{
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)ss_navigationNoAnimatedPushViewController:(UIViewController *)vc
{
    [self.navigationController pushViewController:vc animated:NO];
}

- (void)ss_navigationAnimatedPopViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)ss_navigationNoAnimatedPopViewController
{
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark -

- (void)ss_edgesExtendedForNone
{
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

#pragma mark - 

- (void)ss_navigationPopNotCover
{
    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
}

#pragma mark - navigation BarButtonItem

- (void)ss_navigationBarImageBackButton:(NSString *)imageName
{
    NSParameterAssert(imageName);
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.contentMode = UIViewContentModeScaleAspectFit;
    backBtn.frame = CGRectMake(0, 0, 0, 0);
    [backBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(ss_navigationAnimatedPopViewController) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
}

#pragma mark - load ViewController

+ (instancetype)ss_loadFromMainStoryboard:(NSString *)StoryboardID
{
    return [self ss_loadFromStoryboard:@"Main" StoryboardID:StoryboardID];
}

+ (instancetype)ss_loadFromStoryboard:(NSString *)StoryboardName
                         StoryboardID:(NSString *)StoryboardID
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:StoryboardName bundle:nil];
    return [storyboard instantiateViewControllerWithIdentifier:StoryboardID];
}

+ (instancetype)ss_xib
{
    return [self ss_loadFromXib:NSStringFromClass(self.class)];
}

+ (instancetype)ss_loadFromXib:(NSString *)xibName
{
    return [[self.class alloc] initWithNibName:xibName bundle:nil];
}

#pragma mark - Current Display ViewController

+ (UIViewController *)currentDisplayViewController
{
    UIViewController *rootVC = UIApplication.sharedApplication.keyWindow.rootViewController;
    UIViewController *currentShowVC = [self findCurrentDisplayViewController:rootVC];
    return currentShowVC;
}

/** 递归查找当前显示的VC*/
+ (UIViewController *)findCurrentDisplayViewController:(UIViewController *)fromVC
{
    if ([fromVC isKindOfClass:UINavigationController.class]) {
        return [self findCurrentDisplayViewController:[((UINavigationController *)fromVC) visibleViewController]];
    }
    else if ([fromVC isKindOfClass:UITabBarController.class]) {
        return [self findCurrentDisplayViewController:((UITabBarController *)fromVC).selectedViewController];
    }
    else {
        if (fromVC.presentedViewController) {
            return [self findCurrentDisplayViewController:fromVC.presentedViewController];
        }
        else {
            return fromVC;
        }
    }
}

@end
