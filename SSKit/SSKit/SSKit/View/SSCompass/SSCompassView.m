//
//  SSCompassView.m
//  SSKit
//
//  Created by SunSatan on 2020/10/27.
//  Copyright © 2020 SunSatan. All rights reserved.
//

#import "SSCompassView.h"

@interface SSCompassView ()

@property (nonatomic, strong) UIView *compassView;         // 刻度盘
@property (nonatomic, strong) UIView *crossHorizontalLine; // 中心十字横线
@property (nonatomic, strong) UIView *crossVerticalLine;   // 中心十字横线
@property (nonatomic, strong) UIView *headDirectionLine;   // 手机方向指示线

@end

@implementation SSCompassView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self defaultConfig];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    if (self = [super initWithCoder:coder]) {
        [self defaultConfig];
    }
    return self;
}

- (void)defaultConfig
{
    self.backgroundColor = UIColor.clearColor;
    self.clipsToBounds = YES;
    
    _thickLineLength = 20;
    _thinLineLength  = 10;
    _headDirectionLineWidth = 2;
    _headDirectionLineHeight = 60;
    _crossLineWidth = 80;
    _crossLineHeight = 0.5;
    
    _compassView.backgroundColor = UIColor.clearColor;
    _compassView = [UIView.alloc initWithFrame:self.bounds];
    _compassView.clipsToBounds = YES;
    [self addSubview:_compassView];
    
    [self redrawCompass];
}

# pragma mark - 绘制

- (void)redrawCompass
{
    for (UIView *subview in _compassView.subviews) {
        [subview removeFromSuperview];
    }
    [self drawCompassLine];
    
    [self drawHeadDirectionLine];
    [self drawCrossHorizontalLine];
    [self drawCrossVerticalLine];
}

- (void)drawHeadDirectionLine
{
    if (!_headDirectionLine) {
        _headDirectionLine = [UIView.alloc init];
        [self addSubview:_headDirectionLine];
    }
    _headDirectionLine.backgroundColor = self.headDirectionLineColor;
    CGFloat x = self.center.x - (_headDirectionLineWidth / 2);
    _headDirectionLine.frame = CGRectMake(x, 0, _headDirectionLineWidth, _headDirectionLineHeight);
}

- (void)drawCrossHorizontalLine
{
    if (!_crossHorizontalLine) {
        _crossHorizontalLine = [UIView.alloc init];
        [self addSubview:_crossHorizontalLine];
    }
    _crossHorizontalLine.backgroundColor = self.crossLineColor;
    _crossHorizontalLine.frame = CGRectMake(0, 0, _crossLineWidth, _crossLineHeight);
    _crossHorizontalLine.center = self.center;
}

- (void)drawCrossVerticalLine
{
    if (!_crossVerticalLine) {
        _crossVerticalLine = [UIView.alloc init];
        [self addSubview:_crossVerticalLine];
    }
    _crossVerticalLine.backgroundColor = self.crossLineColor;
    _crossVerticalLine.frame = CGRectMake(0, 0, _crossLineHeight, _crossLineWidth);
    _crossVerticalLine.center = self.center;
}

