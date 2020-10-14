//
//  UIColor+SSCategory.m
//  SSKit
//
//  Created by 孙铭健 on 2020/9/18.
//  Copyright © 2020 孙铭健. All rights reserved.
//

#import "UIColor+SSCategory.h"
#import "SSKit.h"

@implementation UIColor (SSCategory)

+ (UIColor *)ss_colorWithHexString:(NSString *)hexString
{
    return [self ss_colorWithHexString:hexString alpha:1];
}

+ (UIColor *)ss_colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha
{
    NSParameterAssert(hexString);
    
    hexString  = [hexString ss_clearAllSpaceAndNewline];
    if ([hexString hasPrefix:@"#"]) {
        hexString = [hexString substringFromIndex:1];
    }
    if ([hexString hasPrefix:@"0x"]) {
        hexString = [hexString substringFromIndex:2];
    }
    
    NSAssert(hexString.length == 6, @"不符号十六进制颜色");
    
    // 从六位数值中找到RGB对应的位数并转换
    
    NSRange redRange = NSMakeRange(0, 2);
    NSString *redString = [hexString substringWithRange:redRange];
    
    NSRange greenRange = NSMakeRange(2, 2);
    NSString *greenString = [hexString substringWithRange:greenRange];
    
    NSRange blueRange = NSMakeRange(4, 2);
    NSString *blueString = [hexString substringWithRange:blueRange];
    
    unsigned int red, green, blue = 0;
    [[NSScanner scannerWithString:redString]   scanHexInt:&red];
    [[NSScanner scannerWithString:greenString] scanHexInt:&green];
    [[NSScanner scannerWithString:blueString]  scanHexInt:&blue];
    
    return [self colorWithRed:red/255.f green:green/255.f blue:blue/255.f alpha:alpha];
}

+ (UIColor *)ss_colorWithLightColor:(UIColor *)lightColor darkColor:(UIColor *)darkColor
{
    NSParameterAssert(lightColor);
    if (@available(iOS 13.0, *)) {
        NSParameterAssert(darkColor);
        return [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull trainCollection) {
            if (trainCollection.userInterfaceStyle == UIUserInterfaceStyleLight) {
                return lightColor;
            }
            return darkColor;
        }];
    }
    return lightColor;
}

+ (UIColor *)ss_colorWithLightColorHex:(NSString *)lightColorHex darkColorHex:(NSString *)darkColorHex
{
    return [self ss_colorWithLightColor:SSColorHex(lightColorHex) darkColor:SSColorHex(darkColorHex)];
}

+ (UIColor *)ss_colorWithLightColorHex:(NSString *)lightColorHex
                       lightColorAlpha:(CGFloat)lightColorAlpha
                          darkColorHex:(NSString *)darkColorHex
                        darkColorAlpha:(CGFloat)darkColorAlpha
{
    return [self ss_colorWithLightColor:SSColorHexAlpha(lightColorHex,lightColorAlpha) darkColor:SSColorHexAlpha(darkColorHex,darkColorAlpha)];
}

#pragma mark - pink

+ (UIColor *)pink
{
    return SSColorHex(@"#FFC0CB");
}

+ (UIColor *)pinkLight
{
    return SSColorHex(@"#FFB6C1");
}

+ (UIColor *)pinkLightSalmon
{
    return SSColorHex(@"#FFA07A");
}

+ (UIColor *)pinkCoral
{
    return SSColorHex(@"#FF7F50");
}

+ (UIColor *)pinkLightCoral
{
    return SSColorHex(@"#F08080");
}

#pragma mark - red

+ (UIColor *)redBlood
{
    return SSColorHex(@"#DC143C");
}

+ (UIColor *)redLavenderBlush
{
    return SSColorHex(@"#FFF0F5");
}

+ (UIColor *)redPaleViolet
{
    return SSColorHex(@"#DB7093");
}

+ (UIColor *)redTomato
{
    return SSColorHex(@"#FF6347");
}

+ (UIColor *)redDark
{
    return SSColorHex(@"#8B0000");
}

+ (UIColor *)redFireBrick
{
    return SSColorHex(@"#B22222");
}

#pragma mark - purple

+ (UIColor *)purpleDarkMagenta
{
    return SSColorHex(@"#8B008B");
}

