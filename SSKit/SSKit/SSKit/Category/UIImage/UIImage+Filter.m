//
//  UIImage+Filter.m
//  SSKit
//
//  Created by SunSatan on 2020/10/29.
//  Copyright © 2020 SunSatan. All rights reserved.
//

#import "UIImage+Filter.h"
#import "SSImageCategory.h"

@implementation UIImage (Filter)

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

@end
