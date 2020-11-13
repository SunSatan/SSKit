//
//  SSContactsGroup.h
//  SSKit
//
//  Created by 孙铭健 on 2020/11/13.
//  Copyright © 2020 孙铭健. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class SSContacts;

/// 联系人名字首字母分组排序
@interface SSContactsGroup : NSObject
/**
 * 获取所有联系人的首字母数组
 * @param array 联系人数组
 */
+ (NSArray<NSString *> *)contactsFirstNameGroupWithArray:(NSArray<SSContacts *> *)array;
/**
 * 获取联系人分组并升序排序，二维数组
 * @param array 联系人数组
 */
+ (NSArray<NSArray<SSContacts *> *> *)contactsGroupedAndSortedWithArray:(NSArray<SSContacts *> *)array;

@end

NS_ASSUME_NONNULL_END
