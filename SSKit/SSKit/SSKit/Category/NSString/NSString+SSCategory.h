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
- (NSString *)ss_clearAllSpace;
- (NSString *)ss_clearAllSpaceAndNewline;
- (NSString *)ss_clearSpaceAtHeadAndTail;
- (NSString *)ss_clearNewlineAtHeadAndTail;
- (NSString *)ss_clearSpaceAndNewlineAtHeadAndTail;

/// 十六进制字符串 转 十进制int
//- (NSUInteger)hexStringToInt;

/// 中文转拼音（系统方法）
/// @param capitalized 是否开启首字母大写
- (NSString *)ss_chineseTransformPinyinWithCapitalized:(BOOL)capitalized;

- (BOOL)ss_validatedMobilePhone;  /*检验手机号*/
- (BOOL)ss_validatedEmailAddress; /*检验邮箱*/

- (NSString *)ss_base64Encode; //base64 编码
- (NSString *)ss_base64Decode; //base64 解码

// 遍历字符串每个字符
- (void)ss_enumerateObjectsUsingBlock:(UsingBlock)block;
- (void)ss_enumerateObjectsReverseUsingBlock:(UsingBlock)block;

// 字符串数组构建字符串
+ (NSString *)ss_stringWithArray:(NSArray<NSString *> *)array;
+ (NSString *)ss_stringWithArray:(NSArray<NSString *> *)array joinded:(NSString *)string;

// 字符串分割成单字符
- (NSArray<NSString *> *)ss_stringCutApartToCharacter;
- (NSArray<NSString *> *)ss_stringCutApartByString:(NSString *)string;

// 反转字符串
- (NSString *)ss_reversal;

//内存单位
+ (NSString *)ss_MemoryUnit:(unsigned long long)memorySize; //默认保留两位小数
+ (NSString *)ss_MemoryUnit:(unsigned long long)memorySize decimal:(NSUInteger)decimal;

@end

NS_ASSUME_NONNULL_END
