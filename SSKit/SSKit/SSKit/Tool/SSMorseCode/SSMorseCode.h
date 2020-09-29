//
//  SSMorseCode.h
//  SSKit
//
//  Created by 孙铭健 on 2020/9/29.
//  Copyright © 2020 孙铭健. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

static NSString * const SSMorseCodeDah = @"="; //@"-"
static NSString * const SSMorseCodeDit = @".";

@interface SSMorseCode : NSObject

@property (class, nonatomic, readonly) NSDictionary<NSString *, NSArray *> *morseCodeTable;

+ (NSString *)morseCode:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
