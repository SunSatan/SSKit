//
//  UIImage+Compress.h
//  SSKit
//
//  Created by 孙铭健 on 2020/10/29.
//  Copyright © 2020 孙铭健. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Compress)

#pragma mark - 图片压缩

/**
 * 压缩图片质量到最小值，有损。
 */
- (NSData *)ss_imageCompressMinQuality;
/**
 * 压缩图片质量到指定的最大值之内，有损。
 * 但是所有图片质量压缩都有极限，根据图片不一样，压缩极限范围也不一样，图片越清晰，压缩极限范围也越大。
 * @param maximum 图片质量最大值，单位是B，1KB就是1000
 */
- (NSData *)ss_imageCompressQualityToMaximum:(NSUInteger)maximum;
/**
 * 通过压缩图片尺寸，使图片质量到指定的最大值，有损。
 * 压缩图片尺寸会导致图片模糊，在图片压缩到最小质量仍不满足时才推荐使用。
 * @param maximum 图片质量最大值
 */
- (NSData *)ss_imageCompressSizeToMaximum:(NSUInteger)maximum;
/**
 * 推荐：混合方式压缩图片质量到指定的最大值之内。
 * 先压缩图片质量，再压缩图片尺寸。
 * @param maximum 图片质量最大值
 */
- (NSData *)ss_imageCompressToMaximum:(NSUInteger)maximum;

#pragma mark - 缩放图片尺寸

/**
 * 通过比例缩放图片尺寸
 * @param scale 缩放比例
 */
- (UIImage *)ss_imageScale:(CGFloat)scale;
/**
 * 指定图片尺寸进行适应宽高比缩放
 * @param size 指定尺寸
 */
- (UIImage *)ss_imageScaleFitToSize:(CGSize)size;
/**
 * 指定图片尺寸进行填充缩放
 * @param size 指定尺寸
 */
- (UIImage *)ss_imageScaleFillToSize:(CGSize)size;

@end

NS_ASSUME_NONNULL_END
