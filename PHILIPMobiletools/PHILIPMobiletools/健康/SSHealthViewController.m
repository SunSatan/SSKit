//
//  SSHealthViewController.m
//  PHILIPMobiletools
//
//  Created by 孙铭健 on 2020/11/3.
//

#import "SSHealthViewController.h"
#import "SSKit.h"
#import "HealthModel.h"
#import "HealthCell.h"
#import <Masonry/Masonry.h>
#import "SSInfoViewController.h"
#import "SSHealth.h"

@interface SSHealthViewController ()

<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIImageView *topBackground;
@property (nonatomic, strong) UIImageView *banner;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation SSHealthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    self.view.backgroundColor = SSColorRGB(240, 240, 240);
    [self ss_navigationBarTransparent];
    [self ss_navigationTitle:@"健康" textColor:UIColor.whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeTop;
    
    [self configTopBackground];
    [self configTableView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [_tableView reloadData];
}

#pragma mark - <UITableViewDelegate>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HealthModel *model = self.dataArray[indexPath.section];
    
    HealthCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(HealthCell.class)];
//    cell.icon.contentMode = UIViewContentModeScaleToFill;
    [cell.icon setContentScaleFactor:[[UIScreen mainScreen] scale]];
    cell.icon.image  = SSImageNamed(model.icon);
    cell.text.attributedText  = model.healthString;
    cell.time.text  = model.time;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [cell ss_addSectionCornerWithTableView:tableView indexPath:indexPath cornerRadius:8];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - <Config Subview>

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

- (void)configTableView
{
    if (_tableView) return;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 80;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.sectionHeaderHeight = 0.01;
    _tableView.sectionFooterHeight = 0.01;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = UIColor.clearColor;
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass(HealthCell.class) bundle:nil]
     forCellReuseIdentifier:NSStringFromClass(HealthCell.class)];
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SSScreen.navigationBarHeight + SSScreen.statusBarHeight + 10);
        make.left.mas_equalTo(self.view).offset(10);
        make.right.mas_equalTo(self.view).offset(-10);
        make.bottom.mas_equalTo(self.view);
    }];
    
    _banner = [[UIImageView alloc] initWithImage:SSImageNamed(@"健康页banner")];
    _banner.frame = CGRectMake(0, 0, _tableView.bounds.size.width, 120);
    _tableView.tableHeaderView = _banner;
}

- (NSArray *)dataArray
{
    if (_dataArray) {
        _dataArray = nil;
    }
    
    HealthModel *model1 = HealthModel.new;
    model1.icon  = @"今日步数";
    model1.title = @"今日已走 ";
    model1.data = [NSString stringWithFormat:@"%ld", SSMotionMain.stepCountSumToday];
    model1.unit = @" 步";
    model1.time = [SSDateHelper.main HM_stringFromDate:NSDate.date];
    
    HealthModel *model2 = HealthModel.new;
    model2.icon = @"今日已走";
    model2.title = @"今日已走 ";
    if (SSMotionMain.stepDistanceToday < 1000) {
        model2.data = [NSString stringWithFormat:@"%ld", SSMotionMain.stepDistanceToday];
        model2.unit = @" 米";
    }
    else {
        model2.data = [NSString stringWithFormat:@"%.1lf", SSMotionMain.stepDistanceToday/1000.0];
        model2.unit = @" 公里";
    }
    model2.time = [SSDateHelper.main HM_stringFromDate:NSDate.date];
    
    HealthModel *model3 = HealthModel.new;
    model3.icon = @"今日已爬";
    model3.title = @"今日已爬 ";
    model3.data = [NSString stringWithFormat:@"%ld", SSMotionMain.floorUpCountToday];
    model3.unit = @" 楼层";
    model3.time = [SSDateHelper.main HM_stringFromDate:NSDate.date];
    
    HealthModel *model4 = HealthModel.new;
    model4.icon = @"最近心率";
    model4.title = @"最近心率 ";
    model4.data = [NSString stringWithFormat:@"%ld", SSHealthShare.heartRateLatestToday];
    model4.unit = @" 次/分";
    model4.time = [SSDateHelper.main HM_stringFromDate:NSDate.date];
    
    HealthModel *model5 = HealthModel.new;
    model5.icon = @"今日消耗";
    model5.title = @"今日能量消耗 ";
    model5.data = [NSString stringWithFormat:@"%ld", SSHealthShare.activeEnergyBurnedSumToday];
    model5.unit = @" 千卡";
    model5.time = [SSDateHelper.main HM_stringFromDate:NSDate.date];
    
    HealthModel *model6 = HealthModel.new;
    model6.icon = @"今日步行长度";
    model6.title = @"今日步行长度 ";
    model6.data = [NSString stringWithFormat:@"%ld", SSHealthShare.stepLengthLatestToday];
    model6.unit = @" 厘米";
    model6.time = [SSDateHelper.main HM_stringFromDate:NSDate.date];
    
    _dataArray = @[model1, model2, model3, model4, model5, model6];
    return _dataArray;
}

@end
