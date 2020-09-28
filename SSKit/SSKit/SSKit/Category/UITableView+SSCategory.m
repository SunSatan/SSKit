//
//  UITableView+SSCategory.m
//  widget
//
//  Created by 孙铭健 on 2020/9/27.
//

#import "UITableView+SSCategory.h"

@implementation UITableView (SSCategory)

- (void)ss_hiddenCellUnderline
{
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
}

@end
