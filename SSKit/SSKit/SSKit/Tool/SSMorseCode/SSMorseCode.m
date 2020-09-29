//
//  SSMorseCode.m
//  SSKit
//
//  Created by 孙铭健 on 2020/9/29.
//  Copyright © 2020 孙铭健. All rights reserved.
//

#import "SSMorseCode.h"
#import "NSString+SSCategory.h"

@interface SSMorseCode ()

@end

@implementation SSMorseCode

+ (NSString *)morseCode:(NSString *)string
{
    NSString *result = @"";
    NSArray *stringArray = [string stringCutApartToCharacter];
    for (NSString *key in stringArray) {
        NSArray *morseCodeArray = self.morseCodeTable[key];
        NSString *morseCode = morseCodeArray ? [NSString stringWithArray:morseCodeArray] : key;
        result = [result stringByAppendingString:morseCode];
    }
    return result;
}

+ (NSDictionary *)morseCodeTable
{
    static NSDictionary *_morseCodeTable;
    if (!_morseCodeTable) {
        _morseCodeTable = @{@"A":@[SSMorseCodeDit,SSMorseCodeDah],
                            @"B":@[SSMorseCodeDah,SSMorseCodeDit,SSMorseCodeDit,SSMorseCodeDit],
                            @"C":@[SSMorseCodeDah,SSMorseCodeDit,SSMorseCodeDah,SSMorseCodeDit],
                            @"D":@[SSMorseCodeDit,SSMorseCodeDit,SSMorseCodeDit],
                            @"E":@[SSMorseCodeDit],
                            @"F":@[SSMorseCodeDit,SSMorseCodeDit,SSMorseCodeDah,SSMorseCodeDit],
                            @"G":@[SSMorseCodeDah,SSMorseCodeDah,SSMorseCodeDit],
                            @"H":@[SSMorseCodeDit,SSMorseCodeDit,SSMorseCodeDit,SSMorseCodeDit],
                            @"I":@[SSMorseCodeDit,SSMorseCodeDit],
                            @"J":@[SSMorseCodeDit,SSMorseCodeDah,SSMorseCodeDah,SSMorseCodeDah],
                            @"K":@[SSMorseCodeDah,SSMorseCodeDit,SSMorseCodeDah],
                            @"L":@[SSMorseCodeDit,SSMorseCodeDah,SSMorseCodeDit,SSMorseCodeDit],
                            @"M":@[SSMorseCodeDah,SSMorseCodeDah],
                            @"N":@[SSMorseCodeDah,SSMorseCodeDit],
                            @"O":@[SSMorseCodeDah,SSMorseCodeDah,SSMorseCodeDah],
                            @"P":@[SSMorseCodeDit,SSMorseCodeDah,SSMorseCodeDah,SSMorseCodeDit],
                            @"Q":@[SSMorseCodeDah,SSMorseCodeDah,SSMorseCodeDit,SSMorseCodeDah],
                            @"R":@[SSMorseCodeDit,SSMorseCodeDah,SSMorseCodeDit],
                            @"S":@[SSMorseCodeDit,SSMorseCodeDit,SSMorseCodeDit],
                            @"T":@[SSMorseCodeDah],
                            @"U":@[SSMorseCodeDit,SSMorseCodeDit,SSMorseCodeDah],
                            @"V":@[SSMorseCodeDit,SSMorseCodeDit,SSMorseCodeDit,SSMorseCodeDah],
                            @"W":@[SSMorseCodeDit,SSMorseCodeDah,SSMorseCodeDah],
                            @"X":@[SSMorseCodeDah,SSMorseCodeDit,SSMorseCodeDit,SSMorseCodeDah],
                            @"Y":@[SSMorseCodeDah,SSMorseCodeDit,SSMorseCodeDah,SSMorseCodeDah],
                            @"Z":@[SSMorseCodeDah,SSMorseCodeDah,SSMorseCodeDit,SSMorseCodeDit],
                            @"a":@[SSMorseCodeDit,SSMorseCodeDah],
                            @"b":@[SSMorseCodeDah,SSMorseCodeDit,SSMorseCodeDit,SSMorseCodeDit],
                            @"c":@[SSMorseCodeDah,SSMorseCodeDit,SSMorseCodeDah,SSMorseCodeDit],
                            @"d":@[SSMorseCodeDit,SSMorseCodeDit,SSMorseCodeDit],
                            @"e":@[SSMorseCodeDit],
                            @"f":@[SSMorseCodeDit,SSMorseCodeDit,SSMorseCodeDah,SSMorseCodeDit],
                            @"g":@[SSMorseCodeDah,SSMorseCodeDah,SSMorseCodeDit],
                            @"h":@[SSMorseCodeDit,SSMorseCodeDit,SSMorseCodeDit,SSMorseCodeDit],
                            @"i":@[SSMorseCodeDit,SSMorseCodeDit],
                            @"j":@[SSMorseCodeDit,SSMorseCodeDah,SSMorseCodeDah,SSMorseCodeDah],
                            @"k":@[SSMorseCodeDah,SSMorseCodeDit,SSMorseCodeDah],
                            @"l":@[SSMorseCodeDit,SSMorseCodeDah,SSMorseCodeDit,SSMorseCodeDit],
                            @"m":@[SSMorseCodeDah,SSMorseCodeDah],
                            @"n":@[SSMorseCodeDah,SSMorseCodeDit],
                            @"o":@[SSMorseCodeDah,SSMorseCodeDah,SSMorseCodeDah],
                            @"p":@[SSMorseCodeDit,SSMorseCodeDah,SSMorseCodeDah,SSMorseCodeDit],
                            @"q":@[SSMorseCodeDah,SSMorseCodeDah,SSMorseCodeDit,SSMorseCodeDah],
                            @"r":@[SSMorseCodeDit,SSMorseCodeDah,SSMorseCodeDit],
                            @"s":@[SSMorseCodeDit,SSMorseCodeDit,SSMorseCodeDit],
                            @"t":@[SSMorseCodeDah],
                            @"u":@[SSMorseCodeDit,SSMorseCodeDit,SSMorseCodeDah],
                            @"v":@[SSMorseCodeDit,SSMorseCodeDit,SSMorseCodeDit,SSMorseCodeDah],
                            @"w":@[SSMorseCodeDit,SSMorseCodeDah,SSMorseCodeDah],
                            @"x":@[SSMorseCodeDah,SSMorseCodeDit,SSMorseCodeDit,SSMorseCodeDah],
                            @"y":@[SSMorseCodeDah,SSMorseCodeDit,SSMorseCodeDah,SSMorseCodeDah],
                            @"z":@[SSMorseCodeDah,SSMorseCodeDah,SSMorseCodeDit,SSMorseCodeDit],
                            @"0":@[SSMorseCodeDah,SSMorseCodeDah,SSMorseCodeDah,SSMorseCodeDah,SSMorseCodeDah],
                            @"1":@[SSMorseCodeDit,SSMorseCodeDah,SSMorseCodeDah,SSMorseCodeDah,SSMorseCodeDah],
                            @"2":@[SSMorseCodeDit,SSMorseCodeDit,SSMorseCodeDah,SSMorseCodeDah,SSMorseCodeDah],
                            @"3":@[SSMorseCodeDit,SSMorseCodeDit,SSMorseCodeDit,SSMorseCodeDah,SSMorseCodeDah],
                            @"4":@[SSMorseCodeDit,SSMorseCodeDit,SSMorseCodeDit,SSMorseCodeDit,SSMorseCodeDah],
                            @"5":@[SSMorseCodeDit,SSMorseCodeDit,SSMorseCodeDit,SSMorseCodeDit,SSMorseCodeDit],
                            @"6":@[SSMorseCodeDah,SSMorseCodeDit,SSMorseCodeDit,SSMorseCodeDit,SSMorseCodeDit],
                            @"7":@[SSMorseCodeDah,SSMorseCodeDah,SSMorseCodeDit,SSMorseCodeDit,SSMorseCodeDit],
                            @"8":@[SSMorseCodeDah,SSMorseCodeDah,SSMorseCodeDah,SSMorseCodeDit,SSMorseCodeDit],
                            @"9":@[SSMorseCodeDah,SSMorseCodeDah,SSMorseCodeDah,SSMorseCodeDah,SSMorseCodeDit],
                            @".":@[SSMorseCodeDit,SSMorseCodeDah,SSMorseCodeDit,SSMorseCodeDah,SSMorseCodeDit,SSMorseCodeDah],
                            @":":@[SSMorseCodeDah,SSMorseCodeDah,SSMorseCodeDah,SSMorseCodeDit,SSMorseCodeDit,SSMorseCodeDit],
                            @",":@[SSMorseCodeDah,SSMorseCodeDah,SSMorseCodeDit,SSMorseCodeDit,SSMorseCodeDah,SSMorseCodeDah],
                            @";":@[SSMorseCodeDah,SSMorseCodeDit,SSMorseCodeDah,SSMorseCodeDit,SSMorseCodeDah,SSMorseCodeDit],
                            @"?":@[SSMorseCodeDit,SSMorseCodeDit,SSMorseCodeDah,SSMorseCodeDah,SSMorseCodeDit,SSMorseCodeDit],
                            @"=":@[SSMorseCodeDah,SSMorseCodeDit,SSMorseCodeDit,SSMorseCodeDit,SSMorseCodeDah],
                            @"'":@[SSMorseCodeDit,SSMorseCodeDah,SSMorseCodeDah,SSMorseCodeDah,SSMorseCodeDah,SSMorseCodeDit],
                            @"/":@[SSMorseCodeDah,SSMorseCodeDit,SSMorseCodeDit,SSMorseCodeDah,SSMorseCodeDit],
                            @"!":@[SSMorseCodeDah,SSMorseCodeDit,SSMorseCodeDah,SSMorseCodeDit,SSMorseCodeDah,SSMorseCodeDah],
                            @"-":@[SSMorseCodeDah,SSMorseCodeDit,SSMorseCodeDit,SSMorseCodeDit,SSMorseCodeDit,SSMorseCodeDah],
                            @"_":@[SSMorseCodeDit,SSMorseCodeDit,SSMorseCodeDah,SSMorseCodeDah,SSMorseCodeDit,SSMorseCodeDah],
                            @"\"":@[SSMorseCodeDit,SSMorseCodeDah,SSMorseCodeDit,SSMorseCodeDit,SSMorseCodeDah,SSMorseCodeDit],
                            @"(":@[SSMorseCodeDah,SSMorseCodeDit,SSMorseCodeDah,SSMorseCodeDah,SSMorseCodeDit],
                            @")":@[SSMorseCodeDah,SSMorseCodeDit,SSMorseCodeDah,SSMorseCodeDah,SSMorseCodeDit,SSMorseCodeDah],
                            @"$":@[SSMorseCodeDit,SSMorseCodeDit,SSMorseCodeDit,SSMorseCodeDah,SSMorseCodeDit,SSMorseCodeDit,SSMorseCodeDah],
                            @"&":@[SSMorseCodeDit,SSMorseCodeDit,SSMorseCodeDit,SSMorseCodeDit],
                            @"@":@[SSMorseCodeDit,SSMorseCodeDah,SSMorseCodeDah,SSMorseCodeDit,SSMorseCodeDah,SSMorseCodeDit]};
    }
    return _morseCodeTable;
}

@end
