//
//  HealthCell.m
//  PHILIPMobiletools
//
//  Created by 孙铭健 on 2020/11/5.
//

#import "HealthCell.h"

@interface HealthCell ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftMargin;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightMargin;

@end

@implementation HealthCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = UIColor.clearColor;
    self.contentView.backgroundColor = UIColor.clearColor;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _leftMargin.constant  = UIScreen.mainScreen.bounds.size.width/375 * 70;
    _rightMargin.constant = - UIScreen.mainScreen.bounds.size.width/375 * 25;
    
//    self.icon.backgroundColor = UIColor.redColor;
}

@end
