//
//  SSIndexTipsView.h
//  SSIndexBar
//
//  Created by SunSatan on 2020/8/31.
//  Copyright © 2020 SunSatan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SSIndexTipsView : UIView

@property (strong, nonatomic) UILabel *tipsLabel;
@property (strong, nonatomic) UIColor *drawColor;

- (instancetype)initWithFrame:(CGRect)frame NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithCoder:(NSCoder *)coder NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
