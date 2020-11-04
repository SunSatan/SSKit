//
//  SSIndexBar.h
//  SSIndexBar
//
//  Created by SunSatan on 2020/8/31.
//  Copyright © 2020 SunSatan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SSIndexBar;

typedef void(^indexDidChangedBlock)(NSInteger index, NSString *title);

@protocol SSIndexBarDelegate <NSObject>

- (void)SSIndexBar:(SSIndexBar *)indexBar indexDidChanged:(NSInteger)index title:(NSString *)title;

@end

@interface SSIndexBar : UIView  // 微信索引条

- (void)reloadData; //刷新数据，会重绘所有label。

@property (nonatomic, strong) NSArray<NSString *> *indexSource; //设置索引数据源
@property (nonatomic, assign) NSInteger selectedIndex; //设置当前选中的索引

//提供了代理和 block 两种回调方式
@property (nonatomic, copy) indexDidChangedBlock indexDidChangedBlock;
@property (nonatomic, weak) id <SSIndexBarDelegate> delegate;

//SSIndexBar 会根据 rowHeight 自动调整frame的高度和位置。自定义每个label的高度，默认16。
@property (nonatomic, assign) CGFloat rowHeight;

@property (nonatomic, assign) BOOL canClick;    //能否触发点击，不影响滑动的触发，默认开启
@property (nonatomic, assign) BOOL canSwipe;    //能否触发滑动，不影响点击的触发，默认开启
@property (nonatomic, assign) BOOL canFeedback; //是否开启震动反馈，默认开启

@property (nonatomic, assign) BOOL animation;      //是否开启提示视图的动画效果，默认开启
@property (nonatomic, assign) BOOL tipsViewHidden; //是否隐藏提示视图，默认不隐藏

@property (nonatomic, strong) UIFont *textNormalFont; //文本正常样式字体
@property (nonatomic, strong) UIFont *textSelectFont; //文本选中样式字体

@property (nonatomic, strong) UIColor *textNormalColor; //文本正常样式颜色
@property (nonatomic, strong) UIColor *textSelectColor; //文本选中样式颜色

@property (nonatomic, strong) UIColor *backgroundNormalColor; //label背景正常颜色
@property (nonatomic, strong) UIColor *backgroundSelectColor; //label背景选中颜色

@property (nonatomic, assign) CGSize  tipsViewSize;     //提示视图的宽高，默认为60
@property (nonatomic, assign) CGFloat tipsViewPosition; //提示视图的位置，默认为-80，即在indexBar的左边

@property (nonatomic, strong) UIColor *tipsViewDrawColor; //提示视图的背景颜色
@property (nonatomic, strong) UIColor *tipsViewTextColor; //提示视图的文本颜色

- (instancetype)initWithFrame:(CGRect)frame NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithCoder:(NSCoder *)coder NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
