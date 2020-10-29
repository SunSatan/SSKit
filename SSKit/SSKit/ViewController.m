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

@property (nonatomic, strong) UIImageView *imageView;


@end

@implementation ViewController

- (void)dealloc
{
    NSLog(@"ViewController -> dealloc");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"viewDidLoad");
    self.view.backgroundColor = UIColor.whiteColor;
    
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
    
    [self ss_navigationTitle:SSDeviceTool.diskFreeSizeString];
    self.text.text = [NSString stringWithFormat:@"%ld", [SSSystemConvert decimalFromBinary:@"1010" haveSigned:NO]];
    
//    _imageView = [UIImageView.alloc initWithFrame:self.view.bounds];
//    [self.view addSubview:_imageView];
    
//    UIImage *itemImage = [UIImage imageNamed:@"添加"];
//    itemImage = [itemImage ss_imageCropToRect:CGRectMake(0, 0, itemImage.size.width, itemImage.size.height)];
//    [self saveImageToPhotosAlbum:itemImage];
    
    [[[UIImage alloc] initWithContentsOfFile:[NSBundle.mainBundle pathForResource:@"IMG_1257" ofType:@"JPG"]] ss_imageCutApartForRow:2 column:3 resultImageSize:SS_1080P];
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
