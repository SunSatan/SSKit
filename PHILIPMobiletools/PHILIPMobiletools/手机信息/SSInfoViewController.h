//
//  SSInfoViewController.h
//  PHILIPMobiletools
//
//  Created by 孙铭健 on 2020/11/4.
//

#import <UIKit/UIKit.h>
#import "SSBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, SSInfoType) {
    SSInfoTypeBasic,
    SSInfoTypeScreen,
    SSInfoTypeSoc,
    SSInfoTypeMemory,
    SSInfoTypeDisk
};

@interface SSInfoViewController : SSBaseViewController

@property (nonatomic, assign) SSInfoType type;

@end

NS_ASSUME_NONNULL_END
