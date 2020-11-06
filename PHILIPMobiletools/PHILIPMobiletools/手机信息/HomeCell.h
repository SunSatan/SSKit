//
//  HomeCell.h
//  PHILIPMobiletools
//
//  Created by 孙铭健 on 2020/11/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *data1;
@property (weak, nonatomic) IBOutlet UILabel *data2;
@property (weak, nonatomic) IBOutlet UIImageView *arrow;

@end

NS_ASSUME_NONNULL_END
