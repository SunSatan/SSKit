//
//  NSData+SSImage.m
//  SSKit
//
//  Created by 孙铭健 on 2020/11/6.
//  Copyright © 2020 孙铭健. All rights reserved.
//

#import "NSData+SSImage.h"
#import "NSString+SSCategory.h"

#import <Photos/Photos.h>

static NSString *kJpgTempPath = @"tmp/ss_temp_image.JPG";

@implementation NSData (SSImage)

- (void)ss_imageDataSaveToPhotosAlbumWithComplete:(SaveComplete)complete
{
    // 因为图片压缩后得到的 NSData 无法直接保存到手机相册
    // 但是将 NSData 渲染成 UIImage 再保存，图片质量又会变很大，这等于没压缩
    // 所以需要将图片的 NSData 先存进 Documents，进行临时中转
    // 再从 Documents 里将图片保存到相册中
    // 完成后删除 Documents 中的临时图片
    
    NSString *jpgPath = [NSHomeDirectory() stringByAppendingPathComponent:kJpgTempPath];
    [self writeToFile:jpgPath atomically:YES];
    [PHPhotoLibrary.sharedPhotoLibrary performChanges:^{
        [PHAssetChangeRequest creationRequestForAssetFromImageAtFileURL:[NSURL URLWithString:jpgPath]];
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        if ([NSFileManager.defaultManager fileExistsAtPath:jpgPath]) {
            [NSFileManager.defaultManager removeItemAtPath:jpgPath error:nil];
        }
        if (complete) {
            complete(success);
        }
    }];
}

- (NSString *)ss_length
{
    return [NSString ss_diskUnit:self.length decimal:0];
}

@end
