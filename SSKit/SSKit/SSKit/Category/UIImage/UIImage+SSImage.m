//
//  UIImage+SSImage.m
//  SSKit
//
//  Created by SunSatan on 2020/10/29.
//  Copyright © 2020 SunSatan. All rights reserved.
//

#import "UIImage+SSImage.h"

#import "SSImageCategory.h"
#import "SSDataCategory.h"

@implementation UIImage (SSImage)

CGFloat ss_minScale(CGSize size, CGSize toSize)
{
    CGFloat scaleHeight = toSize.height / size.height;
    CGFloat scaleWidth  = toSize.width  / size.width;
    CGFloat scale = MIN(scaleHeight, scaleWidth);
    return scale;
}

#pragma mark - 图片保存

+ (void)ss_saveDataToPhotosAlbum:(NSData *)data complete:(SaveComplete)complete
{
    [data ss_saveJPGToPhotosAlbumWithComplete:complete];
}

- (void)ss_saveToPhotosAlbumWithComplete:(SaveComplete)complete
{
    UIImageWriteToSavedPhotosAlbum(self, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void * _Nullable)(complete));
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    SaveComplete complete = CFBridgingRelease(contextInfo);
    if (complete) complete(!error);
}

#pragma mark - 图片生成

+ (UIImage *)ss_imageFormView:(UIView *)view
{
    if (!view) return nil;
    CGSize size = CGSizeZero;
    if ([view isKindOfClass:UIScrollView.class]) {
        UIScrollView *scrollView = (UIScrollView *)view;
        size = scrollView.contentSize;
    }
    else {
        size = view.bounds.size;
    }
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, UIImage.new.scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)ss_highDefinitionUIImageFromCIImage:(CIImage *)image imageSize:(CGSize)imageSize
{
    if (!image) return nil;
    
    CGRect extent = CGRectIntegral(image.extent);// 将图片的rect展开到包含其整数原点和大小。
    CGFloat scale = ss_minScale(extent.size, imageSize);// 缩放比例
    //宽高缩放
    CGFloat width  = CGRectGetWidth(extent) * scale;
    CGFloat height = CGRectGetHeight(extent) * scale;
    //创建灰度色彩空间，各种设备对待颜色的方式都不同，颜色必须有一个相关的色彩空间，来解释图像上下的相关颜色值
    CGColorSpaceRef colorSpaceGray = CGColorSpaceCreateDeviceGray();
    /*创建位图上下文。参数1:是渲染绘制的内存地址，一般为不用为nil。参数2、3:宽高。参数4:像素的每个分量的位数。参数5:每一行像素字节数。参数6:上下使用的颜色空间，即灰度色彩空间。参数7:包含透明通道。*/
    CGContextRef bitmapContext = CGBitmapContextCreate(nil, width, height, 8, 0, colorSpaceGray, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapContext, kCGInterpolationNone);
    CGContextScaleCTM(bitmapContext, scale, scale);
    CGContextDrawImage(bitmapContext, extent, bitmapImage);
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapContext);
    UIImage *highDefinitionImage = [UIImage imageWithCGImage:scaledImage];
    //释放
    CGColorSpaceRelease(colorSpaceGray);
    CGContextRelease(bitmapContext);
    CGImageRelease(bitmapImage);
    CGImageRelease(scaledImage);
    return highDefinitionImage;
}

+ (UIImage *)ss_addCenterImage:(UIImage *)centerImage
                     baseImage:(UIImage *)baseImage
               centerImageSize:(CGSize)centerImageSize
{
    if (!centerImage || !baseImage) return nil;
    
    CGSize imageSize = baseImage.size; //底图大小
    UIGraphicsBeginImageContext(imageSize);//开始绘制
    [baseImage drawInRect:CGRectMake(0, 0, imageSize.width, imageSize.height)];//绘制背景图
    CGContextRef context = UIGraphicsGetCurrentContext();//获得图形上下文
    CGContextDrawPath(context, kCGPathStroke);//绘制路径
    //绘制的中心图的区域
    CGContextClip(context);
    CGRect centerImageRect = CGRectMake((imageSize.width- centerImageSize.width)/2, (imageSize.height - centerImageSize.height)/2, centerImageSize.width, centerImageSize.height);
    [centerImage drawInRect:centerImageRect];//在背景图上绘制中心图
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();//获取当前绘制的新图形
    UIGraphicsEndImageContext();//结束绘制
    return image;
}

@end
