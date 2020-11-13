//
//  SSContactsGroup.m
//  SSKit
//
//  Created by 孙铭健 on 2020/11/13.
//  Copyright © 2020 孙铭健. All rights reserved.
//

#import "SSContactsGroup.h"
#import "SSContacts.h"

static NSUInteger const kSectionsNumber = 27; //27:A-Z + #
static NSUInteger const kOtherIndex = 26; //# 放最后面

@implementation SSContactsGroup

#pragma mark - 分组排序

+ (NSArray<NSArray<SSContacts *> *> *)contactsGroupedAndSortedWithArray:(NSArray<SSContacts *> *)array
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

+ (NSArray<NSString *> *)contactsFirstNameGroupWithArray:(NSArray<SSContacts *> *)array
{
    //用集合过滤分组
    NSMutableSet *mutSet = [NSMutableSet set];
    for (SSContacts *contacts in array) {
        if (![mutSet containsObject:contacts.uppercaseFirstCharacter]) {
            [mutSet addObject:contacts.uppercaseFirstCharacter];
        }
    }
    
    NSArray<NSString *> *resultArray = [mutSet allObjects];
    //sort：A-Z升序 OtherCharacter 放到最后
    resultArray = [resultArray sortedArrayUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
        if ([obj1 isEqualToString:SSContactsOtherCharacter]) {
            return NSOrderedDescending;
        } else if ([obj2 isEqualToString:SSContactsOtherCharacter]) {
            return NSOrderedAscending;
        }
        return [obj1 compare:obj2];
    }];
    
    return resultArray;
}

@end
