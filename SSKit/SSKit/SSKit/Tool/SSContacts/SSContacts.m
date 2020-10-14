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

static NSUInteger const kSectionsNumber = 27; //27:A-Z + #
static NSUInteger const kOtherIndex = 26; //# 放最后面

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
        _uppercaseFirstCharacter = @"#";
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
    unichar firstCharacter = [_characterName characterAtIndex:0];
    for(int index = 1; index < _characterName.length; index++) {
        if (firstCharacter != ' ') break;
        firstCharacter = [_characterName characterAtIndex:index];
    }
    
    if (firstCharacter < 'A' ||
        (firstCharacter > 'Z' && firstCharacter < 'a') ||
        firstCharacter > 'z') {
        return;//默认是 #
    }
    //大写首字母，用于分组
    NSString *uppercaseFirstCharacter = [NSString stringWithFormat:@"%c", firstCharacter];
    _uppercaseFirstCharacter = uppercaseFirstCharacter.uppercaseString;
}

#pragma mark - 分组排序

+ (NSArray<NSArray *> *)contactsGroupedAndSortedWithArray:(NSArray<SSContacts *> *)array
{
    //初始化一个二位数组和其中27个可变空数组
    NSMutableArray *sectionsArray = [NSMutableArray arrayWithCapacity:kSectionsNumber];
    
    for (NSInteger index = 0; index < kSectionsNumber; index++) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        [sectionsArray addObject:array];
    }
    //遍历，放入对应的分组的数组中
    for (SSContacts *contacts in array) {
        NSInteger sectionsNumber = [contacts.uppercaseFirstCharacter characterAtIndex:0] - 'A';
        
        if (sectionsNumber < 0) { // #(35) - A(65) = -20
            sectionsNumber = kOtherIndex;
        }
        
        NSMutableArray *sections = sectionsArray[sectionsNumber];
        [sections addObject:contacts];
    }
    //数据整合，一次遍历移除空数组并升序排序
    NSMutableArray *result = [NSMutableArray array];
    for (NSInteger index = 0; index < sectionsArray.count; index++) {
        NSArray *array = [NSArray arrayWithArray:sectionsArray[index]];
        if (array.count == 0) {//不要空数组
            continue;
        }
        
        array = [array sortedArrayUsingComparator:^NSComparisonResult(SSContacts *obj1, SSContacts *obj2) {
            return [obj1.characterName compare:obj2.characterName];
        }];
        [result addObject:array];
    }
    
    NSArray *resultArray = [NSArray arrayWithArray:result];
    return resultArray;
}

+ (NSArray<NSString *> *)contactsSectionWithArray:(NSArray<SSContacts *> *)array
{
    //用集合过滤分组
    NSMutableSet *mutSet = [NSMutableSet set];
    for (SSContacts *contacts in array) {
        if (![mutSet containsObject:contacts.uppercaseFirstCharacter]) {
            [mutSet addObject:contacts.uppercaseFirstCharacter];
        }
    }
    
    NSArray<NSString *> *resultArray = [mutSet allObjects];
    //sort：A-Z升序 #放到最后
    resultArray = [resultArray sortedArrayUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
        if ([obj1 isEqualToString:@"#"]) {
            return NSOrderedDescending;
        } else if ([obj2 isEqualToString:@"#"]) {
            return NSOrderedAscending;
        }
        return [obj1 compare:obj2];
    }];
    
    return resultArray;
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
