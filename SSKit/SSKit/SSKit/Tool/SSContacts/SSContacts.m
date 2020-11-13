//
//  SSContacts.m
//  SSContacts
//
//  Created by SunSatan on 2020/9/4.
//  Copyright © 2020 SunSatan. All rights reserved.
//

#import "SSContacts.h"
#import "NSString+SSCategory.h"

#import <UIKit/UIKit.h>

static NSMutableDictionary *kNameCache;

@implementation SSContacts

#pragma mark - init

+ (instancetype)contactsWithName:(NSString *)name
{
    return [[self alloc] initWithName:name];
}

- (instancetype)init
{
    if (self = [super init]) {
        _name = @"";
        _phone = @"";
        _characterName = @"";
        _uppercaseFirstCharacter = SSContactsOtherCharacter;
    }
    return self;
}

- (instancetype)initWithName:(NSString *)name
{
    if (self = [self init]) {
        [self setName:name];
    }
    return self;
}

#pragma mark - 字符转换

- (void)nameTransformCharacterName
{
    //取缓存
    NSMutableDictionary *nameCache = [self nameCache];
    NSString *cache = nameCache[_name];
    if (cache) {
        _characterName = cache;
        return;
    }
    //中文转拼音
    _characterName = [_name ss_chineseTransformPinyinWithCapitalized:YES];//首字母大写用于排序
    //缓存
    nameCache[_name] = _characterName;
}

- (void)uppercaseFirstCharacterInCharacterName
{
    //去除空格取到真的首字母
    unichar firstCharacter = [[_characterName ss_clearAllSpaceAndNewline] characterAtIndex:0];
    
    if (firstCharacter < 'A' ||
        (firstCharacter > 'Z' && firstCharacter < 'a') ||
        firstCharacter > 'z') {
        return;//默认是 otherCharacter
    }
    //首字母大写，用于分组
    NSString *uppercaseFirstCharacter = [NSString stringWithFormat:@"%c", firstCharacter];
    _uppercaseFirstCharacter = uppercaseFirstCharacter.uppercaseString;
}

#pragma mark - getter

- (NSMutableDictionary *)nameCache
{
    if (!kNameCache) {
        kNameCache = [NSMutableDictionary dictionary];
    }
    return kNameCache;
}

#pragma mark - setter

- (void)setName:(NSString *)name
{
    _name = [name copy];
    [self nameTransformCharacterName];
    [self uppercaseFirstCharacterInCharacterName];
}

@end
