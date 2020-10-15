//
//  UIImage+SSImageCategory.m
//  SSCategory
//
//  Created by muzhi on 2020/6/24.
//  Copyright © 2020 SunSatan. All rights reserved.
//

#import "UIImage+SSImageCategory.h"

#import <CoreImage/CoreImage.h>

#import "SSConstant.h"


@implementation UIImage (SSImageCategory)

#pragma mark - 二维码QRCode

+ (UIImage *)ss_highDefinitionUIImageFromCIImage:(CIImage *)image imageSize:(CGSize)imageSize
{
    CGRect extent = CGRectIntegral(image.extent);//将图片的rect展开到包含其整数原点和大小。
    CGFloat scale = MIN(imageSize.width/CGRectGetWidth(extent), imageSize.height/CGRectGetHeight(extent));//缩放比例
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

+ (UIImage *)ss_imageAddCenterImage:(UIImage *)centerImage baseImage:(UIImage *)baseImage centerImageSize:(CGSize)centerImageSize
{
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

+ (UIImage *)ss_QRCodeWithContent:(NSString *)content QRCodeSize:(CGSize)QRCodeSize centerImage:(UIImage * __nullable)centerImage centerImageSize:(CGSize)centerImageSize
{
    if (!content || content.length == 0) {
        return nil;
    }
    NSData *inputData = [content dataUsingEncoding:NSUTF8StringEncoding];//内容转为数据
    //创建一个二维码滤镜实例(CIFilter)
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setValue:inputData forKey:@"inputMessage"];//给滤镜添加数据
    [filter setValue:@"H" forKey:@"inputCorrectionLevel"];//设置高容错率
    
    CIImage *image = [filter outputImage];//生成二维码
    UIImage *qrCode = [self ss_highDefinitionUIImageFromCIImage:image imageSize:QRCodeSize];//转为高清图
    if (centerImage) {//添加中心logo
        qrCode = [self ss_imageAddCenterImage:centerImage baseImage:qrCode centerImageSize:centerImageSize];
    }
    return qrCode;
}

+ (UIImage *)ss_QRCodeWithContent:(NSString *)content QRCodeSize:(CGSize)QRCodeSize
{
    return [self ss_QRCodeWithContent:content QRCodeSize:QRCodeSize centerImage:nil centerImageSize:CGSizeMake(0, 0)];
}

+ (UIImage *)ss_barCodeWithContent:(NSString *)content barCodeSize:(CGSize)barCodeSize
{
    if (!content || content.length == 0) {
        return nil;
    }
    NSData *inputData = [content dataUsingEncoding:NSUTF8StringEncoding];//内容转为数据
    //创建一个二维码滤镜实例(CIFilter)
    CIFilter *filter = [CIFilter filterWithName:@"CICode128BarcodeGenerator"];
    [filter setValue:inputData forKey:@"inputMessage"];//给滤镜添加数据
    [filter setValue:@(0) forKey:@"inputQuietSpace"];//设置条形码上下左右margin值
    [filter setValue:@(barCodeSize.height) forKey:@"inputBarcodeHeight"];//设置条形码高度
    CIImage *image = [filter outputImage];//生成二维码
    UIImage *barCode = [self ss_highDefinitionUIImageFromCIImage:image imageSize:barCodeSize];//转为高清图
    return barCode;
}

- (NSString *)ss_QRCodeDecodingContent
{
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{CIDetectorAccuracy:CIDetectorAccuracyHigh}];
    CIImage *image = [CIImage imageWithCGImage:self.CGImage];
    NSArray *features = [detector featuresInImage:image];
    NSString *content = nil;
    for (CIQRCodeFeature *feature in features) {
        content = feature.messageString;
    }
    return content;
}

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
    CGFloat scaleHeight = size.height / self.size.height;
    CGFloat scaleWidth  = size.width  / self.size.width;
    CGFloat scale = MIN(scaleHeight, scaleWidth);
    return [self ss_imageScale:scale];
}

#pragma mark - 获取图片最多的色值

- (UIColor *)ss_iamgeMostColor
{
    return [self ss_iamgeMostColorExcludeColors:nil];
}

- (UIColor *)ss_iamgeMostColorExcludeTranslucent
{
    return [self ss_iamgeMostColorExcludeColors:@[[UIColor clearColor]]];
}

- (UIColor *)ss_iamgeMostColorExcludeWhiteAndTranslucent
{
    return [self ss_iamgeMostColorExcludeColors:@[[UIColor clearColor], [UIColor whiteColor]]];
}

