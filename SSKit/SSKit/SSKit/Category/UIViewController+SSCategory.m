//
//  UIViewController+SSCategory.m
//  SSKit
//
//  Created by 孙铭健 on 2020/9/18.
//  Copyright © 2020 孙铭健. All rights reserved.
//

#import "UIViewController+SSCategory.h"

@implementation UIViewController (SSCategory)

#pragma mark - navigation Transparent

- (void)ss_navigationBarTransparent;
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self ss_navigationBarHiddenUnderline];
}

- (void)ss_navigationBarNoTTransparent
{
    //导航栏的背景图和下划线都置空，就会回到默认的设置了
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self ss_navigationBarShowUnderline];
}

- (void)ss_navigationBarHiddenUnderline
{
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)ss_navigationBarShowUnderline
{
    [self.navigationController.navigationBar setShadowImage:nil];
}

#pragma mark - navigation title

- (void)ss_navigationTitle:(NSString *)title textColor:(UIColor *)textColor fontSize:(CGFloat)fontSize
{
    UILabel *titleLabel = [[UILabel alloc] init];
    if (fontSize > 0) {
        titleLabel.font = [UIFont boldSystemFontOfSize:fontSize];
    }
    if (textColor) {
        titleLabel.textColor = textColor;
    }
    
    titleLabel.text = title;
    self.navigationItem.titleView = titleLabel;
}

- (void)ss_navigationTitle:(NSString *)title
{
    [self ss_navigationTitle:title textColor:nil fontSize:17];
}

- (void)ss_navigationTitle:(NSString *)title textColor:(UIColor *)textColor
{
    [self ss_navigationTitle:title textColor:textColor fontSize:17];
}

- (void)ss_navigationTiTle:(NSString *)title fontSize:(CGFloat)fontSize
{
    [self ss_navigationTitle:title textColor:nil fontSize:fontSize];
}

#pragma mark - navigation push pop

- (void)ss_navigationAnimatedPushViewController:(UIViewController *)vc
{
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)ss_navigationNoAnimatedPushViewController:(UIViewController *)vc
{
    [self.navigationController pushViewController:vc animated:NO];
}

- (void)ss_navigationAnimatedPopViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)ss_navigationNoAnimatedPopViewController
{
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark -

- (void)ss_edgesExtendedForNone
{
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

#pragma mark - 

- (void)ss_navigationPopNotCover
{
    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
}

#pragma mark - navigation BarButtonItem

- (void)ss_navigationBarCustomBackButton:(NSString *)imageName
{
    NSParameterAssert(imageName);
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    [backBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(ss_navigationAnimatedPopViewController) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
}

@end
