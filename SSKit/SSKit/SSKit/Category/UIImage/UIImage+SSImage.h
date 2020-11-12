//
//  UIImage+SSImage.h
//  SSKit
//
//  Created by SunSatan on 2020/10/29.
//  Copyright © 2020 SunSatan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^SaveComplete)(BOOL success);

@interface UIImage (SSImage)
/**
 * 获取 size 变成 toSize 中，toSize/size 中宽和高之间的最小比例
 * @param size 原 size
 * @param toSize 将要变成的size
 */
CGFloat ss_minScale(CGSize size, CGSize toSize);
/**
 * 将图片保存到相册
 * @param complete 完成后回调
 */
- (void)ss_saveToPhotosAlbumWithComplete:(SaveComplete)complete;
/**
 * 将图片的二进制数据保存到相册
 * @param data 图片的二进制数据
 * @param complete 完成后回调
 */
+ (void)ss_saveDataToPhotosAlbum:(NSData *)data
                        complete:(SaveComplete)complete;
/**
 * 根据UIView生成相应的UIImage，size 一致
 * @param view 转为UIImage的view
 */
+ (UIImage *)ss_imageFormView:(UIView *)view;
/**
 * 将模糊的 CIImage 转为高清的 UIImage
 * @param image 模糊的 CIImage
 * @param imageSize 高清的 UIImage 的大小
 */
+ (UIImage *)ss_highDefinitionUIImageFromCIImage:(CIImage *)image
                                       imageSize:(CGSize)imageSize;
/**
 * 给图片中心再添加一个图片
 * @param centerImage 中心图
 * @param baseImage 背景图
 * @param centerImageSize 中心图的大小
 */
+ (UIImage *)ss_addCenterImage:(UIImage *)centerImage
                     baseImage:(UIImage *)baseImage
               centerImageSize:(CGSize)centerImageSize;

@end

NS_ASSUME_NONNULL_END
