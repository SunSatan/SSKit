//
//  SSMorseCode.m
//  SSKit
//
//  Created by 孙铭健 on 2020/9/29.
//  Copyright © 2020 孙铭健. All rights reserved.
//

#import "SSMorseCode.h"
#import "NSString+SSCategory.h"

static NSString *morseCodeA;
static NSString *morseCodeB;
static NSString *morseCodeC;
static NSString *morseCodeD;
static NSString *morseCodeE;
static NSString *morseCodeF;
static NSString *morseCodeG;
static NSString *morseCodeH;
static NSString *morseCodeI;
static NSString *morseCodeJ;
static NSString *morseCodeK;
static NSString *morseCodeL;
static NSString *morseCodeM;
static NSString *morseCodeN;
static NSString *morseCodeO;
static NSString *morseCodeP;
static NSString *morseCodeQ;
static NSString *morseCodeR;
static NSString *morseCodeS;
static NSString *morseCodeT;
static NSString *morseCodeU;
static NSString *morseCodeV;
static NSString *morseCodeW;
static NSString *morseCodeX;
static NSString *morseCodeY;
static NSString *morseCodeZ;

static NSString *morseCode0;
static NSString *morseCode1;
static NSString *morseCode2;
static NSString *morseCode3;
static NSString *morseCode4;
static NSString *morseCode5;
static NSString *morseCode6;
static NSString *morseCode7;
static NSString *morseCode8;
static NSString *morseCode9;

static NSString *morseCodeFullStop; // .
static NSString *morseCodeColon; // :
static NSString *morseCodeComma; // ,
static NSString *morseCodeSemicolon; // ;
static NSString *morseCodeQuestionMark; // ?
static NSString *morseCodeEqual; // =
static NSString *morseCodeSingleQuotationmMark; // '
static NSString *morseCodeDoubleQuotationMarks; // "
static NSString *morseCodeLeftSlash;  // /
static NSString *morseCodeExclamatoryMark; // !
static NSString *morseCodeDash; // -
static NSString *morseCodeUnderline; // _
static NSString *morseCodeLeftBracket; // (
static NSString *morseCodeRightbracket; // )
static NSString *morseCodeDollar; // $
static NSString *morseCodeAIter; // @


@implementation SSMorseCode



+ (NSString *)morseCodeFromString:(NSString *)string
{
    return [self morseCodeFromString:string ignoreOtherChar:YES];
}

+ (NSString *)morseCodeFromString:(NSString *)string ignoreOtherChar:(BOOL)ignoreOtherChar
{
    NSString *result = @"";
    string = [string clearAllSpaceAndNewline];
    NSArray *stringArray = [string stringCutApartToCharacter];
    for (NSString *key in stringArray) {
        
        NSString *morseCode = self.morseCodeEncodeTable[key];
        
        if (!ignoreOtherChar && !morseCode) {
            morseCode = key;
        }
        result = [result stringByAppendingFormat:@"%@%@", morseCode, SSMorseCodeSeparator];
    }
    return result;
}

+ (NSString *)stringFromMorseCode:(NSString *)string
{
    NSString *result = @"";
    NSArray *morseCodeArray = [string stringCutApartByString:SSMorseCodeSeparator];
    for (NSString *morseCode in morseCodeArray) {
        NSString *string = self.morseCodeDecodeTable[morseCode];
        result = [result stringByAppendingFormat:@"%@", string];
    }
    return result;
}

