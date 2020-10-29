//
//  UIImage+ImageRotate.h
//  SSKit
//
//  Created by 孙铭健 on 2020/10/29.
//  Copyright © 2020 孙铭健. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (ImageRotate)
/**
 * 将图片绘制为默认方向
 */
- (UIImage *)ss_imageRotateToOrientationUp;
/**
 * 将图片顺时针旋转90°
 */
- (UIImage *)ss_imageRotate90Clockwise;
/**
 * 将图片逆时钟旋转90°
 */
- (UIImage *)ss_imageRotate90CounterClockwise;
/**
 * 将图片旋转180°
 */
- (UIImage *)ss_imageRotate180;
/**
 * 将图片水平翻转
 */
- (UIImage *)ss_imageFlipHorizontal;
/**
 * 将图片垂直翻转
 */
- (UIImage *)ss_imageFlipVertical;
/**
 * 将图片旋转任意角度
 * @param angle 旋转角度
 */
- (UIImage *)ss_imageRotationAngle:(CGFloat)angle;

@end

NS_ASSUME_NONNULL_END