- (void)drawCompassLine
{
    CGFloat perAngle = M_PI/(90); // 每度的角度
    NSArray *array = @[@"北",@"东",@"南",@"西"];
    
    //画圆环，每隔2°画一个弧线，总共180条
    for (int i = 0; i < 180; i++) {
        
        CGFloat startAngle = (-(M_PI_2+M_PI/180/2)+perAngle*i);
        CGFloat endAngle = startAngle+perAngle/2;
        
        UIBezierPath *bezPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/2)
                                                               radius:(self.frame.size.width/2 - 50)
                                                           startAngle:startAngle
                                                             endAngle:endAngle
                                                            clockwise:YES];
        CAShapeLayer *shapeLayer = CAShapeLayer.layer;
        
        if (i%15 == 0) {
            shapeLayer.strokeColor = [[UIColor whiteColor] CGColor];
            shapeLayer.lineWidth = 10;
        } else {
            shapeLayer.strokeColor = [[UIColor grayColor] CGColor];
            shapeLayer.lineWidth = 10;
        }
        
        shapeLayer.path = bezPath.CGPath;
        shapeLayer.fillColor = [UIColor clearColor].CGColor;
        [_compassView.layer addSublayer:shapeLayer];
        
        if (i % 15 == 0) {
            //刻度的标注 0 30 60...
            NSString *tickText = [NSString stringWithFormat:@"%d",i * 2];
            CGFloat textAngel = startAngle+(endAngle-startAngle)/2;
            CGPoint point = [self calculateTextPositonWithArcCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/2)
                                                              Angle:textAngel andScale:1.2];
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(point.x, point.y, 30, 15)];
            label.center = point;
            label.text = tickText;
            label.textColor = [UIColor whiteColor];
            label.font = [UIFont systemFontOfSize:15];
            label.textAlignment = NSTextAlignmentCenter;
            [_compassView addSubview:label];
            
            if (i%45 == 0){
                //北 东 南 西
                tickText = array[i/45];
                CGPoint point2 = [self calculateTextPositonWithArcCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/2)
                                                                   Angle:textAngel andScale:0.8];
                UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(point2.x, point2.y, 30, 20)];
                label.center = point2;
                label.text = tickText;
                label.textColor = [UIColor whiteColor];
                label.font = [UIFont systemFontOfSize:20];
                label.textAlignment = NSTextAlignmentCenter;
                if ([tickText isEqualToString:@"北"]) {
                    UILabel * markLabel = [[UILabel alloc]initWithFrame:CGRectMake(point.x, point.y, 8, 8)];
                    markLabel.center = CGPointMake(point.x, point.y + 12);
                    markLabel.clipsToBounds = YES;
                    markLabel.layer.cornerRadius = 4;
                    markLabel.backgroundColor = [UIColor redColor];
                    [_compassView addSubview:markLabel];
                }
                [_compassView addSubview:label];
            }
        }
    }
}

//计算中心坐标
- (CGPoint)calculateTextPositonWithArcCenter:(CGPoint)center
                                       Angle:(CGFloat)angel
                                    andScale:(CGFloat)scale
{
    CGFloat x = (self.frame.size.width / 2 - 50) * scale * cosf(angel);
    CGFloat y = (self.frame.size.width / 2 - 50) * scale * sinf(angel);
    return CGPointMake(center.x + x, center.y + y);
}

#pragma mark - 方向变换

- (void)changeHeadDirection:(CGFloat)headDirection
{
    _compassView.transform = CGAffineTransformMakeRotation(headDirection); //旋转刻度盘
    //旋转文字
    for (UILabel * label in _compassView.subviews) {
        label.transform = CGAffineTransformMakeRotation(-headDirection);
    }
}

#pragma mark - setter and getter

- (UIColor *)thickLineColor
{
    return _thinLineColor ? _thinLineColor : UIColor.whiteColor;
}

- (UIColor *)thinLineColor
{
    return _thinLineColor ? _thinLineColor : UIColor.lightGrayColor;
}

- (UIFont *)degreeFont
{
    return _degreeFont ? _degreeFont : [UIFont systemFontOfSize:15];
}

- (UIColor *)degreeTextColor
{
    return _degreeTextColor ? _degreeTextColor : UIColor.whiteColor;
}

- (UIFont *)positionFont
{
    return _positionFont ? _positionFont : [UIFont systemFontOfSize:18];
}

- (UIColor *)positionTextColor
{
    return _positionTextColor ? _positionTextColor : UIColor.whiteColor;
}

- (UIColor *)headDirectionLineColor
{
    return _headDirectionLineColor ? _headDirectionLineColor : UIColor.whiteColor;
}

- (UIColor *)crossLineColor
{
    return _crossLineColor ? _crossLineColor : UIColor.whiteColor;
}

@end
