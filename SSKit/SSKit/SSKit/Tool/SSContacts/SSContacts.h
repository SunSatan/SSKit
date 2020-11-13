//
//  SSContacts.h
//  SSContacts
//
//  Created by SunSatan on 2020/9/4.
//  Copyright © 2020 SunSatan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

static NSString * const SSContactsOtherCharacter = @"#";

@interface SSContacts : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *phone;

@property (nonatomic, strong, readonly) NSString *characterName; // 名字拼音字母，未做多音字区分
@property (nonatomic, strong, readonly) NSString *uppercaseFirstCharacter; // 名字首字母大写（A～Z,otherCharacter）

- (instancetype)initWithName:(NSString *)name;
+ (instancetype)contactsWithName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
