//
//  UITableViewCell+SSSectionCorner.m
//  widget
//
//  Created by 孙铭健 on 2020/9/25.
//

#import "UITableViewCell+SSSectionCorner.h"
#import <objc/runtime.h>

@interface UITableViewCell ()

@property(nonatomic,strong) UIView *cornerV;
@property(nonatomic,strong) CAShapeLayer *topLay;
@property(nonatomic,strong) CAShapeLayer *bottomLay;

@end

@implementation UITableViewCell (SSSectionCorner)

-(void)ss_addSectionCornerWithTableView:(UITableView *)tableView
                              indexPath:(NSIndexPath *)indexPath
                        cornerViewframe:(CGRect)frame
                           cornerRadius:(CGFloat)cornerRadius{
    
    if (self.cornerV == nil) {
        UIView *backV = [[UIView alloc] initWithFrame:frame];
        backV.backgroundColor = [UIColor whiteColor];
        backV.tag = 20170802;
        [self.contentView insertSubview:backV atIndex:0];
        self.cornerV = backV;
        self.backgroundColor = [UIColor clearColor];
    }
    
    if ([tableView numberOfRowsInSection:indexPath.section] == 1) {
        if (self.topLay == nil) {
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.cornerV.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = self.cornerV.bounds;
            maskLayer.path = maskPath.CGPath;
            self.topLay = maskLayer;
        }
        self.cornerV.layer.mask = self.topLay;
    }
    else if (indexPath.row == 0) {
        if (self.topLay == nil) {
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.cornerV.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight  cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = self.cornerV.bounds;
            maskLayer.path = maskPath.CGPath;
            self.topLay = maskLayer;
        }
        self.cornerV.layer.mask = self.topLay;
    }
    else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section] - 1){
        if (self.bottomLay == nil) {
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.cornerV.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight  cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = self.cornerV.bounds;
            maskLayer.path = maskPath.CGPath;
            self.bottomLay = maskLayer;
        }
       self.cornerV.layer.mask = self.bottomLay;
    }
    else {
        self.cornerV.layer.mask = nil;
    }
}
 
-(void)setCornerV:(UIView *)cornerV{
    objc_setAssociatedObject(self, @selector(cornerV), cornerV, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
 
-(UIView *)cornerV{
    return objc_getAssociatedObject(self, _cmd);
}
-(void)setTopLay:(CAShapeLayer *)topLay{
    objc_setAssociatedObject(self, @selector(topLay), topLay, OBJC_ASSOCIATION_RETAIN);
}
-(CAShapeLayer *)topLay{
    return objc_getAssociatedObject(self, _cmd);
}
 
-(void)setBottomLay:(CAShapeLayer *)bottomLay{
    objc_setAssociatedObject(self, @selector(bottomLay), bottomLay, OBJC_ASSOCIATION_RETAIN);
}
-(CAShapeLayer *)bottomLay{
    return objc_getAssociatedObject(self, _cmd);
}


@end
