//
//  UITableViewCell+SSSectionCorner.m
//  widget
//
//  Created by 孙铭健 on 2020/9/25.
//

#import "UITableViewCell+SSSectionCorner.h"
#import <objc/runtime.h>

@interface UITableViewCell ()

@property (nonatomic, strong) CAShapeLayer *topLay;
@property (nonatomic, strong) CAShapeLayer *bottomLay;

@end

@implementation UITableViewCell (SSSectionCorner)

- (void)ss_addSectionCornerWithTableView:(UITableView *)tableView
                               indexPath:(NSIndexPath *)indexPath
                            cornerRadius:(CGFloat)cornerRadius
{
    if ([tableView numberOfRowsInSection:indexPath.section] == 1) {
        if (self.topLay == nil) {
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.contentView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = self.contentView.bounds;
            maskLayer.path = maskPath.CGPath;
            self.topLay = maskLayer;
        }
        self.contentView.layer.mask = self.topLay;
    }
    else if (indexPath.row == 0) {
        if (self.topLay == nil) {
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.contentView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight  cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = self.contentView.bounds;
            maskLayer.path = maskPath.CGPath;
            self.topLay = maskLayer;
        }
        self.contentView.layer.mask = self.topLay;
    }
    else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section] - 1){
        if (self.bottomLay == nil) {
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.contentView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight  cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = self.contentView.bounds;
            maskLayer.path = maskPath.CGPath;
            self.bottomLay = maskLayer;
        }
       self.contentView.layer.mask = self.bottomLay;
    }
    else {
        self.contentView.layer.mask = nil;
    }
}

- (void)setTopLay:(CAShapeLayer *)topLay
{
    objc_setAssociatedObject(self, @selector(topLay), topLay, OBJC_ASSOCIATION_RETAIN);
}

- (CAShapeLayer *)topLay
{
    return objc_getAssociatedObject(self, _cmd);
}
 
- (void)setBottomLay:(CAShapeLayer *)bottomLay
{
    objc_setAssociatedObject(self, @selector(bottomLay), bottomLay, OBJC_ASSOCIATION_RETAIN);
}

- (CAShapeLayer *)bottomLay
{
    return objc_getAssociatedObject(self, _cmd);
}


@end
