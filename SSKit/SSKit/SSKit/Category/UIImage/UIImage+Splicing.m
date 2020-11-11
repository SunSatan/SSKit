//
//  UIImage+Splicing.m
//  SSKit
//
//  Created by SunSatan on 2020/10/29.
//  Copyright © 2020 SunSatan. All rights reserved.
//

#import "UIImage+Splicing.h"
#import "SSImageCategory.h"

@implementation UIImage (Splicing)

- (UIImage *)ss_imageCropToRect:(CGRect)rect
{
    return [self ss_imageCropToRect:rect widthScale:self.scale heightScale:self.scale resultImageSize:SS_1080P];
}

- (UIImage *)ss_imageCropToRect:(CGRect)rect
                     widthScale:(CGFloat)widthScale
                    heightScale:(CGFloat)heightScale
                resultImageSize:(CGSize)resultImageSize
{
    UIImage *image = self.copy;
    CGFloat scale = ss_minScale(rect.size, resultImageSize);
    CGRect drawRect = CGRectMake(-rect.origin.x, -rect.origin.y,
                                 rect.size.width  * widthScale,
                                 rect.size.height * heightScale);
    
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, CGRectMake(0, 0, rect.size.width, rect.size.height));
    [image drawInRect:drawRect];
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resultImage;
}



- (NSArray<UIImage *> *)ss_imageCutApartToSquareForRow:(NSUInteger)row
                                                column:(NSUInteger)column
                                       resultImageSize:(CGSize)resultImageSize
{
    UIImage *temp = self.copy;
    
    CGFloat side = MIN(self.size.width, self.size.height);
    return [temp ss_imageCutApartForRow:row column:column resultImageSize:resultImageSize];
}

- (NSArray<UIImage *> *)ss_imageCutApartForRow:(NSUInteger)row
                                        column:(NSUInteger)column
                               resultImageSize:(CGSize)resultImageSize
{
    NSMutableArray *mutaArr = NSMutableArray.array;
    
    CGFloat width = self.size.width / column;
    CGFloat height = self.size.height / row;
    
    for (NSInteger i=0; i<row; i++) {
        for (NSInteger j=0; j<column; j++) {
            CGFloat x = j * width;
            CGFloat y = i * height;
            CGRect rect = CGRectMake(x, y, width, height);
            UIImage *itemImage = [self ss_imageCropToRect:rect
                                                widthScale:column
                                               heightScale:row
                                           resultImageSize:SS_1080P];
            [mutaArr addObject:itemImage];
        }
    }
    return [NSArray arrayWithArray:mutaArr];
}

@end
