//
//  NSString+SSCategory.m
//  SSKit
//
//  Created by SunSatan on 2020/9/19.
//  Copyright © 2020 孙铭健. All rights reserved.
//

#import "NSString+SSCategory.h"
#import "SSConstant.h"

@implementation NSString (SSCategory)

- (NSString *)ss_clearAllSpace
{
    NSString *temp = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    return temp;
}

- (NSString *)ss_clearAllSpaceAndNewline
{
    NSString *temp = [self ss_clearAllSpace];
    temp = [temp stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return temp;
}

- (NSString *)ss_clearSpaceAtHeadAndTail
{
    NSString *temp = [self stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceCharacterSet];
    return temp;
}

- (NSString *)ss_clearNewlineAtHeadAndTail
{
    NSString *temp = [self stringByTrimmingCharactersInSet:NSCharacterSet.newlineCharacterSet];
    return temp;
}

- (NSString *)ss_clearSpaceAndNewlineAtHeadAndTail
{
    NSString *temp = [self stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
    return temp;
}

- (NSString *)ss_chineseTransformPinyinWithCapitalized:(BOOL)capitalized
{
    //中文转拼音，效率较低（数据量：300需要约0.2秒，1k需要约0.5秒，5k需要约2秒，1w需要约4.5秒）
    NSMutableString *name = [NSMutableString stringWithString:self];
    CFStringTransform((__bridge CFMutableStringRef)name, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)name, NULL, kCFStringTransformStripDiacritics, NO);
    NSString *pinyin = [NSString stringWithFormat:@"%@",name];
    if (capitalized) {
        pinyin = pinyin.capitalizedString;//首字母大写用于排序
    }
    return pinyin;
}

- (BOOL)ss_validatedMobilePhone
{
    NSString *phoneRegex = @"^(0|86)?(13[0-9]|14[05679]|15[012356789]|16[2567]|17[01235678]|18[0-9]|19[189])[0-9]{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:self];
}

- (BOOL)ss_validatedEmailAddress
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

- (NSString *)ss_base64Encode
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSData *base64Data = [data base64EncodedDataWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSString *base64Str = [[NSString alloc] initWithData:base64Data encoding:NSUTF8StringEncoding];
    return base64Str;
}

- (NSString *)ss_base64Decode
{
    NSData *base64Data = [[NSData alloc] initWithBase64EncodedString:self options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSString *str = [[NSString alloc] initWithData:base64Data encoding:NSUTF8StringEncoding];
    return str;
}

- (void)ss_enumerateObjectsUsingBlock:(UsingBlock)block
{
    NSString *temp = nil;
    for (NSUInteger index=0; index<self.length; index++) {
        temp = [self substringWithRange:NSMakeRange(index, 1)];
        if (block) block(temp, index);
    }
}

- (void)ss_enumerateObjectsReverseUsingBlock:(UsingBlock)block
{
    NSString *temp = nil;
    for (NSUInteger index=self.length-1; index>=0; index--) {
        temp = [self substringWithRange:NSMakeRange(index, 1)];
        if (block) block(temp, index);
    }
}

+ (NSString *)ss_stringWithArray:(NSArray<NSString *> *)array
{
    return [self ss_stringWithArray:array joinded:@""];
}

+ (NSString *)ss_stringWithArray:(NSArray<NSString *> *)array joinded:(NSString *)string
{
    NSString *str = [array componentsJoinedByString:string];
    return str;
}

- (NSArray<NSString *> *)ss_stringCutApartToCharacter
{
    return [self ss_stringCutApartByString:@""];
}

- (NSArray<NSString *> *)ss_stringCutApartByString:(NSString *)string
{
    if (!string || string.length == 0) {
        NSMutableArray *arr = [NSMutableArray array];
        for (int index=0; index<self.length; index++) {
            NSString *temp = [self substringWithRange:NSMakeRange(index, 1)];
            [arr addObject:temp];
        }
        return [NSArray arrayWithArray:arr];
    }
    
    NSArray *arr = [self componentsSeparatedByString:string];
    return arr;
}

- (NSString *)ss_reversal
{
    NSString *reversal = @"";
    NSString *temp = nil;
    for (NSInteger index=(self.length-1); index>=0; index--) {
        temp = [self substringWithRange:NSMakeRange(index, 1)];
        reversal = [reversal stringByAppendingString:temp];
    }
    return reversal;
}

+ (NSString *)ss_memoryUnit:(uint64_t)memorySize
{
    return [self ss_memoryUnit:memorySize decimal:1];
}

+ (NSString *)ss_memoryUnit:(uint64_t)memorySize decimal:(NSUInteger)decimal
{
    NSString *str = @"";
    NSString* format = [NSString stringWithFormat:@"%%.%ldlf", decimal];
    if (memorySize < SS_TB_1024 && memorySize >= SS_GB_1024) {
        format = [format stringByAppendingString:@" GB"];
        str = [NSString stringWithFormat:format, (memorySize*1.0)/SS_GB_1024];
    }
    else if (memorySize < SS_GB_1024 && memorySize >= SS_MB_1024) {
        format = [format stringByAppendingString:@" MB"];
        str = [NSString stringWithFormat:format, (memorySize*1.0)/SS_MB_1024];
    }
    else if (memorySize < SS_MB_1024 && memorySize >= SS_KB_1024) {
        format = [format stringByAppendingString:@" KB"];
        str = [NSString stringWithFormat:format, (memorySize*1.0)/SS_KB_1024];
    }
    else if (memorySize < SS_KB_1024) {
        str = [NSString stringWithFormat:@"%llu B", memorySize];
    }
    else if (memorySize > SS_TB_1024) {
        format = [format stringByAppendingString:@" TB"];
        str = [NSString stringWithFormat:format, (memorySize*1.0)/SS_TB_1024];
    }
    return str;
}

+ (NSString *)ss_diskUnit:(uint64_t)diskSize
{
    return [self ss_diskUnit:diskSize decimal:2];
}

+ (NSString *)ss_diskUnit:(uint64_t)diskSize decimal:(NSUInteger)decimal
{
    NSString *str = @"";
    NSString* format = [NSString stringWithFormat:@"%%.%ldlf", decimal];
    if (diskSize < SS_TB_1000 && diskSize >= SS_GB_1000) {
        format = [format stringByAppendingString:@" GB"];
        str = [NSString stringWithFormat:format, (diskSize*1.0)/SS_GB_1000];
    }
    else if (diskSize < SS_GB_1000 && diskSize >= SS_MB_1000) {
        format = [format stringByAppendingString:@" MB"];
        str = [NSString stringWithFormat:format, (diskSize*1.0)/SS_MB_1000];
    }
    else if (diskSize < SS_MB_1000 && diskSize >= SS_KB_1000) {
        format = [format stringByAppendingString:@" KB"];
        str = [NSString stringWithFormat:format, (diskSize*1.0)/SS_KB_1000];
    }
    else if (diskSize < SS_KB_1000) {
        str = [NSString stringWithFormat:@"%llu B", diskSize];
    }
    else if (diskSize > SS_TB_1000) {
        format = [format stringByAppendingString:@" TB"];
        str = [NSString stringWithFormat:format, (diskSize*1.0)/SS_TB_1000];
    }
    return str;
}


@end
