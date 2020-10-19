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
/// 十六进制字符串 转 十进制int
//- (NSUInteger)hexStringToInt;
/**
 * base64 编码
 */
- (NSString *)ss_base64Encode;
/**
 * base64 解码
 */
- (NSString *)ss_base64Decode;

// 字符串清除字符
- (NSString *)ss_clearAllSpace;
- (NSString *)ss_clearAllSpaceAndNewline;
- (NSString *)ss_clearSpaceAtHeadAndTail;
- (NSString *)ss_clearNewlineAtHeadAndTail;
- (NSString *)ss_clearSpaceAndNewlineAtHeadAndTail;

/**
 * 中文转拼音（系统方法）
 * @param capitalized 是否开启首字母大写
 */
- (NSString *)ss_chineseTransformPinyinWithCapitalized:(BOOL)capitalized;
/**
 * 检验是否是手机号
 */
- (BOOL)ss_validatedMobilePhone;
/**
 * 检验是否是邮箱地址
 */
- (BOOL)ss_validatedEmailAddress;

/**
 * 顺序遍历字符串每个字符
 */
- (void)ss_enumerateObjectsUsingBlock:(UsingBlock)block;
/**
 * 逆序遍历字符串每个字符
 */
- (void)ss_enumerateObjectsReverseUsingBlock:(UsingBlock)block;

/**
 * 字符串数组构建字符串
 */
+ (NSString *)ss_stringWithArray:(NSArray<NSString *> *)array;
/**
 * 字符串数组构建字符串
 * @param string 数组与数组之间的间隔字符串
 */
+ (NSString *)ss_stringWithArray:(NSArray<NSString *> *)array
                         joinded:(NSString *)string;

/**
 * 将字符串分割成单字符数组
 */
- (NSArray<NSString *> *)ss_stringCutApartToCharacter;
/**
 * 将字符串分割成单字符数组
 * @param string 分割依据字符
 */
- (NSArray<NSString *> *)ss_stringCutApartByString:(NSString *)string;

/**
 * 字符串反转
 */
- (NSString *)ss_reversal;

/**
 * RAM内存单位换算，默认保留1位小数
 * @param memorySize 内存大小，单位是B
 */
+ (NSString *)ss_memoryUnit:(unsigned long long)memorySize;
/**
 * RAM内存单位
 * @param memorySize 内存大小，单位是B
 * @param decimal 小数保留位数
 */
+ (NSString *)ss_memoryUnit:(unsigned long long)memorySize
                    decimal:(NSUInteger)decimal;

/**
 * 存储单位换算，默认保留1位小数
 * @param diskSize 存储大小，单位是B
 */
+ (NSString *)ss_diskUnit:(unsigned long long)diskSize;
/**
 * 存储单位换算
 * @param diskSize 存储大小，单位是B
 * @param decimal 小数保留位数
 */
+ (NSString *)ss_diskUnit:(unsigned long long)diskSize
                  decimal:(NSUInteger)decimal;

@end

NS_ASSUME_NONNULL_END
