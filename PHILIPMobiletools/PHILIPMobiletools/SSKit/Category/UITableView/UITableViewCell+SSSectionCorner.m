//
//  UITableViewCell+SSSectionCorner.m
//  widget
//
//  Created by SunSatan on 2020/9/25.
//

#import "UITableViewCell+SSSectionCorner.h"
#import <objc/runtime.h>

@interface UITableViewCell ()

@property (nonatomic, strong) CAShapeLayer *allCorners;
@property (nonatomic, strong) CAShapeLayer *topCorners;
@property (nonatomic, strong) CAShapeLayer *bottomCorners;

@end

@implementation UITableViewCell (SSSectionCorner)

- (void)ss_separatorColor:(UIColor *)separatorColor
{
    UITableView *tableView = (UITableView *)self.superview;
    tableView.separatorColor = separatorColor;
}

- (void)ss_separatorInset
{
    UITableView *tableView = (UITableView *)self.superview;
    tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0) ;
}

- (void)ss_addSectionCornerWithTableView:(UITableView *)tableView
                               indexPath:(NSIndexPath *)indexPath
                            cornerRadius:(CGFloat)cornerRadius
{
//    self.contentView.clipsToBounds = YES;
    //创建圆角
    if (!self.allCorners) {
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.contentView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = self.contentView.bounds;
        maskLayer.path = maskPath.CGPath;
        self.allCorners = maskLayer;
    }
    if (!self.topCorners) {
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.contentView.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight  cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = self.contentView.bounds;
        maskLayer.path = maskPath.CGPath;
        self.topCorners = maskLayer;
    }
    if (!self.bottomCorners) {
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.contentView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight  cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = self.contentView.bounds;
        maskLayer.path = maskPath.CGPath;
        self.bottomCorners = maskLayer;
    }
    
    
    if ([tableView numberOfRowsInSection:indexPath.section] == 1) {
        //只有一个 row 则全圆角
        self.contentView.layer.mask = self.allCorners;
    }
    else if (indexPath.row == 0) {
        // 开始 row 则顶部圆角
        self.contentView.layer.mask = self.topCorners;
    }
    else if (indexPath.row == ([tableView numberOfRowsInSection:indexPath.section] - 1)){
        // 结束 row 则顶部圆角
       self.contentView.layer.mask = self.bottomCorners;
    }
    else {
        // 中间 row 则没有圆角
        self.contentView.layer.mask = nil;
    }
}

#pragma mark - setter && getter

- (void)setAllCorners:(CAShapeLayer *)allCorners
{
    objc_setAssociatedObject(self, @selector(allCorners), allCorners, OBJC_ASSOCIATION_RETAIN);
}

- (CAShapeLayer *)allCorners
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setTopCorners:(CAShapeLayer *)topCorners
{
    objc_setAssociatedObject(self, @selector(topCorners), topCorners, OBJC_ASSOCIATION_RETAIN);
}

- (CAShapeLayer *)topCorners
{
    return objc_getAssociatedObject(self, _cmd);
}
 
- (void)setBottomCorners:(CAShapeLayer *)bottomCorners
{
    objc_setAssociatedObject(self, @selector(bottomCorners), bottomCorners, OBJC_ASSOCIATION_RETAIN);
}

- (CAShapeLayer *)bottomCorners
{
    return objc_getAssociatedObject(self, _cmd);
}

@end
