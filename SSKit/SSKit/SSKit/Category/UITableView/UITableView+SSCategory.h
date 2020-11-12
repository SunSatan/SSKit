//
//  UITableView+SSCategory.h
//  widget
//
//  Created by SunSatan on 2020/9/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (SSCategory)
/// 隐藏下划线
- (void)ss_hiddenCellUnderline;
/**
 * 添加 tableView 的 HeaderView
 * @param view HeaderView
 */
- (void)ss_addTableHeaderView:(UIView *)view;
/**
 * 添加 tableView 的 FooterView
 * @param view FooterView
 */
- (void)ss_addTableFooterView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
