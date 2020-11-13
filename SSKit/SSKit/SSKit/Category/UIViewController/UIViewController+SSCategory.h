//
//  UIViewController+SSCategory.h
//  SSKit
//
//  Created by SunSatan on 2020/9/18.
//  Copyright © 2020 SunSatan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define SSDisplayViewController UIViewController.currentDisplayViewController

@interface UIViewController (SSCategory)

@property (class, nonatomic, readonly) UIViewController *currentDisplayViewController;

#pragma mark - load ViewController

/**
 * 设置导航栏透明(包括隐藏下划线)
 */
+ (instancetype)ss_xib;
/**
 * 设置导航栏透明(包括隐藏下划线)
 */
+ (instancetype)ss_loadFromXib:(NSString *)xibName;
/**
 * 设置导航栏透明(包括隐藏下划线)
 */
+ (instancetype)ss_loadFromMainStoryboard:(NSString *)StoryboardID;
/**
 * 设置导航栏透明(包括隐藏下划线)
 */
+ (instancetype)ss_loadFromStoryboard:(NSString *)StoryboardName
                         StoryboardID:(NSString *)StoryboardID;

/**
 * 设置导航栏透明(包括隐藏下划线)
 */
- (void)ss_navigationBarTransparent;
/**
 * 设置导航栏不透明(包括显示下划线)
 */
- (void)ss_navigationBarNoTTransparent;
/**
 * 显示导航栏下划线
 */
- (void)ss_navigationBarShowUnderline;
/**
 * 隐藏导航栏下划线
 */
- (void)ss_navigationBarHiddenUnderline;
/**
 * 设置标题
 */
- (void)ss_navigationTitle:(NSString *)title;
- (void)ss_navigationTitle:(NSString *)title textColor:(UIColor * __nullable)textColor;
- (void)ss_navigationTiTle:(NSString *)title fontSize:(CGFloat)fontSize;
- (void)ss_navigationTitle:(NSString *)title textColor:(UIColor * __nullable)textColor fontSize:(CGFloat)fontSize;

- (void)ss_edgesExtendedForNone;  //
- (void)ss_navigationPopNotCover; //

- (void)ss_navigationBarImageBackButton:(NSString *)imageName;

@end

NS_ASSUME_NONNULL_END
