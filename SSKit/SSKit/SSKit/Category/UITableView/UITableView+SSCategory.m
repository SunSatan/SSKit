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

- (void)ss_addTableHeaderView:(UIView *)view
{
    self.tableHeaderView = [UIView.alloc initWithFrame:view.bounds];
    [self.tableHeaderView addSubview:view];
}

- (void)ss_addTableFooterView:(UIView *)view
{
    self.tableFooterView = [UIView.alloc initWithFrame:view.bounds];
    [self.tableFooterView addSubview:view];
}

@end
