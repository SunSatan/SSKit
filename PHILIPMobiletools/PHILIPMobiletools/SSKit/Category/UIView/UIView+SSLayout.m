//
//  UIView+SSLayout.m
//  SSKit
//
//  Created by 孙铭健 on 2020/11/3.
//  Copyright © 2020 孙铭健. All rights reserved.
//

#import "UIView+SSLayout.h"

@implementation UIView (SSLayout)

/**
 * @dynamic告诉编译器属性的setter和getter方法都自己实现
 */

@dynamic origin;
@dynamic x;
@dynamic y;

@dynamic size;
@dynamic width;
@dynamic height;

@dynamic top;
@dynamic bottom;
@dynamic left;
@dynamic right;

@dynamic topLeft;
@dynamic topRight;
@dynamic bottomLeft;
@dynamic bottomRight;

#pragma mark - top

- (CGFloat)top
{
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)top
{
    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = frame;
}

#pragma mark - bottom

- (CGFloat)bottom
{
    return self.frame.size.height + self.frame.origin.y;
}

- (void)setBottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

#pragma mark - left

- (CGFloat)left
{
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)left
{
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = frame;
}

#pragma mark - right

- (CGFloat)right
{
    return self.frame.size.width + self.frame.origin.x;
}

- (void)setRight:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

#pragma mark - origin

- (CGPoint)origin
{
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

#pragma mark - x

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setX:(CGFloat)value
{
    CGRect frame = self.frame;
    frame.origin.x = value;
    self.frame = frame;
}

#pragma mark - y

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setY:(CGFloat)value
{
    CGRect frame = self.frame;
    frame.origin.y = value;
    self.frame = frame;
}

#pragma mark - centerX

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

#pragma mark - centerY

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

#pragma mark - size

- (CGSize)size
{
    return self.frame.size;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

#pragma mark - width

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

#pragma mark - height

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

#pragma mark - topLeft

- (CGPoint)topLeft
{
    return self.origin;
}

#pragma mark - topRight

- (CGPoint)topRight
{
    return CGPointMake(self.x+self.width, self.y);
}

#pragma mark - bottomLeft

- (CGPoint)bottomLeft
{
    return CGPointMake(self.x, self.y+self.height);
}

#pragma mark - bottomRight

- (CGPoint)bottomRight
{
    return CGPointMake(self.x+self.width, self.y+self.height);
}


@end
