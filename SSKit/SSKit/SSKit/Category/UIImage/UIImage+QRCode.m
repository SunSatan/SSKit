//
//  UIImage+QRCode.m
//  SSKit
//
//  Created by SunSatan on 2020/10/29.
//  Copyright © 2020 SunSatan. All rights reserved.
//

#import "UIImage+QRCode.h"
#import "SSImageCategory.h"

@implementation UIImage (QRCode)

+ (UIImage *)ss_QRCodeWithContent:(NSString *)content
                       QRCodeSize:(CGSize)QRCodeSize
                      centerImage:(UIImage * __nullable)centerImage
                  centerImageSize:(CGSize)centerImageSize
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

@end
