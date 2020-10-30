//
//  SSMorseCode.h
//  SSKit
//
//  Created by SunSatan on 2020/9/29.
//  Copyright © 2020 SunSatan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

static NSString * const SSMorseCodeDah = @"-"; //@"="
static NSString * const SSMorseCodeDit = @".";
static NSString * const SSMorseCodeSeparator = @" "; //自定义分隔符

@interface SSMorseCode : NSObject

@property (class, nonatomic, readonly) NSDictionary<NSString *, NSString *> *morseCodeEncodeTable;

+ (NSString *)morseCodeFromString:(NSString *)string;
+ (NSString *)morseCodeFromString:(NSString *)string ignoreOtherChar:(BOOL)ignoreOtherChar;

+ (NSString *)stringFromMorseCode:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
