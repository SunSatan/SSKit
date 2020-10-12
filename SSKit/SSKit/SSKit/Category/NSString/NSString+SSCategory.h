//
//  NSString+SSCategory.h
//  SSKit
//
//  Created by SunSatan on 2020/9/19.
//  Copyright © 2020 孙铭健. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^UsingBlock)(NSString *character, NSUInteger index);

@interface NSString (SSCategory)

/// 字符串清除字符
- (NSString *)clearAllSpace;
- (NSString *)clearAllSpaceAndNewline;
- (NSString *)clearSpaceAtHeadAndTail;
- (NSString *)clearNewlineAtHeadAndTail;
- (NSString *)clearSpaceAndNewlineAtHeadAndTail;

/// 十六进制字符串 转 十进制int
- (NSUInteger)hexStringToInt;

/// 中文转拼音（系统方法）
/// @param capitalized 是否开启首字母大写
- (NSString *)chineseTransformPinyinWithCapitalized:(BOOL)capitalized;

- (BOOL)validatedMobilePhone;  /*检验手机号*/
- (BOOL)validatedEmailAddress; /*检验邮箱*/

- (NSString *)base64Encode; //base64 编码
- (NSString *)base64Decode; //base64 解码

//遍历字符串每个字符
- (void)enumerateObjectsUsingBlock:(UsingBlock)block;

+ (NSString *)stringWithArray:(NSArray<NSString *> *)array;
+ (NSString *)stringWithArray:(NSArray<NSString *> *)array joinded:(NSString *)string;

- (NSArray<NSString *> *)stringCutApartToCharacter;
- (NSArray<NSString *> *)stringCutApartByString:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
