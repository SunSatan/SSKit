//
//  UIImage+SSImageCategory.h
//  SSCategory
//
//  Created by muzhi on 2020/6/24.
//  Copyright © 2020 SunSatan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

static NSUInteger const Kb = 1000;
static NSUInteger const Mb = 1000 * Kb;

#define degreesToRadian(x) (M_PI * (x) / 180.0)
#define radianToDegrees(radian) ((radian) * 180.0)/(M_PI)

@interface UIImage (SSImageCategory)

#pragma mark - 图片生成

/**
 * 将图片转为灰度图
 */
- (UIImage *)ss_imageGrayscale;
/**
 * 根据UIView生成相应的UIImage，size一致
 * @param view 转为UIImage的view
 */
+ (UIImage *)ss_imageWithView:(UIView *)view;
/**
 * 剪裁图片到指定的rect，rect决定了剪裁图片的坐标和大小
 * @param rect 目标矩形
 */
- (UIImage *)ss_imageCropToRect:(CGRect)rect;

#pragma mark - qrcode

/**
 * 将模糊的CIImage转为高清的UIImage
 * @param image 模糊的CIImage
 * @param imageSize 高清的UIImage的大小
 */
+ (UIImage *)ss_highDefinitionUIImageFromCIImage:(CIImage *)image imageSize:(CGSize)imageSize;
/**
 * 给图片中心再添加一个图片
 * @param centerImage 中心图
 * @param baseImage 背景图
 * @param centerImageSize 中心图的大小
 */
+ (UIImage *)ss_imageAddCenterImage:(UIImage *)centerImage baseImage:(UIImage *)baseImage centerImageSize:(CGSize)centerImageSize;
/**
 * 创建一个二维码
 * @param content 二维码内容
 * @param QRCodeSize 二维码大小
 */
+ (UIImage *)ss_QRCodeWithContent:(NSString *)content QRCodeSize:(CGSize)QRCodeSize;
/**
 * 创建一个中心有logo的二维码
 * @param content 二维码内容
 * @param QRCodeSize 二维码大小
 * @param centerImage 中心logo图
 * @param centerImageSize 中心logo图的大小
 */
+ (UIImage *)ss_QRCodeWithContent:(NSString *)content QRCodeSize:(CGSize)QRCodeSize centerImage:(UIImage * __nullable)centerImage centerImageSize:(CGSize)centerImageSize;
/**
 * 创建一个条形码
 * @param content 条形码内容
 * @param barCodeSize 条形码大小
 */
+ (UIImage *)ss_barCodeWithContent:(NSString *)content barCodeSize:(CGSize)barCodeSize;
/**
 * 解码二维码内容
 */
- (NSString *)ss_QRCodeDecodingContent;

#pragma mark - 压缩图片

/**
 * 压缩图片质量到最小值。压缩图片质量的优点在于，能尽可能保留图片清晰度
 */
- (NSData *)ss_imageCompressMinQuality;
/**
 * 压缩图片质量到指定的最大值之内。
 * 但是所有图片质量压缩都有极限，根据图片不一样，压缩极限范围大致在原图质量的0.05～0.2之间
 * @param maximum 图片质量最大值，单位是b，1kb就是1000
 */
- (NSData *)ss_imageCompressQualityToMaximum:(NSUInteger)maximum;
/**
 * 通过压缩图片尺寸，使图片质量到指定的最大值。
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
/**
 * 通过比例缩放图片尺寸
 * @param scale 缩放比例
 */
- (UIImage *)ss_imageScale:(CGFloat)scale;
/**
 * 指定图片尺寸进行适应宽高比缩放
 * @param size 图片尺寸
 */
- (UIImage *)ss_imageScaleFitToSize:(CGSize)size;
/**
 * 指定图片尺寸进行填充缩放
 * @param size 图片尺寸
 */
- (UIImage *)ss_imageScaleFillToSize:(CGSize)size;

#pragma mark - 获取图片主色值

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

#pragma mark - 图片旋转

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