- (UIColor *)ss_iamgeMostColorExcludeColor:(UIColor * __nullable)color
{
    return [self ss_iamgeMostColorExcludeColors:@[color]];
}

- (UIColor *)ss_iamgeMostColorExcludeColors:(NSArray<UIColor *> * __nullable)colors
{
    //按比例限制图片大小，以6s的R9处理器:
    //360p耗时可以在0.5秒以内，720p在3秒以内，1080p在5秒以内
    CGFloat scaleHeight = 360 / self.size.height;
    CGFloat scaleWidth  = 360 / self.size.width;
    CGFloat scale = MIN(scaleHeight, scaleWidth);
    CGSize thumbSize = CGSizeMake(self.size.width * scale, self.size.height * scale);
    
    int bitmapInfo = kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, thumbSize.width, thumbSize.height, 8, 0, colorSpace, bitmapInfo);
    CGRect drawRect = CGRectMake(0, 0, thumbSize.width, thumbSize.height);
    CGContextDrawImage(context, drawRect, self.CGImage);
    
    unsigned char *bitmap = CGBitmapContextGetData(context);
    if (bitmap == NULL) return nil;
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    int mostRed = 0, mostGreen = 0, mostBlue = 0, mostAlpha = 0, count = 0;
    for (int x = 0; x < thumbSize.width * thumbSize.height; x++) {
        
        int offset = 4 * x; //4个为一个rgba元组
        int red    = bitmap[offset];
        int green  = bitmap[offset+1];
        int blue   = bitmap[offset+2];
        int alpha  = bitmap[offset+3];
        
        //去除颜色
        BOOL isNext = NO;
        for (UIColor *color in colors) {
            CGFloat exRed, exGreen, exBlue, exAlpha;
            [color getRed:&exRed green:&exGreen blue:&exBlue alpha:&exAlpha];
            if (red   == (int)(exRed   * 255) &&
                green == (int)(exGreen * 255) &&
                blue  == (int)(exBlue  * 255) &&
                alpha == (int)(exAlpha * 255)) {
                isNext = YES;
                break;
            }
        }
        if (isNext) continue;
        
        //通过key和value进行计数，一次遍历就拿到出现次数最多的色值
        NSString *key = [NSString stringWithFormat:@"(%d,%d,%d,%d)", red,green,blue,alpha];
        int num = [dict[key] intValue];
        if (num) {
            dict[key] = @(++num);
        } else {
            dict[key] = @(1);
        }
        
        if (num > count) {
            count     = num;
            mostRed   = red;
            mostGreen = green;
            mostBlue  = blue;
            mostAlpha = alpha;
        }
    }
    
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    return [UIColor colorWithRed:mostRed/255.0f green:mostGreen/255.0f blue:mostBlue/255.0f alpha:mostAlpha/255.0f];
}

- (UIImage *)ss_imageGrayscale
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate(NULL, self.size.width, self.size.height, 8, 0, colorSpace, kCGImageAlphaNone);
    if (context == NULL || !context || context == nil) return nil;
    
    CGContextDrawImage(context, CGRectMake(0, 0, self.size.width, self.size.height), self.CGImage);
    CGImageRef grayscale = CGBitmapContextCreateImage(context);
    UIImage *grayscaleImage = [UIImage imageWithCGImage:grayscale];
    
    CGImageRelease(grayscale);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    return grayscaleImage;
}

+ (UIImage *)ss_imageWithView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)ss_imageCropToRect:(CGRect)rect
{
    CGRect drawRect = CGRectMake(-rect.origin.x, -rect.origin.y, rect.size.width * self.scale, rect.size.height * self.scale);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, CGRectMake(0, 0, rect.size.width, rect.size.height));
    [self drawInRect:drawRect];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage*)ss_imageRotateToOrientationUp
{
    CGSize size = CGSizeMake(self.size.width * self.scale, self.size.height * self.scale);
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, CGRectMake(0, 0, size.width, size.height));

    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}

