//
//  NSString+SSCategory.m
//  SSKit
//
//  Created by SunSatan on 2020/9/19.
//  Copyright © 2020 孙铭健. All rights reserved.
//

#import "NSString+SSCategory.h"

@implementation NSString (SSCategory)

- (NSString *)clearAllSpace
{
    NSString *temp = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    return temp;
}

- (NSString *)clearAllSpaceAndNewline
{
    NSString *temp = [self clearAllSpace];
    temp = [temp stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return temp;
}

- (NSString *)clearSpaceAtHeadAndTail
{
    NSString *temp = [self stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceCharacterSet];
    return temp;
}

- (NSString *)clearNewlineAtHeadAndTail
{
    NSString *temp = [self stringByTrimmingCharactersInSet:NSCharacterSet.newlineCharacterSet];
    return temp;
}

- (NSString *)clearSpaceAndNewlineAtHeadAndTail
{
    NSString *temp = [self stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
    return temp;
}

- (NSUInteger)hexStringToInt;
{
    unsigned int result;
    [[NSScanner scannerWithString:self] scanHexInt:&result];
    return (NSUInteger)result;
}

- (NSString *)chineseTransformPinyinWithCapitalized:(BOOL)capitalized
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

- (BOOL)validatedMobilePhone
{
    NSString *phoneRegex = @"^(0|86)?(13[0-9]|14[05679]|15[012356789]|16[2567]|17[01235678]|18[0-9]|19[189])[0-9]{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:self];
}

- (BOOL)validatedEmailAddress
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

- (NSString *)base64Encode
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSData *base64Data = [data base64EncodedDataWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSString *base64Str = [[NSString alloc] initWithData:base64Data encoding:NSUTF8StringEncoding];
    return base64Str;
}

- (NSString *)base64Decode
{
    NSData *base64Data = [[NSData alloc] initWithBase64EncodedString:self options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSString *str = [[NSString alloc] initWithData:base64Data encoding:NSUTF8StringEncoding];
    return str;
}

uint32_t ss_ipIntFromIpString(char *ipString)
{
    if (ipString == NULL || strlen(ipString) == 0) return 0;

    char x = '\0';
    int k = 0;
    uint32_t ipInt = 0;

    for (int i=0; i<strlen(ipString); i++) {
        x = ipString[i];
        if (x == '.') {
            ipInt = ipInt | k;
            ipInt = ipInt << 8;
            k = 0;
            continue;
        }
        if (x == '\0') {
            ipInt = ipInt | k;
            break;
        }
        k = (k * 10) + (x - '0');
    }
    return ipInt;
}

unsigned char * ss_ipStringFormIpInt(uint32_t ipInt)
{
    uint32_t k = 0;
    unsigned char *ipString = NULL;;
    while (ipInt > 0) {
        k = k & 255;
        ipInt = ipInt >> 8;
        
    }
    return ipString;
}


@end
