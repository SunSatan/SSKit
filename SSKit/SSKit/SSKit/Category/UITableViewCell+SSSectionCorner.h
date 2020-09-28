//
//  UITableViewCell+SSSectionCorner.h
//  widget
//
//  Created by 孙铭健 on 2020/9/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableViewCell (SSSectionCorner)

- (void)ss_addSectionCornerWithTableView:(UITableView *)tableView
                               indexPath:(NSIndexPath *)indexPath
                            cornerRadius:(CGFloat)cornerRadius;


@end

NS_ASSUME_NONNULL_END
