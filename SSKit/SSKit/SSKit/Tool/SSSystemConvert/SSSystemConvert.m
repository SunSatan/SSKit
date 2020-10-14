//
//  SSSystemConvert.m
//  SSKit
//
//  Created by 孙铭健 on 2020/10/14.
//  Copyright © 2020 孙铭健. All rights reserved.
//

#import "SSSystemConvert.h"
#import "SSKit.h"

@implementation SSSystemConvert

+ (NSInteger)decimalFromBinary:(NSString *)binary haveSigned:(BOOL)haveSigned
{
    NSParameterAssert(binary);
    NSInteger decimal = 0;
    binary = [binary ss_clearAllSpaceAndNewline];
    binary = [binary ss_reversal];
    NSArray *arr = [binary ss_stringCutApartToCharacter];
    for (NSInteger i=arr.count-1; i>=0; i--) {
        NSInteger x = [arr[i] integerValue];
        if (x == 1) decimal += exp2(i);
    }
    
    return decimal;
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
