//
//  SSContacts.h
//  SSContacts
//
//  Created by SunSatan on 2020/9/4.
//  Copyright © 2020 SunSatan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// 未做多音字区分

@interface SSContacts : NSObject // 联系人名字首字母分组排序

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *phone;

@property (nonatomic, strong, readonly) NSString *characterName;//名字拼音字母
@property (nonatomic, strong, readonly) NSString *uppercaseFirstCharacter;//名字首字母大写（A～Z,#）
/**
 * 获取所有联系人的首字母数组
 * @param array 联系人数组
 */
+ (NSArray<NSString *> *)contactsSectionWithArray:(NSArray<SSContacts *> *)array;
/**
 * 获取联系人分组并排序，二维数组
 * @param array 联系人数组
 */
+ (NSArray<NSArray *> *)contactsGroupedAndSortedWithArray:(NSArray<SSContacts *> *)array;

- (instancetype)initWithName:(NSString *)name;
+ (instancetype)contactsWithName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
