//
//  UIImage+Splicing.h
//  SSKit
//
//  Created by 孙铭健 on 2020/10/29.
//  Copyright © 2020 孙铭健. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Splicing)

/**
 * 剪裁图片到指定的rect，结果图片的默认分辨率为1080p，比例默认为原图的比例
 * @param rect 目标矩形，决定了剪裁图片的坐标和大小
 */
- (UIImage *)ss_imageCropToRect:(CGRect)rect;
/**
 * 剪裁图片到指定的rect，图片比例可以根据@1x、@2x、@3x得到
 * @param rect 目标矩形，决定了剪裁图片的坐标和大小
 * @param widthScale  原图宽的比例，没有特殊需求传入原图的scale即可
 * @param heightScale 原图高的比例，没有特殊需求传入原图的scale即可
 * @param resultImageSize 结果图片的分辨率
 */
- (UIImage *)ss_imageCropToRect:(CGRect)rect
                     widthScale:(CGFloat)widthScale
                    heightScale:(CGFloat)heightScale
                resultImageSize:(CGSize)resultImageSize;
/**
 * 将一张图片分割成N行M列
 * @param row 几排、行
 * @param column 几列
 * @param resultImageSize 结果图片的分辨率
 */
- (NSArray<UIImage *> *)ss_imageCutApartForRow:(NSUInteger)row
                                        column:(NSUInteger)column
                               resultImageSize:(CGSize)resultImageSize;
/**
 * 将一张图片分割成N行M列的正方形
 * @param row 几排、行
 * @param column 几列
 * @param resultImageSize 结果图片的分辨率
 */
- (NSArray<UIImage *> *)ss_imageCutApartToSquareForRow:(NSUInteger)row
                                                column:(NSUInteger)column
                                       resultImageSize:(CGSize)resultImageSize;

@end

NS_ASSUME_NONNULL_END
