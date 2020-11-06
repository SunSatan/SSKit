//
//  SSToolsViewController.m
//  PHILIPMobiletools
//
//  Created by 孙铭健 on 2020/11/3.
//

#import "SSToolsViewController.h"
#import <Masonry/Masonry.h>
#import "SSKit.h"

#import "ScreenTimeViewController.h"
#import "imageCompressViewController.h"
#import "CompassViewController.h"
#import "DecibelViewController.h"

@interface SSToolsViewController ()

@property (nonatomic, strong) UIImageView *topBackground;

@property (nonatomic, strong) UIView *compassView;
@property (nonatomic, strong) UIView *imageCompressView;
@property (nonatomic, strong) UIView *decibelView;
@property (nonatomic, strong) UIView *screenTimeView;
@property (nonatomic, strong) UIView *centerYLine;

@end

@implementation SSToolsViewController

- (void)dealloc
{
    NSLog(@"SSToolsViewController -> dealloc");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = SSColorRGB(240, 240, 240);
    [self ss_navigationBarTransparent];
    [self ss_navigationTitle:@"工具箱" textColor:UIColor.whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeTop;
    
    [self configCenterYLine];
    [self configTopBackground];
    [self configCompassView];
    [self configImageCompressView];
    [self configDecibelView];
    [self configScreenTimeView];
}

#pragma mark - click

- (void)clickToCompass
{
    NSLog(@"1");
    CompassViewController *vc = CompassViewController.new;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)clickToImageCompress
{
    NSLog(@"2");
    imageCompressViewController *vc = imageCompressViewController.new;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)clickToDecibelView
{
    NSLog(@"3");
    DecibelViewController *vc = DecibelViewController.new;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)clickToScreenTimeView
{
    NSLog(@"4");
    ScreenTimeViewController *vc = ScreenTimeViewController.new;
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - config view

- (void)configCenterYLine
{
    if (_centerYLine) return;
    
    _centerYLine = UIView.new;
    _centerYLine.backgroundColor = UIColor.clearColor;
    [self.view addSubview:_centerYLine];
    
    [_centerYLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.and.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(0.01);
    }];
}

- (void)configTopBackground
{
    if (_topBackground) return;
    
    _topBackground = UIImageView.new;
    _topBackground.contentMode = UIViewContentModeScaleToFill;
    _topBackground.image = SSImageNamed(@"icon_top_background");
    [self.view addSubview:_topBackground];
    
    [_topBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.mas_equalTo(self.view);
        make.height.mas_equalTo(180);
    }];
}

- (void)configCompassView
{
    if (_compassView) return;
    
    UIView *shadowView = UIView.new;
    [self.view addSubview:shadowView];
    shadowView.clipsToBounds = NO;
    shadowView.layer.shadowColor = SSColorRGBA(0, 0, 0, 0.2).CGColor;
    shadowView.layer.shadowOpacity = 1;
    shadowView.layer.shadowRadius = 8;
    shadowView.layer.cornerRadius = 8;
    shadowView.layer.shadowOffset = CGSizeMake(0, 2);
    [shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(20);
        make.right.mas_equalTo(self.view).offset(-20);
        make.top.mas_equalTo(SSScreen.navigationBarHeight + SSScreen.statusBarHeight + 10);
        make.height.mas_equalTo(80);
    }];
    
    _compassView = UIView.new;
    [shadowView addSubview:_compassView];
    
    _compassView.backgroundColor = UIColor.whiteColor;
    _compassView.clipsToBounds = YES;
    _compassView.layer.cornerRadius = 8;
    
    [_compassView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.mas_equalTo(shadowView);
    }];

    _compassView.userInteractionEnabled = YES;
    [_compassView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickToCompass)]];
    
    UILabel *title = UILabel.new;
    title.text = @"指南针";
    title.font = [UIFont systemFontOfSize:18];
    [_compassView addSubview:title];
    
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.compassView).offset(-5);
        make.left.mas_equalTo(self.compassView).offset(20);
    }];
    
    UILabel *tips = UILabel.new;
    tips.text = @"轻松辨别东南西北";
    tips.textColor = UIColor.lightGrayColor;
    tips.font = [UIFont systemFontOfSize:13];
    [_compassView addSubview:tips];
    
    [tips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.compassView).offset(20);
        make.top.mas_equalTo(title.mas_bottom).offset(2);
    }];
    
    UIImageView *image = UIImageView.new;
    [_compassView addSubview:image];
    
    image.image = SSImageNamed(@"形状结合");
    
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.compassView).offset(1);
        make.right.mas_equalTo(self.compassView).offset(-20);
        make.width.and.height.mas_equalTo(55);
    }];
}

