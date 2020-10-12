//
//  UITableViewCell+SSSectionCorner.h
//  widget
//
//  Created by 孙铭健 on 2020/9/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableViewCell (SSSectionCorner)

/**
 画 tableView 每个 section 的圆角，要在 tableView:willDisplayCell:forRowAtIndexPath: 中调用。
 @param tableView tableView
 @param indexPath cell的索引
 @param cornerRadius 圆角大小
*/
- (void)ss_addSectionCornerWithTableView:(UITableView *)tableView
                               indexPath:(NSIndexPath *)indexPath
                            cornerRadius:(CGFloat)cornerRadius;


@end

NS_ASSUME_NONNULL_END