+ (NSDictionary *)morseCodeDecodeTable
{
    
    static NSDictionary *_morseCodeDecodeTable;
    if (!_morseCodeDecodeTable) {
        _morseCodeDecodeTable = @{morseCodeA:@"A",
                                  morseCodeB:@"B",
                                  morseCodeC:@"C",
                                  morseCodeD:@"D",
                                  morseCodeE:@"E",
                                  morseCodeF:@"F",
                                  morseCodeG:@"G",
                                  morseCodeH:@"H",
                                  morseCodeI:@"I",
                                  morseCodeJ:@"J",
                                  morseCodeK:@"K",
                                  morseCodeL:@"L",
                                  morseCodeM:@"M",
                                  morseCodeN:@"N",
                                  morseCodeO:@"O",
                                  morseCodeP:@"P",
                                  morseCodeQ:@"Q",
                                  morseCodeR:@"R",
                                  morseCodeS:@"S",
                                  morseCodeT:@"T",
                                  morseCodeU:@"U",
                                  morseCodeV:@"V",
                                  morseCodeW:@"W",
                                  morseCodeX:@"X",
                                  morseCodeY:@"Y",
                                  morseCodeZ:@"Z",
                                  morseCode0:@"0",
                                  morseCode1:@"1",
                                  morseCode2:@"2",
                                  morseCode3:@"3",
                                  morseCode4:@"4",
                                  morseCode5:@"5",
                                  morseCode6:@"6",
                                  morseCode7:@"7",
                                  morseCode8:@"8",
                                  morseCode9:@"9",
                                  morseCodeFullStop:@".",
                                  morseCodeColon:@":",
                                  morseCodeComma:@",",
                                  morseCodeSemicolon:@";",
                                  morseCodeQuestionMark:@"?",
                                  morseCodeEqual:@"=",
                                  morseCodeSingleQuotationmMark:@"'",
                                  morseCodeLeftSlash:@"/",
                                  morseCodeExclamatoryMark:@"!",
                                  morseCodeDash:@"-",
                                  morseCodeUnderline:@"_",
                                  morseCodeDoubleQuotationMarks:@"\"",
                                  morseCodeLeftBracket:@"(",
                                  morseCodeRightbracket:@")",
                                  morseCodeDollar:@"$",
                                  morseCodeAIter:@"@"};
    }
    return _morseCodeDecodeTable;
}

+ (NSDictionary *)morseCodeEncodeTable
{
    static NSDictionary *_morseCodeEncodeTable;
    if (!_morseCodeEncodeTable) {
        [self createMorseCode];
        _morseCodeEncodeTable = @{@"A":morseCodeA,
                                  @"B":morseCodeB,
                                  @"C":morseCodeC,
                                  @"D":morseCodeD,
                                  @"E":morseCodeE,
                                  @"F":morseCodeF,
                                  @"G":morseCodeG,
                                  @"H":morseCodeH,
                                  @"I":morseCodeI,
                                  @"J":morseCodeJ,
                                  @"K":morseCodeK,
                                  @"L":morseCodeL,
                                  @"M":morseCodeM,
                                  @"N":morseCodeN,
                                  @"O":morseCodeO,
                                  @"P":morseCodeP,
                                  @"Q":morseCodeQ,
                                  @"R":morseCodeR,
                                  @"S":morseCodeS,
                                  @"T":morseCodeT,
                                  @"U":morseCodeU,
                                  @"V":morseCodeV,
                                  @"W":morseCodeW,
                                  @"X":morseCodeX,
                                  @"Y":morseCodeY,
                                  @"Z":morseCodeZ,
                                  @"a":morseCodeA,
                                  @"b":morseCodeB,
                                  @"c":morseCodeC,
                                  @"d":morseCodeD,
                                  @"e":morseCodeE,
                                  @"f":morseCodeF,
                                  @"g":morseCodeG,
                                  @"h":morseCodeH,
                                  @"i":morseCodeI,
                                  @"j":morseCodeJ,
                                  @"k":morseCodeK,
                                  @"l":morseCodeL,
                                  @"m":morseCodeM,
                                  @"n":morseCodeN,
                                  @"o":morseCodeO,
                                  @"p":morseCodeP,
                                  @"q":morseCodeQ,
                                  @"r":morseCodeR,
                                  @"s":morseCodeS,
                                  @"t":morseCodeT,
                                  @"u":morseCodeU,
                                  @"v":morseCodeV,
                                  @"w":morseCodeW,
                                  @"x":morseCodeX,
                                  @"y":morseCodeY,
                                  @"z":morseCodeZ,
                                  @"0":morseCode0,
                                  @"1":morseCode1,
                                  @"2":morseCode2,
                                  @"3":morseCode3,
                                  @"4":morseCode4,
                                  @"5":morseCode5,
                                  @"6":morseCode6,
                                  @"7":morseCode7,
                                  @"8":morseCode8,
                                  @"9":morseCode9,
                                  @".":morseCodeFullStop,
                                  @":":morseCodeColon,
                                  @",":morseCodeComma,
                                  @";":morseCodeSemicolon,
                                  @"?":morseCodeQuestionMark,
                                  @"=":morseCodeEqual,
                                  @"'":morseCodeSingleQuotationmMark,
                                  @"/":morseCodeLeftSlash,
                                  @"!":morseCodeExclamatoryMark,
                                  @"-":morseCodeDash,
                                  @"_":morseCodeUnderline,
                                  @"\"":morseCodeDoubleQuotationMarks,
                                  @"(":morseCodeLeftBracket,
                                  @")":morseCodeRightbracket,
                                  @"$":morseCodeDollar,
                                  @"@":morseCodeAIter};
    }
    return _morseCodeEncodeTable;
}


