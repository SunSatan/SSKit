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
#import <AVFoundation/AVFoundation.h>

#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

#import "SSCompassView.h"
#import "XMLReader.h"

@interface ViewController () <CLLocationManagerDelegate>

@property (nonatomic, strong) SSDeviceTool *tool;
@property (nonatomic, strong) UILabel *text;

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) SSCompassView *compassView;
@property (nonatomic, assign) bool isroot;
@property (nonatomic, strong) SSLocation *location;

@property (nonatomic, strong) SSDecibel *decibel;

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
    
    
    NSData *data = [NSData dataWithContentsOfFile:[NSBundle.mainBundle pathForResource:@"IMG_1257" ofType:@"JPG"]];
    [data ss_imageDataSaveToPhotosAlbumWithComplete:^(BOOL success) {
        if (success) {
            NSLog(@"保存成功");
        }
        else {
            NSLog(@"保存失败");
        }
    }];
    
    
//    UIImage *image = [UIImage imageWithData:data];
//    [image ss_saveToPhotosAlbumWithComplete:^(BOOL success) {
//        if (success) {
//            NSLog(@"保存成功");
//        }
//        else {
//            NSLog(@"保存失败");
//        }
//    }];
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
