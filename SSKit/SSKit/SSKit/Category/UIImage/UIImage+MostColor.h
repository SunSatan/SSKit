//
//  UIImage+MostColor.h
//  SSKit
//
//  Created by SunSatan on 2020/10/29.
//  Copyright © 2020 SunSatan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (MostColor)
/**
 * 获取图片最多的色值
 */
- (UIColor *)ss_iamgeMostColor;
/**
 * 获取图片最多的色值，去除透明色
 */
- (UIColor *)ss_iamgeMostColorExcludeTranslucent;
/**
 * 获取图片最多的色值，去除白色和透明色
 */
- (UIColor *)ss_iamgeMostColorExcludeWhiteAndTranslucent;
/**
 * 获取图片最多的色值，可以去除指定颜色
 * @param color 去除的颜色
 */
- (UIColor *)ss_iamgeMostColorExcludeColor:(UIColor * __nullable)color;
/**
 * 获取图片最多的色值，可以去除指定颜色
 * @param colors 去除的颜色数组
 */
- (UIColor *)ss_iamgeMostColorExcludeColors:(NSArray<UIColor *> * __nullable)colors;

@end

NS_ASSUME_NONNULL_END
