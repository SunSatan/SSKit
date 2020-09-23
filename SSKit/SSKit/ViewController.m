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

@interface ViewController ()

@property (nonatomic, strong) SSDeviceTool *tool;


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
    self.navigationItem.title = [NSString stringWithFormat:@"%@", SSDeviceTool.deviceLanguage];
//    [self ss_setNavigationTiTle:@"我的"];
    [self ss_navigationBarHiddenUnderline];
    [self ss_navigationBarCustomBackButton:@"icon_back_black"];
    self.view.backgroundColor = UIColor.redBlood;
    
    self.navigationItem.title = [NSString stringWithFormat:@"%ld", [SSHealthShare stepCountSumWithEndDate:[NSDate date] timeLengthMode:SSTimeModeDay timeIntervalMode:SSTimeModeDay]];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}


@end