- (void)configImageCompressView
{
    if (_imageCompressView) return;
    
    UIView *shadowView = UIView.new;
    [self.view addSubview:shadowView];
    shadowView.clipsToBounds = NO;
    shadowView.layer.shadowColor = SSColorRGBA(0, 0, 0, 0.2).CGColor;
    shadowView.layer.shadowOpacity = 1;
    shadowView.layer.shadowRadius = 8;
    shadowView.layer.cornerRadius = 8;
    shadowView.layer.shadowOffset = CGSizeMake(0, 2);
    [shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(20);
        make.right.mas_equalTo(self.view).offset(-20);
        make.top.mas_equalTo(self.compassView.mas_bottom).offset(10);
        make.height.mas_equalTo(80);
    }];
    
    _imageCompressView = UIView.new;
    [shadowView addSubview:_imageCompressView];
    
    _imageCompressView.backgroundColor = UIColor.whiteColor;
    _imageCompressView.clipsToBounds = YES;
    _imageCompressView.layer.cornerRadius = 8;
    
    [_imageCompressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.mas_equalTo(shadowView);
    }];

    _imageCompressView.userInteractionEnabled = YES;
    [_imageCompressView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickToImageCompress)]];
    
    UILabel *title = UILabel.new;
    title.text = @"图片压缩";
    title.font = [UIFont systemFontOfSize:18];
    [_imageCompressView addSubview:title];
    
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.imageCompressView).offset(-5);
        make.left.mas_equalTo(self.imageCompressView).offset(20);
    }];
    
    UILabel *tips = UILabel.new;
    tips.text = @"节约手机存储空间";
    tips.textColor = UIColor.lightGrayColor;
    tips.font = [UIFont systemFontOfSize:13];
    [_imageCompressView addSubview:tips];
    
    [tips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imageCompressView).offset(20);
        make.top.mas_equalTo(title.mas_bottom).offset(2);
    }];
    
    UIImageView *image = UIImageView.new;
    [_imageCompressView addSubview:image];
    
    image.image = SSImageNamed(@"compress");
    
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.imageCompressView).offset(1);
        make.right.mas_equalTo(self.imageCompressView).offset(-20);
        make.width.and.height.mas_equalTo(55);
    }];
}

- (void)configDecibelView
{
    if (_decibelView) return;
    
    UIView *shadowView = UIView.new;
    [self.view addSubview:shadowView];
    shadowView.clipsToBounds = NO;
    shadowView.layer.shadowColor = SSColorRGBA(0, 0, 0, 0.2).CGColor;
    shadowView.layer.shadowOpacity = 1;
    shadowView.layer.shadowRadius = 8;
    shadowView.layer.cornerRadius = 8;
    shadowView.layer.shadowOffset = CGSizeMake(0, 2);
    [shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(20);
        make.top.mas_equalTo(self.imageCompressView.mas_bottom).offset(10);
        make.height.mas_equalTo(60);
        make.right.mas_equalTo(self.centerYLine.mas_left).offset(-5);
    }];
    
    _decibelView = UIView.new;
    [shadowView addSubview:_decibelView];
    
    _decibelView.backgroundColor = UIColor.whiteColor;
    _decibelView.clipsToBounds = YES;
    _decibelView.layer.cornerRadius = 8;
    
    [_decibelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.mas_equalTo(shadowView);
    }];

    _decibelView.userInteractionEnabled = YES;
    [_decibelView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickToDecibelView)]];
    
    UILabel *title = UILabel.new;
    title.text = @"噪音检测";
    title.font = [UIFont systemFontOfSize:18];
    [_decibelView addSubview:title];
    
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.decibelView);
        make.left.mas_equalTo(self.decibelView).offset(20);
    }];
    
    UIImageView *image = UIImageView.new;
    [_decibelView addSubview:image];
    
    image.image = SSImageNamed(@"编组");
    
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.decibelView).offset(1);
        make.right.mas_equalTo(self.decibelView).offset(-10);
        make.width.and.height.mas_equalTo(55);
    }];
}

- (void)configScreenTimeView
{
    if (_screenTimeView) return;
    
    UIView *shadowView = UIView.new;
    [self.view addSubview:shadowView];
    shadowView.clipsToBounds = NO;
    shadowView.layer.shadowColor = SSColorRGBA(0, 0, 0, 0.2).CGColor;
    shadowView.layer.shadowOpacity = 1;
    shadowView.layer.shadowRadius = 8;
    shadowView.layer.cornerRadius = 8;
    shadowView.layer.shadowOffset = CGSizeMake(0, 2);
    [shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.centerYLine.mas_right).offset(5);
        make.top.mas_equalTo(self.imageCompressView.mas_bottom).offset(10);
        make.height.mas_equalTo(60);
        make.right.mas_equalTo(self.view).offset(-20);
    }];
    
    _screenTimeView = UIView.new;
    [shadowView addSubview:_screenTimeView];
    
    _screenTimeView.backgroundColor = UIColor.whiteColor;
    _screenTimeView.clipsToBounds = YES;
    _screenTimeView.layer.cornerRadius = 8;
    
    [_screenTimeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.mas_equalTo(shadowView);
    }];

    _screenTimeView.userInteractionEnabled = YES;
    [_screenTimeView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickToScreenTimeView)]];
    
    UILabel *title = UILabel.new;
    title.text = @"屏幕时间";
    title.font = [UIFont systemFontOfSize:18];
    [_screenTimeView addSubview:title];
    
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.screenTimeView);
        make.left.mas_equalTo(self.screenTimeView).offset(20);
    }];
    
    UIImageView *image = UIImageView.new;
    [_screenTimeView addSubview:image];
    
    image.image = SSImageNamed(@"time");
    
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.screenTimeView).offset(1);
        make.right.mas_equalTo(self.screenTimeView.mas_right).offset(-10);
        make.width.and.height.mas_equalTo(55);
    }];
}

@end
