//
//  SSIndexTipsView.m
//  SSIndexBar
//
//  Created by SunSatan on 2020/8/31.
//  Copyright © 2020 SunSatan. All rights reserved.
//

#import "SSIndexTipsView.h"

@implementation SSIndexTipsView

- (void)dealloc
{
    NSLog(@"SSIndexTipsView -----> dealloc");
}

#pragma mark - init

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self config];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    if (self = [super initWithCoder:coder]) {
        [self config];
    }
    return self;
}

#pragma mark - layoutSubviews

- (void)layoutSubviews
{
    CGFloat width = self.bounds.size.width / (1 + sqrt(2)) * 2;
    CGFloat y = (self.bounds.size.width - width) * 0.5;
    _tipsLabel.frame = CGRectMake(0, y, width, width);
}

#pragma mark - config

- (void)config
{
    //改变frame时，自动调用 drawRect
    self.contentMode = UIViewContentModeRedraw;
    self.backgroundColor = UIColor.clearColor;
    
    _drawColor = UIColor.lightGrayColor;
    [self addTipsLabel];
}

- (void)addTipsLabel
{
    _tipsLabel = [UILabel new];
    _tipsLabel.textColor = UIColor.whiteColor;
    _tipsLabel.textAlignment = NSTextAlignmentCenter;
    _tipsLabel.font = [UIFont boldSystemFontOfSize:30];
    _tipsLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:_tipsLabel];
}

#pragma mark - setter

- (void)setDrawColor:(UIColor *)drawColor
{
    _drawColor = drawColor;
    [self setNeedsDisplay];
}

#pragma mark - draw

- (void)drawRect:(CGRect)rect
{
    [self drawWaterDropShapeRightInRect:rect fillColor:_drawColor];
}

- (void)drawWaterDropShapeRightInRect:(CGRect)rect fillColor:(UIColor *)fillColor
{
    [fillColor setFill];
    
    CGFloat radius = rect.size.width / (1 + sqrt(2));
    CGPoint center = CGPointMake(radius, rect.size.height * 0.5);
    CGFloat startAngle = M_PI_4;
    CGFloat endAngle   = 2 * M_PI - startAngle;
    
    UIBezierPath *pathSemicircle = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    [pathSemicircle fill];
    
    CGFloat semicircleCutX        = radius * (1 + cos(startAngle)) - 0.2; //0.2是误差，不然中间会有白线
    CGFloat semicircleCutTopY     = center.y + radius * sin(startAngle);
    CGFloat semicircleCutBottomY  = center.y - radius * sin(startAngle);
    CGPoint semicircleTopPoint    = CGPointMake(semicircleCutX, semicircleCutTopY);
    CGPoint semicircleBottomPoint = CGPointMake(semicircleCutX, semicircleCutBottomY);
    CGPoint rectRightCenter       = CGPointMake(rect.size.width, center.y);
    
    UIBezierPath *pathTriangle = [UIBezierPath new];
    [pathTriangle moveToPoint:rectRightCenter];
    [pathTriangle addLineToPoint:semicircleTopPoint];
    [pathTriangle addLineToPoint:semicircleBottomPoint];
    [pathTriangle closePath];
    [pathTriangle fill];
}

@end
