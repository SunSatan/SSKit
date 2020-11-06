//
//  HealthModel.h
//  PHILIPMobiletools
//
//  Created by 孙铭健 on 2020/11/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HealthModel : NSObject

@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *data;
@property (nonatomic, copy) NSString *unit;
@property (nonatomic, copy) NSString *time;

@property (nonatomic, strong, readonly) NSAttributedString *healthString;

@end

NS_ASSUME_NONNULL_END
