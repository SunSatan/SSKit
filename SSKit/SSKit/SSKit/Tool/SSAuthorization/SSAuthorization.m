//
//  SSAuthorization.m
//  SSKit
//
//  Created by SunSatan on 2020/9/20.
//  Copyright © 2020 SunSatan. All rights reserved.
//

#import "SSAuthorization.h"

//广告
#import <AdSupport/AdSupport.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>
//推送
#import <UIKit/UIKit.h>
//定位
#import <CoreLocation/CoreLocation.h>
//相机、麦克风
#import <AVFoundation/AVFoundation.h>
//相册
#import <Photos/Photos.h>
//联系人
#import <Contacts/Contacts.h>
//蓝牙
#import <CoreBluetooth/CoreBluetooth.h>
//日历、备忘录
#import <EventKit/EventKit.h>
//健康
#import <HealthKit/HealthKit.h>

static SSAuthorizationType kAuthorization;

@implementation SSAuthorization


+ (void)initialize
{
    kAuthorization = SSAuthorizationTypeNone;
    [self updateAuthorization];
}

/// 获取当前应用权限
+ (SSAuthorizationType)currentAuthorization
{
    return kAuthorization;
}

/// 更新应用权限
+ (void)updateAuthorization
{
    /// 推送
    if ([UIApplication sharedApplication].currentUserNotificationSettings.types == UIUserNotificationTypeNone) {
        kAuthorization &= (~SSAuthorizationTypePush);
    } else {
        kAuthorization |= SSAuthorizationTypePush;
    }
    
    /// 定位
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse) {
        kAuthorization |= SSAuthorizationTypeLocation;
    } else {
        kAuthorization &= (~SSAuthorizationTypeLocation);
    }
    /// 相机
    if ([AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo] == AVAuthorizationStatusAuthorized) {
        kAuthorization |= SSAuthorizationTypeCamera;
    } else {
        kAuthorization &= (~SSAuthorizationTypeCamera);
    }
    /// 麦克风
    [[AVAudioSession sharedInstance] requestRecordPermission: ^(BOOL granted) {
        if (granted) {
            kAuthorization |= SSAuthorizationTypeAudio;
        } else {
            kAuthorization &= (~SSAuthorizationTypeAudio);
        }
    }];
    /// 相册
    if ([PHPhotoLibrary authorizationStatus] == PHAuthorizationStatusAuthorized) {
        kAuthorization |= SSAuthorizationTypePhoto;
    } else {
        kAuthorization &= (~SSAuthorizationTypePhoto);
    }
    
    /// 通讯录
    if ([CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts] == CNAuthorizationStatusAuthorized) {
        kAuthorization |= SSAuthorizationTypeContacts;
    } else {
        kAuthorization &= (~SSAuthorizationTypeContacts);
    }
    /// 广告
    if (@available(iOS 14, *)) {
        [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
            if (status == ATTrackingManagerAuthorizationStatusAuthorized) {
                kAuthorization |= SSAuthorizationTypeADTracking;
            } else {
                kAuthorization &= (~SSAuthorizationTypeADTracking);
            }
        }];
    } else {
        if ([[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled]) {
            kAuthorization |= SSAuthorizationTypeADTracking;
        } else {
            kAuthorization &= (~SSAuthorizationTypeADTracking);
        }
    }
    /// 蓝牙
    if (@available(iOS 13.1, *)) {
        if (CBManager.authorization == CBManagerAuthorizationAllowedAlways) {
            kAuthorization |= SSAuthorizationTypeBluetooth;
        } else {
            kAuthorization &= (~SSAuthorizationTypeBluetooth);
        }
    }
    /// 日历
    if ([EKEventStore authorizationStatusForEntityType:EKEntityTypeEvent] == CNAuthorizationStatusAuthorized) {
        kAuthorization |= SSAuthorizationTypeEvent;
    } else  {
        kAuthorization &= (~SSAuthorizationTypeEvent);
    }
    
    /// 备忘录
    if ([EKEventStore authorizationStatusForEntityType:EKEntityTypeReminder] == CNAuthorizationStatusAuthorized) {
        kAuthorization |= SSAuthorizationTypeReminder;
    } else  {
        kAuthorization &= (~SSAuthorizationTypeReminder);
    }
    
    
}



@end
