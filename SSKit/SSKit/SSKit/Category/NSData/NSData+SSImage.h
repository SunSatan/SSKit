//
//  NSData+SSImage.h
//  SSKit
//
//  Created by 孙铭健 on 2020/11/6.
//  Copyright © 2020 孙铭健. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^SaveComplete)(BOOL success);

@interface NSData (SSImage)
/**
 * 将图片的二进制文件（NSData）直接保存到相册。
 * @param complete 保存完成后的回调
 */
- (void)ss_imageDataSaveToPhotosAlbumWithComplete:(SaveComplete)complete;

@end

NS_ASSUME_NONNULL_END