+ (UIColor *)purpleMediumOrchid
{
    return SSColorHex(@"#BA55D3");
}

+ (UIColor *)purpleDarkOrchid
{
    return SSColorHex(@"#9932CC");
}

+ (UIColor *)purpleBlueViolet
{
    return SSColorHex(@"#8A2BE2");
}

+ (UIColor *)purpleMedium
{
    return SSColorHex(@"#9370DB");
}

+ (UIColor *)purpleLightLavender
{
    return SSColorHex(@"#E6E6FA");
}

#pragma mark - blue

+ (UIColor *)blueSlate
{
    return SSColorHex(@"#6A5ACD");
}

+ (UIColor *)blueMediumSlate
{
    return SSColorHex(@"#7B68EE");
}

+ (UIColor *)blueDarkSlate
{
    return SSColorHex(@"#483D8B");
}

+ (UIColor *)blueMidnight
{
    return SSColorHex(@"#191970");
}

+ (UIColor *)blueDark
{
    return SSColorHex(@"#00008B");
}

+ (UIColor *)blueRoyal
{
    return SSColorHex(@"#4169E1");
}

+ (UIColor *)clueCornflower
{
    return SSColorHex(@"#6495ED");
}

+ (UIColor *)blueLightSteel
{
    return SSColorHex(@"#B0C4DE");
}

+ (UIColor *)blueDoder
{
    return SSColorHex(@"#1E90FF");
}

+ (UIColor *)blueSteel
{
    return SSColorHex(@"#4682B4");
}

+ (UIColor *)blueLightSky
{
    return SSColorHex(@"#87CEFA");
}

+ (UIColor *)blueSky
{
    return SSColorHex(@"#87CEEB");
}

+ (UIColor *)blueCadet
{
    return SSColorHex(@"#5F9EA0");
}

#pragma mark - green

+ (UIColor *)greenDarkSlate
{
    return SSColorHex(@"#2F4F4F");
}

+ (UIColor *)greenDarkCyan
{
    return SSColorHex(@"#008B8B");
}

+ (UIColor *)greenTeal
{
    return SSColorHex(@"#008080");
}

+ (UIColor *)greenMediumTurquoise
{
    return SSColorHex(@"#48D1CC");
}

+ (UIColor *)greenSea
{
    return SSColorHex(@"#2E8B57");
}

+ (UIColor *)greenLightSea
{
    return SSColorHex(@"#20B2AA");
}

+ (UIColor *)greenSpring
{
    return SSColorHex(@"#3CB371");
}

+ (UIColor *)greenHoneydew
{
    return SSColorHex(@"#F0FFF0");
}

+ (UIColor *)greenLight
{
    return SSColorHex(@"#90EE90");
}

#pragma mark - white

+ (UIColor *)whiteGhost
{
    return SSColorHex(@"#F8F8FF");
}

+ (UIColor *)whiteSmoke
{
    return SSColorHex(@"#F5F5F5");
}

+ (UIColor *)snow
{
    return SSColorHex(@"#FFFAFA");
}

#pragma mark - gray

+ (UIColor *)grayLightSlate
{
    return SSColorHex(@"#778899");
}

+ (UIColor *)graySlate
{
    return SSColorHex(@"#708090");
}

+ (UIColor *)grayGainsboro
{
    return SSColorHex(@"#DCDCDC");
}

+ (UIColor *)graySilver
{
    return SSColorHex(@"#C0C0C0");
}

+ (UIColor *)grayDark
{
    return SSColorHex(@"#A9A9A9");
}

+ (UIColor *)grayDim
{
    return SSColorHex(@"#696969");
}

#pragma mark - yellow

+ (UIColor *)yellowLightGoldenrod
{
    return SSColorHex(@"#FAFAD2");
}

+ (UIColor *)yellowIvory
{
    return SSColorHex(@"#FFFFF0");
}

+ (UIColor *)yellowLight
{
    return SSColorHex(@"#FFFFE0");
}

+ (UIColor *)gold
{
    return SSColorHex(@"#FFD700");
}

#pragma mark - orange

+ (UIColor *)orangeDark
{
    return SSColorHex(@"#FF8C00");
}

+ (UIColor *)orangeRed
{
    return SSColorHex(@"#FF4500");
}

@end
