//
//  UIImage+Compress.m
//  SSKit
//
//  Created by 孙铭健 on 2020/10/29.
//  Copyright © 2020 孙铭健. All rights reserved.
//

#import "UIImage+Compress.h"
#import "SSImageCategory.h"

@implementation UIImage (Compress)

#pragma mark - 图片压缩

- (NSData *)ss_imageCompressMinQuality
{
    NSData *data = UIImageJPEGRepresentation(self, 0);
    return data;
}

- (NSData *)ss_imageCompressQualityToMaximum:(NSUInteger)maximum
{
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(self, compression);
    
    if (data.length < maximum)
        return data;
    
    CGFloat max = 1, min = 0;//二分法
    CGFloat ratio = 0.8;     //认为图片质量在[maximum*0.8, maximum]是合理的
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
        UIGraphicsBeginImageContext(size);
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
    UIGraphicsBeginImageContext(CGSizeMake(imageWidth, imageHeight));
    [self drawInRect:CGRectMake(0, 0, imageWidth, imageHeight)];
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}

- (UIImage *)ss_imageScaleFillToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(CGSizeMake(size.width, size.height));
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}

- (UIImage *)ss_imageScaleFitToSize:(CGSize)size
{
    return [self ss_imageScale:SSMinScale(self.size, size)];
}

@end
