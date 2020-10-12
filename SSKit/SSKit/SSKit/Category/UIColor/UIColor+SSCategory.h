//
//  UIColor+SSCategory.h
//  SSKit
//
//  Created by 孙铭健 on 2020/9/18.
//  Copyright © 2020 孙铭健. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//自定义RGB颜色
#define SSColorRGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define SSColorRGB(r, g, b)     SSColorRGBA(r, g, b, 1.0)

//自定义十六进制颜色
#define SSColorHex(hex)         [UIColor ss_colorWithHexString:hex]
#define SSColorHexAlpha(hex, a) [UIColor ss_colorWithHexString:hex alpha:(a)]

//暗黑模式，动态颜色
#define SSColorLightAndDark(lightColor, darkColor) \
[UIColor ss_colorWithLightColor:lightColor darkColor:darkColor]

#define SSColorLightAndDarkHex(lightHex, darkHex) \
[UIColor ss_colorWithLightColorHex:lightHex darkColorHex:darkHex]

#define SSColorLightAndDarkHexAlpha(lightHex, lightAlpha, darkHex, darkAlpha) \
[UIColor ss_colorWithLightColorHex:lightHex lightColorAlpha:lightAlpha darkColorHex:darkHex darkColorAlpha:darkAlpha]

@interface UIColor (SSCategory)

+ (UIColor *)ss_colorWithHexString:(NSString *)hexString;
+ (UIColor *)ss_colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;

+ (UIColor *)ss_colorWithLightColor:(UIColor *)lightColor
                          darkColor:(UIColor *)darkColor;

+ (UIColor *)ss_colorWithLightColorHex:(NSString *)lightColorHex
                          darkColorHex:(NSString *)darkColorHex;

+ (UIColor *)ss_colorWithLightColorHex:(NSString *)lightColorHex
                       lightColorAlpha:(CGFloat)lightColorAlpha
                          darkColorHex:(NSString *)darkColorHex
                        darkColorAlpha:(CGFloat)darkColorAlpha;

#pragma mark - custom color



#pragma mark - pink

@property (class, nonatomic, readonly) UIColor *pink;            // #FFC0CB
@property (class, nonatomic, readonly) UIColor *pinkLight;       // #FFB6C1
@property (class, nonatomic, readonly) UIColor *pinkLightSalmon; // #FFA07A
@property (class, nonatomic, readonly) UIColor *pinkCoral;       // #FF7F50
@property (class, nonatomic, readonly) UIColor *pinkLightCoral;  // #F08080

#pragma mark - red

@property (class, nonatomic, readonly) UIColor *redBlood;         // #DC143C
@property (class, nonatomic, readonly) UIColor *redLavenderBlush; // #FFF0F5
@property (class, nonatomic, readonly) UIColor *redPaleViolet;    // #DB7093
@property (class, nonatomic, readonly) UIColor *redTomato;        // #FF6347
@property (class, nonatomic, readonly) UIColor *redDark;          // #8B0000
@property (class, nonatomic, readonly) UIColor *redFireBrick;     // #B22222

#pragma mark - purple

@property (class, nonatomic, readonly) UIColor *purpleDarkMagenta;   //#8B008B
@property (class, nonatomic, readonly) UIColor *purpleMediumOrchid;  // #BA55D3
@property (class, nonatomic, readonly) UIColor *purpleDarkOrchid;    // #9932CC
@property (class, nonatomic, readonly) UIColor *purpleBlueViolet;    // #8A2BE2
@property (class, nonatomic, readonly) UIColor *purpleMedium;        //#9370DB
@property (class, nonatomic, readonly) UIColor *purpleLightLavender; // #E6E6FA

#pragma mark - blue

@property (class, nonatomic, readonly) UIColor *blueSlate;       // #6A5ACD
@property (class, nonatomic, readonly) UIColor *blueMediumSlate; // #7B68EE
@property (class, nonatomic, readonly) UIColor *blueDarkSlate;   // #483D8B
@property (class, nonatomic, readonly) UIColor *blueMidnight;    // #191970
@property (class, nonatomic, readonly) UIColor *blueDark;        // #00008B
@property (class, nonatomic, readonly) UIColor *blueRoyal;       // #4169E1
@property (class, nonatomic, readonly) UIColor *clueCornflower;  // #6495ED
@property (class, nonatomic, readonly) UIColor *blueLightSteel;  // #B0C4DE
@property (class, nonatomic, readonly) UIColor *blueDoder;       // #1E90FF
@property (class, nonatomic, readonly) UIColor *blueSteel;       // #4682B4
@property (class, nonatomic, readonly) UIColor *blueLightSky;    // #87CEFA
@property (class, nonatomic, readonly) UIColor *blueSky;         // #87CEEB
@property (class, nonatomic, readonly) UIColor *blueCadet;       // #5F9EA0

#pragma mark - green

@property (class, nonatomic, readonly) UIColor *greenDarkSlate;       // #2F4F4F
@property (class, nonatomic, readonly) UIColor *greenDarkCyan;        // #008B8B
@property (class, nonatomic, readonly) UIColor *greenTeal;            // #008080
@property (class, nonatomic, readonly) UIColor *greenMediumTurquoise; // #48D1CC
@property (class, nonatomic, readonly) UIColor *greenSea;             // #2E8B57
@property (class, nonatomic, readonly) UIColor *greenLightSea;        // #20B2AA
@property (class, nonatomic, readonly) UIColor *greenSpring;          // #3CB371
@property (class, nonatomic, readonly) UIColor *greenHoneydew;        // #F0FFF0
@property (class, nonatomic, readonly) UIColor *greenLight;           // #90EE90


#pragma mark - white

@property (class, nonatomic, readonly) UIColor *whiteGhost; // #F8F8FF
@property (class, nonatomic, readonly) UIColor *whiteSmoke; // #F5F5F5
@property (class, nonatomic, readonly) UIColor *snow;       // #FFFAFA

#pragma mark - gray

@property (class, nonatomic, readonly) UIColor *grayLightSlate; // #778899
@property (class, nonatomic, readonly) UIColor *graySlate;      // #708090
@property (class, nonatomic, readonly) UIColor *grayGainsboro;  // #DCDCDC
@property (class, nonatomic, readonly) UIColor *graySilver;     // #C0C0C0
@property (class, nonatomic, readonly) UIColor *grayDark;       // #A9A9A9
@property (class, nonatomic, readonly) UIColor *grayDim;        // #696969

#pragma mark - yellow

@property (class, nonatomic, readonly) UIColor *yellowLightGoldenrod; // #FAFAD2
@property (class, nonatomic, readonly) UIColor *yellowIvory;          // #FFFFF0
@property (class, nonatomic, readonly) UIColor *yellowLight;          // #FFFFE0
@property (class, nonatomic, readonly) UIColor *gold;                 // #FFD700

#pragma mark - orange

@property (class, nonatomic, readonly) UIColor *orangeDark; // #FF8C00
@property (class, nonatomic, readonly) UIColor *orangeRed;  // #FF4500

@end

NS_ASSUME_NONNULL_END