- (UIImage *)ss_imageRotate90Clockwise
{
    UIImage *image = nil;
    switch (self.imageOrientation) {
        case UIImageOrientationUp:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationRight];
            break;
        }
        case UIImageOrientationDown:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationLeft];
            break;
        }
        case UIImageOrientationLeft:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationUp];
            break;
        }
        case UIImageOrientationRight:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationDown];
            break;
        }
        case UIImageOrientationUpMirrored:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationLeftMirrored];
            break;
        }
        case UIImageOrientationDownMirrored:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationRightMirrored];
            break;
        }
        case UIImageOrientationLeftMirrored:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationDownMirrored];
            break;
        }
        case UIImageOrientationRightMirrored:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationUpMirrored];
            break;
        }
    }
    return image;
}

- (UIImage *)ss_imageRotate90CounterClockwise
{
    UIImage *image = nil;
    switch (self.imageOrientation) {
        case UIImageOrientationUp:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationLeft];
            break;
        }
        case UIImageOrientationDown:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationRight];
            break;
        }
        case UIImageOrientationLeft:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationDown];
            break;
        }
        case UIImageOrientationRight:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationUp];
            break;
        }
        case UIImageOrientationUpMirrored:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationRightMirrored];
            break;
        }
        case UIImageOrientationDownMirrored:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationLeftMirrored];
            break;
        }
        case UIImageOrientationLeftMirrored:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationUpMirrored];
            break;
        }
        case UIImageOrientationRightMirrored:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationDownMirrored];
            break;
        }
    }
    return image;
}

- (UIImage *)ss_imageRotate180
{
    UIImage *image = nil;
    switch (self.imageOrientation) {
        case UIImageOrientationUp:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationDown];
            break;
        }
        case UIImageOrientationDown:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationUp];
            break;
        }
        case UIImageOrientationLeft:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationRight];
            break;
        }
        case UIImageOrientationRight:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationLeft];
            break;
        }
        case UIImageOrientationUpMirrored:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationDownMirrored];
            break;
        }
        case UIImageOrientationDownMirrored:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationUpMirrored];
            break;
        }
        case UIImageOrientationLeftMirrored:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationRightMirrored];
            break;
        }
        case UIImageOrientationRightMirrored:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationLeftMirrored];
            break;
        }
    }
    return image;
}

- (UIImage*)ss_imageFlipHorizontal
{
    UIImage *image = nil;
    switch (self.imageOrientation) {
        case UIImageOrientationUp:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationUpMirrored];
            break;
        }
        case UIImageOrientationDown:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationDownMirrored];
            break;
        }
        case UIImageOrientationLeft:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationRightMirrored];
            break;
        }
        case UIImageOrientationRight:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationLeftMirrored];
            break;
        }
        case UIImageOrientationUpMirrored:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationUp];
            break;
        }
        case UIImageOrientationDownMirrored:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationDown];
            break;
        }
        case UIImageOrientationLeftMirrored:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationRight];
            break;
        }
        case UIImageOrientationRightMirrored:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationLeft];
            break;
        }
    }
    return image;
}

- (UIImage*)ss_imageFlipVertical
{
    UIImage *image = nil;
    switch (self.imageOrientation) {
        case UIImageOrientationUp:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationDownMirrored];
            break;
        }
        case UIImageOrientationDown:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationUpMirrored];
            break;
        }
        case UIImageOrientationLeft:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationLeftMirrored];
            break;
        }
        case UIImageOrientationRight:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationRightMirrored];
            break;
        }
        case UIImageOrientationUpMirrored:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationDown];
            break;
        }
        case UIImageOrientationDownMirrored:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationUp];
            break;
        }
        case UIImageOrientationLeftMirrored:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationLeft];
            break;
        }
        case UIImageOrientationRightMirrored:
        {
            image = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationRight];
            break;
        }
    }
    return image;
}

- (UIImage *)ss_imageRotationAngle:(CGFloat)angle
{
    CGSize imgSize = CGSizeMake(self.size.width * self.scale, self.size.height * self.scale);
    CGRect rect = CGRectMake(0, 0, imgSize.width, imgSize.height);
    //旋转后的矩形大小，防止之后旋转时超出部分被裁剪
    rect = CGRectApplyAffineTransform(rect, CGAffineTransformMakeRotation(angle * M_PI / 180.0));
    //画图
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //
    CGContextTranslateCTM(context, rect.size.width/2, rect.size.height/2);
    //
    CGContextRotateCTM(context, angle*M_PI/180.0);
    //
//    CGContextTranslateCTM(context, -rect.size.width/2, -rect.size.height/2);
    
    [self drawInRect:CGRectMake(0, 0, rect.size.width, rect.size.height)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
