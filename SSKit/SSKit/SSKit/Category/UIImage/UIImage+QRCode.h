//
//  UIImage+QRCode.h
//  SSKit
//
//  Created by 孙铭健 on 2020/10/29.
//  Copyright © 2020 孙铭健. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (QRCode)
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
+ (UIImage *)ss_QRCodeWithContent:(NSString *)content
                       QRCodeSize:(CGSize)QRCodeSize
                      centerImage:(UIImage * __nullable)centerImage
                  centerImageSize:(CGSize)centerImageSize;
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

@end

NS_ASSUME_NONNULL_END
