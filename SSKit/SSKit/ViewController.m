//
//  ViewController.m
//  SSKit
//
//  Created by 孙铭健 on 2020/9/17.
//  Copyright © 2020 孙铭健. All rights reserved.
//

#import "ViewController.h"
#import "SSKit.h"
#import <HealthKit/HealthKit.h>
#import <CoreMotion/CoreMotion.h>

#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

#import <sys/mount.h>
#import <mach/mach.h>
#include <sys/sysctl.h>

@interface ViewController () <CLLocationManagerDelegate>

@property (nonatomic, strong) SSDeviceTool *tool;
@property (nonatomic, strong) CLLocationManager *location;
@property (nonatomic, strong) UILabel *text;

@end

@implementation ViewController

- (void)dealloc
{
    NSLog(@"ViewController -> dealloc");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"viewDidLoad");
    self.view.backgroundColor = UIColor.whiteColor;
    self.navigationItem.title = SSDeviceTool.batteryMah;
//    [self ss_setNavigationTiTle:@"我的"];
    [self ss_navigationBarHiddenUnderline];
    [self ss_navigationBarImageBackButton:@"icon_back_black"];
    self.view.backgroundColor = SSColorLightAndDark(UIColor.redBlood, UIColor.blueDoder);
    
//    _location = [[CLLocationManager alloc] init];
//    _location.desiredAccuracy = kCLLocationAccuracyBest;
//    _location.delegate = self;
//    [_location requestAlwaysAuthorization];
//    [_location startUpdatingLocation];
    
    self.text = [[UILabel alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.text];
    self.text.textAlignment = NSTextAlignmentCenter;
    self.text.numberOfLines = 0;
//    self.text.text = [NSString stringWithFormat:@"%ld", [SSSystemConvert decimalFromBinary:@"1000"]];
    
//    self.text.text = [NSString stringWithFormat:@"%lu", (unsigned long)SSDeviceTool.deviceMemorySizeString];
//    self.text.text = [NSString stringWithFormat:@"%ld", SSDeviceTool.CPUFrequency];
//    NSLog(@"%ld", UIScreen.mainScreen.maximumFramesPerSecond);
//    NSLog(@"%@", NSBundle.mainBundle.infoDictionary);
//    NSLog(@"%@", UIDevice.currentDevice.localizedModel);
//    NSString *language = [[[NSBundle mainBundle] preferredLocalizations] objectAtIndex:0];
//    NSLog(@"%@", language);
//    NSLog(@"%lf", cpu_usage());
//    NSTimer *time = [NSTimer scheduledTimerWithTimeInterval:0.5 repeats:YES block:^(NSTimer * _Nonnull timer) {
//        [self GetCpuUsage];
//    }];
    
//    [self GetCpuUsage];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    for (CLLocation *location in locations) {
        self.text.text = [NSString stringWithFormat:@"纬度：%.2f \n 经度：%.2f \n 海拔：%.2f \n 水平精度：%.2f \n 垂直精度：%.2f \n 航向：%.2f \n 航向精度：%.2f \n 速度：%.2f \n 速度精度：%.2f", location.coordinate.latitude, location.coordinate.longitude, location.altitude, location.horizontalAccuracy, location.verticalAccuracy, location.course, location.courseAccuracy, location.speed, location.speedAccuracy];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}



@end
