//
//  infoCell.m
//  PHILIPMobiletools
//
//  Created by 孙铭健 on 2020/11/4.
//

#import "infoCell.h"

@implementation infoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = UIColor.clearColor;
    self.contentView.backgroundColor = UIColor.whiteColor;
}

@end
