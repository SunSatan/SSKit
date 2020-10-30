//
//  ViewController.m
//  SSKit
//
//  Created by SunSatan on 2020/9/17.
//  Copyright © 2020 SunSatan. All rights reserved.
//

#import "ViewController.h"
#import "SSKit.h"
#import <HealthKit/HealthKit.h>
#import <CoreMotion/CoreMotion.h>

#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

#import "SSCompassView.h"

@interface ViewController () <CLLocationManagerDelegate>

@property (nonatomic, strong) SSDeviceTool *tool;
@property (nonatomic, strong) CLLocationManager *location;
@property (nonatomic, strong) UILabel *text;

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) SSCompassView *compassView;
@property (nonatomic, assign) bool isroot;

@end

@implementation ViewController

- (void)dealloc
{
//    [SSMotion.main stopUpdateAltitude];
    NSLog(@"ViewController -> dealloc");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"viewDidLoad");
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self ss_navigationBarHiddenUnderline];
    [self ss_navigationBarImageBackButton:@"icon_back_black"];
    self.view.backgroundColor = SSColorLightAndDark(UIColor.redBlood, UIColor.blueDoder);
    
    self.text = [[UILabel alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.text];
    self.text.textAlignment = NSTextAlignmentCenter;
    self.text.numberOfLines = 0;
    
    if (_isroot) {
        @weakify;
//        [SSMotion.main startUpdatePressure:^(double pressure) {
//            @strongify;
//            NSLog(@"=====");
//            self.text.text = [NSString stringWithFormat:@"%.2lf kPa", pressure];
//        }];
        
        SSLocation.share.target = self;
        [SSLocation.share startUpdatingLocation];
        SSLocation.share.altitudeDataBack = ^(double altitude) {
            @strongify;
            NSLog(@"-----");
            self.text.text = [NSString stringWithFormat:@"%.2lfm 海拔", altitude];
        };
    }
//    _compassView = [SSCompassView.alloc initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 30, self.view.frame.size.width - 30)];
//    _compassView.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
//    [self.view addSubview:_compassView];
}

- (void)viewWillDisappear:(BOOL)animated
{
    
}

- (void)viewDidAppear:(BOOL)animated
{
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    ViewController *vc = ViewController.new;
    vc.isroot = YES;
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
