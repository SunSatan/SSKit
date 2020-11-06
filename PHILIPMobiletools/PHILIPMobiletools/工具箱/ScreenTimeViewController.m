//
//  ScreenTimeViewController.m
//  PHILIPMobiletools
//
//  Created by 孙铭健 on 2020/11/6.
//

#import "ScreenTimeViewController.h"
#import "SSKit.h"

@interface ScreenTimeViewController ()

@property (nonatomic, strong) SSTimer *timer;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *dateCN;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;

@end

@implementation ScreenTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    @weakify;
    _timer = [SSTimer scheduledTimerWithTimeInterval:1 target:self repeats:YES block:^(NSTimer * _Nonnull timer) {
        @strongify;
        self.time.text = [SSDateMainHelper HHMMSS_stringFromDate:NSDate.date];
        self.dateCN.text = [NSString stringWithFormat:@"%@ %@",
                            [SSDateMainHelper cn_MD_stringFromDate:NSDate.date],
                            [SSDateMainHelper weekdayStringFromDate:NSDate.date]];
    }];
    
}

- (BOOL)shouldAutorotate
{
    return NO;
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationLandscapeRight;
}

- (IBAction)clickToBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
