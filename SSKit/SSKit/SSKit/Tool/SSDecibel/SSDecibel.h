//
//  SSDecibel.h
//  SSKit
//
//  Created by SunSatan on 2020/11/2.
//  Copyright © 2020 SunSatan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SSDecibel : NSObject

@property (nonatomic, readonly) NSUInteger avgDB;
@property (nonatomic, readonly) NSUInteger maxDB;
@property (nonatomic, readonly) NSUInteger minDB;

@property (nonatomic, readonly, strong) NSArray *dbRecords; //开始检测后，自动记录分贝值

- (void)startCheckDecibelWithInterval:(NSTimeInterval)interval
                        updateDecibel:(void(^)(NSUInteger db))updateDecibel;
- (void)endCheckDecibel;

@end

NS_ASSUME_NONNULL_END
