//
//  UIView+SSLayout.h
//  SSKit
//
//  Created by SunSatan on 2020/11/3.
//  Copyright © 2020 SunSatan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (SSLayout)

@property (nonatomic) CGPoint origin;
@property (nonatomic) CGFloat x;
@property (nonatomic) CGFloat y;

@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;

@property (nonatomic) CGSize  size;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;

@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat right;

@property (nonatomic, readonly) CGPoint topLeft;
@property (nonatomic, readonly) CGPoint topRight;
@property (nonatomic, readonly) CGPoint bottomLeft;
@property (nonatomic, readonly) CGPoint bottomRight;

@end

NS_ASSUME_NONNULL_END
