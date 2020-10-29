//
//  UIImage+Filter.h
//  SSKit
//
//  Created by 孙铭健 on 2020/10/29.
//  Copyright © 2020 孙铭健. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Filter)
/**
 * 将图片转为灰度图
 */
- (UIImage *)ss_imageGrayscale;

@end

NS_ASSUME_NONNULL_END
