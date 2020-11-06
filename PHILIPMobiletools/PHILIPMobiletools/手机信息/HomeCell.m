//
//  HomeCell.m
//  PHILIPMobiletools
//
//  Created by 孙铭健 on 2020/11/3.
//

#import "HomeCell.h"

@implementation HomeCell

- (void)setFrame:(CGRect)frame
{
    frame.origin.x += 5;
    frame.origin.y += 5;
    frame.size.height -= 10;
    frame.size.width -= 10;
    [super setFrame:frame];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = UIColor.clearColor;
    self.contentView.backgroundColor = UIColor.whiteColor;
    
    self.layer.shadowOpacity = 1;
    self.layer.shadowColor = [UIColor colorWithWhite:0 alpha:0.1].CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 2);
    self.layer.shadowRadius = 3;
    self.layer.shadowOpacity = 1;
}

@end
