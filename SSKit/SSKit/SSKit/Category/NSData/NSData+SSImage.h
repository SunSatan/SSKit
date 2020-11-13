//
//  NSData+SSImage.h
//  SSKit
//
//  Created by SunSatan on 2020/11/6.
//  Copyright © 2020 SunSatan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^SaveComplete)(BOOL success);

@interface NSData (SSImage)
/**
 * 将图片的二进制文件（NSData）直接保存到相册。
 * @param complete 保存完成后的回调
 */
- (void)ss_saveJPGToPhotosAlbumWithComplete:(SaveComplete)complete;
/**
 * 获取二进制大小：20 KB
 */
- (NSString *)ss_length;

@end

NS_ASSUME_NONNULL_END