+ (void)createMorseCode
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        morseCodeA = [NSString stringWithFormat:@"%@%@",SSMorseCodeDit,SSMorseCodeDah];
        morseCodeB = [NSString stringWithFormat:@"%@%@%@%@",SSMorseCodeDah,SSMorseCodeDit,SSMorseCodeDit,SSMorseCodeDit];
        morseCodeC = [NSString stringWithFormat:@"%@%@%@%@",SSMorseCodeDah,SSMorseCodeDit,SSMorseCodeDah,SSMorseCodeDit];
        morseCodeD = [NSString stringWithFormat:@"%@%@%@",SSMorseCodeDah,SSMorseCodeDit,SSMorseCodeDit];
        morseCodeE = SSMorseCodeDit;
        morseCodeF = [NSString stringWithFormat:@"%@%@%@%@",SSMorseCodeDit,SSMorseCodeDit,SSMorseCodeDah,SSMorseCodeDit];
        morseCodeG = [NSString stringWithFormat:@"%@%@%@",SSMorseCodeDah,SSMorseCodeDah,SSMorseCodeDit];
        morseCodeH = [NSString stringWithFormat:@"%@%@%@%@",SSMorseCodeDit,SSMorseCodeDit,SSMorseCodeDit,SSMorseCodeDit];
        morseCodeI = [NSString stringWithFormat:@"%@%@",SSMorseCodeDit,SSMorseCodeDit];
        morseCodeJ = [NSString stringWithFormat:@"%@%@%@%@",SSMorseCodeDit,SSMorseCodeDah,SSMorseCodeDah,SSMorseCodeDah];
        morseCodeK = [NSString stringWithFormat:@"%@%@%@",SSMorseCodeDah,SSMorseCodeDit,SSMorseCodeDah];
        morseCodeL = [NSString stringWithFormat:@"%@%@%@%@",SSMorseCodeDit,SSMorseCodeDah,SSMorseCodeDit,SSMorseCodeDit];
        morseCodeM = [NSString stringWithFormat:@"%@%@",SSMorseCodeDah,SSMorseCodeDah];
        morseCodeN = [NSString stringWithFormat:@"%@%@",SSMorseCodeDah,SSMorseCodeDit];
        morseCodeO = [NSString stringWithFormat:@"%@%@%@",SSMorseCodeDah,SSMorseCodeDah,SSMorseCodeDah];
        morseCodeP = [NSString stringWithFormat:@"%@%@%@%@",SSMorseCodeDit,SSMorseCodeDah,SSMorseCodeDah,SSMorseCodeDit];
        morseCodeQ = [NSString stringWithFormat:@"%@%@%@%@",SSMorseCodeDah,SSMorseCodeDah,SSMorseCodeDit,SSMorseCodeDah];
        morseCodeR = [NSString stringWithFormat:@"%@%@%@",SSMorseCodeDit,SSMorseCodeDah,SSMorseCodeDit];
        morseCodeS = [NSString stringWithFormat:@"%@%@%@",SSMorseCodeDit,SSMorseCodeDit,SSMorseCodeDit];
        morseCodeT = SSMorseCodeDah;
        morseCodeU = [NSString stringWithFormat:@"%@%@%@",SSMorseCodeDit,SSMorseCodeDit,SSMorseCodeDah];
        morseCodeV = [NSString stringWithFormat:@"%@%@%@%@",SSMorseCodeDit,SSMorseCodeDit,SSMorseCodeDit,SSMorseCodeDah];
        morseCodeW = [NSString stringWithFormat:@"%@%@%@",SSMorseCodeDit,SSMorseCodeDah,SSMorseCodeDah];
        morseCodeX = [NSString stringWithFormat:@"%@%@%@%@",SSMorseCodeDah,SSMorseCodeDit,SSMorseCodeDit,SSMorseCodeDah];
        morseCodeY = [NSString stringWithFormat:@"%@%@%@%@",SSMorseCodeDah,SSMorseCodeDit,SSMorseCodeDah,SSMorseCodeDah];
        morseCodeZ = [NSString stringWithFormat:@"%@%@%@%@",SSMorseCodeDah,SSMorseCodeDah,SSMorseCodeDit,SSMorseCodeDit];
        morseCode0 = [NSString stringWithFormat:@"%@%@%@%@%@",SSMorseCodeDah,SSMorseCodeDah,SSMorseCodeDah,SSMorseCodeDah,SSMorseCodeDah];
        morseCode1 = [NSString stringWithFormat:@"%@%@%@%@%@",SSMorseCodeDit,SSMorseCodeDah,SSMorseCodeDah,SSMorseCodeDah,SSMorseCodeDah];
        morseCode2 = [NSString stringWithFormat:@"%@%@%@%@%@",SSMorseCodeDit,SSMorseCodeDit,SSMorseCodeDah,SSMorseCodeDah,SSMorseCodeDah];
        morseCode3 = [NSString stringWithFormat:@"%@%@%@%@%@",SSMorseCodeDit,SSMorseCodeDit,SSMorseCodeDit,SSMorseCodeDah,SSMorseCodeDah];
        morseCode4 = [NSString stringWithFormat:@"%@%@%@%@%@",SSMorseCodeDit,SSMorseCodeDit,SSMorseCodeDit,SSMorseCodeDit,SSMorseCodeDah];
        morseCode5 = [NSString stringWithFormat:@"%@%@%@%@%@",SSMorseCodeDit,SSMorseCodeDit,SSMorseCodeDit,SSMorseCodeDit,SSMorseCodeDit];
        morseCode6 = [NSString stringWithFormat:@"%@%@%@%@%@",SSMorseCodeDah,SSMorseCodeDit,SSMorseCodeDit,SSMorseCodeDit,SSMorseCodeDit];
        morseCode7 = [NSString stringWithFormat:@"%@%@%@%@%@",SSMorseCodeDah,SSMorseCodeDah,SSMorseCodeDit,SSMorseCodeDit,SSMorseCodeDit];
        morseCode8 = [NSString stringWithFormat:@"%@%@%@%@%@",SSMorseCodeDah,SSMorseCodeDah,SSMorseCodeDah,SSMorseCodeDit,SSMorseCodeDit];
        morseCode9 = [NSString stringWithFormat:@"%@%@%@%@%@",SSMorseCodeDah,SSMorseCodeDah,SSMorseCodeDah,SSMorseCodeDah,SSMorseCodeDit];
        morseCodeFullStop = [NSString stringWithFormat:@"%@%@%@%@%@%@",SSMorseCodeDit,SSMorseCodeDah,SSMorseCodeDit,SSMorseCodeDah,SSMorseCodeDit,SSMorseCodeDah];
        morseCodeColon = [NSString stringWithFormat:@"%@%@%@%@%@%@",SSMorseCodeDah,SSMorseCodeDah,SSMorseCodeDah,SSMorseCodeDit,SSMorseCodeDit,SSMorseCodeDit];
        morseCodeComma = [NSString stringWithFormat:@"%@%@%@%@%@%@",SSMorseCodeDah,SSMorseCodeDah,SSMorseCodeDit,SSMorseCodeDit,SSMorseCodeDah,SSMorseCodeDah];
        morseCodeSemicolon = [NSString stringWithFormat:@"%@%@%@%@%@%@",SSMorseCodeDah,SSMorseCodeDit,SSMorseCodeDah,SSMorseCodeDit,SSMorseCodeDah,SSMorseCodeDit];
        morseCodeQuestionMark = [NSString stringWithFormat:@"%@%@%@%@%@%@",SSMorseCodeDit,SSMorseCodeDit,SSMorseCodeDah,SSMorseCodeDah,SSMorseCodeDit,SSMorseCodeDit];
        morseCodeEqual = [NSString stringWithFormat:@"%@%@%@%@%@",SSMorseCodeDah,SSMorseCodeDit,SSMorseCodeDit,SSMorseCodeDit,SSMorseCodeDah];
        morseCodeSingleQuotationmMark = [NSString stringWithFormat:@"%@%@%@%@%@%@",SSMorseCodeDit,SSMorseCodeDah,SSMorseCodeDah,SSMorseCodeDah,SSMorseCodeDah,SSMorseCodeDit];
        morseCodeDoubleQuotationMarks = [NSString stringWithFormat:@"%@%@%@%@%@%@",SSMorseCodeDit,SSMorseCodeDah,SSMorseCodeDit,SSMorseCodeDit,SSMorseCodeDah,SSMorseCodeDit];
        morseCodeLeftSlash = [NSString stringWithFormat:@"%@%@%@%@%@",SSMorseCodeDah,SSMorseCodeDit,SSMorseCodeDit,SSMorseCodeDah,SSMorseCodeDit];
        morseCodeExclamatoryMark = [NSString stringWithFormat:@"%@%@%@%@%@%@",SSMorseCodeDah,SSMorseCodeDit,SSMorseCodeDah,SSMorseCodeDit,SSMorseCodeDah,SSMorseCodeDah];
        morseCodeDash = [NSString stringWithFormat:@"%@%@%@%@%@%@",SSMorseCodeDah,SSMorseCodeDit,SSMorseCodeDit,SSMorseCodeDit,SSMorseCodeDit,SSMorseCodeDah];
        morseCodeUnderline = [NSString stringWithFormat:@"%@%@%@%@%@%@",SSMorseCodeDit,SSMorseCodeDit,SSMorseCodeDah,SSMorseCodeDah,SSMorseCodeDit,SSMorseCodeDah];
        morseCodeLeftBracket = [NSString stringWithFormat:@"%@%@%@%@%@",SSMorseCodeDah,SSMorseCodeDit,SSMorseCodeDah,SSMorseCodeDah,SSMorseCodeDit];
        morseCodeRightbracket = [NSString stringWithFormat:@"%@%@%@%@%@%@",SSMorseCodeDah,SSMorseCodeDit,SSMorseCodeDah,SSMorseCodeDah,SSMorseCodeDit,SSMorseCodeDah];
        morseCodeDollar = [NSString stringWithFormat:@"%@%@%@%@%@%@%@",SSMorseCodeDit,SSMorseCodeDit,SSMorseCodeDit,SSMorseCodeDah,SSMorseCodeDit,SSMorseCodeDit,SSMorseCodeDah];
        morseCodeAIter = [NSString stringWithFormat:@"%@%@%@%@%@%@",SSMorseCodeDit,SSMorseCodeDah,SSMorseCodeDah,SSMorseCodeDit,SSMorseCodeDah,SSMorseCodeDit];
    });
}

@end
