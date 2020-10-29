//
//  UIImage+MostColor.m
//  SSKit
//
//  Created by 孙铭健 on 2020/10/29.
//  Copyright © 2020 孙铭健. All rights reserved.
//

#import "UIImage+MostColor.h"
#import "SSImageCategory.h"

@implementation UIImage (MostColor)

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

@end
