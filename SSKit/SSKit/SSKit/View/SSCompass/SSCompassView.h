//
//  SSCompassView.h
//  SSKit
//
//  Created by SunSatan on 2020/10/27.
//  Copyright © 2020 SunSatan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SSCompassView : UIView
/**
 * 根据手机头的方向来改变指南针的转向
 * @param headDirection 手机头的方向
 */
- (void)changeHeadDirection:(CGFloat)headDirection;

#pragma mark - 自定义样式

/// 每次设定样式后，一定要重绘整个视图。
- (void)redrawCompass;

/// 粗线颜色
@property (nonatomic, strong) UIColor *thickLineColor;
/// 粗线长度
@property (nonatomic, assign) CGFloat thickLineLength;

/// 细线颜色
@property (nonatomic, strong) UIColor *thinLineColor;
/// 细线长度
@property (nonatomic, assign) CGFloat thinLineLength;

/// 角度字体 （30°）
@property (nonatomic, strong) UIFont *degreeFont;
/// 角度字体颜色 （30°）
@property (nonatomic, strong) UIColor *degreeTextColor;

/// 方位字体（东南西北）
@property (nonatomic, strong) UIFont *positionFont;
/// 方位字体颜色（东南西北）
@property (nonatomic, strong) UIColor *positionTextColor;

/// 方向指示线的颜色
@property (nonatomic, strong) UIColor *headDirectionLineColor;
/// 方向指示线的宽
@property (nonatomic, assign) CGFloat headDirectionLineWidth;
/// 方向指示线的高
@property (nonatomic, assign) CGFloat headDirectionLineHeight;

/// 十字线的颜色
@property (nonatomic, strong) UIColor *crossLineColor;
/// 十字线的宽
@property (nonatomic, assign) CGFloat crossLineWidth;
/// 十字线的高
@property (nonatomic, assign) CGFloat crossLineHeight;

@end

NS_ASSUME_NONNULL_END
