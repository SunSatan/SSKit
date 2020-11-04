//
//  SSImageCategory.h
//  SSKit
//
//  Created by SunSatan on 2020/10/29.
//  Copyright © 2020 SunSatan. All rights reserved.
//

#ifndef SSImageCategory_h
#define SSImageCategory_h

#define SSImageNamed(x) [UIImage imageNamed:x]

#define SSDegreesToRadian(x)      (M_PI * (x) / 180.0)
#define SSRadianToDegrees(radian) ((radian) * 180.0)/(M_PI)

#define SS_360P  CGSizeMake(360, 360)
#define SS_720P  CGSizeMake(720, 720)
#define SS_1080P CGSizeMake(1080, 1080)
#define SS_2K    CGSizeMake(1440, 1440)
#define SS_4K    CGSizeMake(2160, 2160)

#import "UIImage+SSImage.h"
#import "UIImage+Compress.h"
#import "UIImage+QRCode.h"
#import "UIImage+Splicing.h"
#import "UIImage+Filter.h"
#import "UIImage+ImageRotate.h"
#import "UIImage+MostColor.h"


#endif /* SSImageCategory_h */
