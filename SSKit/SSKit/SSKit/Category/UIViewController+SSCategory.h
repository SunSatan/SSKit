//
//  UIViewController+SSCategory.h
//  SSKit
//
//  Created by 孙铭健 on 2020/9/18.
//  Copyright © 2020 孙铭健. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define RootViewController [UIApplication sharedApplication].keyWindow.rootViewController

@interface UIViewController (SSCategory)
/**
 * 设置导航栏透明(包括隐藏下划线)
 */
- (void)ss_navigationBarTransparent;
/**
 * 设置导航栏不透明(包括显示下划线)
 */
- (void)ss_navigationBarNoTTransparent;
/**
 * 隐藏导航栏下划线
*/
- (void)ss_navigationBarShowUnderline;
/**
 * 显示导航栏下划线
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

- (void)ss_navigationBarCustomBackButton:(NSString *)imageName;

@end

NS_ASSUME_NONNULL_END
