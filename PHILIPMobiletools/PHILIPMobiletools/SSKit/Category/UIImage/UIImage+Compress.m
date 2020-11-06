//
//  UIImage+Compress.m
//  SSKit
//
//  Created by SunSatan on 2020/10/29.
//  Copyright © 2020 SunSatan. All rights reserved.
//

#import "UIImage+Compress.h"
#import "SSImageCategory.h"

@implementation UIImage (Compress)

#pragma mark - 图片压缩

- (NSData *)ss_imageCompressMinQuality
{
    return UIImageJPEGRepresentation(self, 0);
}

- (NSData *)ss_imageCompressQualityToMaximum:(NSUInteger)maximum
{
    CGFloat compression = 0.4;
    NSData *data = UIImageJPEGRepresentation(self, compression);
    
    if (data.length <= maximum) return data; //原大小本就小于指定大小，无需压缩
    
    NSData *dataMin = [self ss_imageCompressMinQuality];
    if (dataMin.length >= maximum) return dataMin; //压到最小仍大于指定大小，继续压缩无意义
    
    CGFloat max = 1, min = 0;  //二分法
    CGFloat ratio = 0.9;       //认为图片质量在[maximum*0.9, maximum]是合理的
    for (int i=0; i<6; i++) {  //最多二分6次，精度：1/2^6=0.016
        compression = (max + min) / 2.0;
        data = UIImageJPEGRepresentation(self, compression);
        if (data.length < maximum * ratio) {
            min = compression;
        } else if (data.length > maximum) {
            max = compression;
        } else {
            break;
        }
    }
    return data;
}

- (NSData *)ss_imageCompressSizeToMaximum:(NSUInteger)maximum
{
    NSData *data = UIImageJPEGRepresentation(self, 0);
    if (data.length <= maximum) {
        return data;
    }
    UIImage *resultImage = [self copy];
    NSUInteger lastDataLength = 0;
    while (data.length > maximum && data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio = (CGFloat) maximum / data.length;
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio)));
        UIGraphicsBeginImageContextWithOptions(size, NO, self.scale);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, 0);
    }
    return data;
}

- (NSData *)ss_imageCompressToMaximum:(NSUInteger)maximum
{
    NSData *data = [self ss_imageCompressQualityToMaximum:maximum];
    if (data.length <= maximum) {
        return data;
    }
    data = [self ss_imageCompressSizeToMaximum:maximum];
    return data;
}

#pragma mark - 缩放图片尺寸

- (UIImage *)ss_imageScale:(CGFloat)scale
{
    NSUInteger imageWidth  = self.size.width * scale;
    NSUInteger imageHeight = self.size.height * scale;
    CGSize size = CGSizeMake(imageWidth, imageHeight);
    UIGraphicsBeginImageContextWithOptions(size, NO, self.scale);
    [self drawInRect:CGRectMake(0, 0, imageWidth, imageHeight)];
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}

- (UIImage *)ss_imageScaleFillToSize:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, NO, self.scale);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}

- (UIImage *)ss_imageScaleFitToSize:(CGSize)size
{
    return [self ss_imageScale:ss_minScale(self.size, size)];
}

- (UIImage *)ss_imageBoostToSize:(CGSize)size
{
    CGFloat scale = ss_minScale(self.size, size);
    scale = MAX(self.scale, scale);
    UIGraphicsBeginImageContextWithOptions(self.size, NO, scale);
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resultImage;
}

- (UIImage *)ss_imageBoostToScale:(CGFloat)scale
{
    scale = MAX(self.scale, scale);
    UIGraphicsBeginImageContextWithOptions(self.size, NO, scale);
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resultImage;
}


@end
