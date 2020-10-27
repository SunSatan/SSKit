//
//  SSSystemConvert.h
//  SSKit
//
//  Created by 孙铭健 on 2020/10/14.
//  Copyright © 2020 孙铭健. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SSSystemConvert : NSObject

/**
 二进制转十进制
 @param binary 二进制字符串
 */
+ (NSInteger)decimalFromBinary:(NSString *)binary haveSigned:(BOOL)haveSigned;

+ (NSString *)binaryFromDecimal:(NSInteger)decimal haveSigned:(BOOL)haveSigned;

/// 十六进制字符串 转 十进制int
//- (NSUInteger)hexStringToInt;

@end

NS_ASSUME_NONNULL_END
