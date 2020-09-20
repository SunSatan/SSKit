//
//  SSAuthorization.h
//  SSKit
//
//  Created by SunSatan on 2020/9/20.
//  Copyright © 2020 孙铭健. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, SSAuthorizationType) {
    SSAuthorizationTypeNone       = 0,
    SSAuthorizationTypePush       = 1 << 0,  // 消息推送授权
    SSAuthorizationTypeLocation   = 1 << 1,  // 定位授权
    SSAuthorizationTypeCamera     = 1 << 2,  // 相机授权
    SSAuthorizationTypePhoto      = 1 << 3,  // 相册授权
    SSAuthorizationTypeAudio      = 1 << 4,  // 麦克风授权
    SSAuthorizationTypeContacts   = 1 << 5,  // 通讯录授权
    SSAuthorizationTypeADTracking = 1 << 6,  // 广告跟踪授权
    SSAuthorizationTypeBluetooth  = 1 << 7,  // 蓝牙授权
    SSAuthorizationTypeEvent      = 1 << 8,  // 日历授权
    SSAuthorizationTypeReminder   = 1 << 9,  // 备忘录授权
};


@interface SSAuthorization : NSObject

/// 获取当前应用权限
+ (SSAuthorizationType)currentAuthorization;
/// 更新应用权限
+ (void)updateAuthorization;

@end

NS_ASSUME_NONNULL_END
