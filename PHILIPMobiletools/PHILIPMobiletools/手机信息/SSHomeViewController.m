//
//  SSHomeViewController.m
//  PHILIPMobiletools
//
//  Created by 孙铭健 on 2020/11/3.
//

#import "SSHomeViewController.h"
#import "SSKit.h"
#import "HomeModel.h"
#import "HomeCell.h"
#import <Masonry/Masonry.h>
#import "SSInfoViewController.h"

@interface SSHomeViewController ()

<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIImageView *topBackground;
@property (nonatomic, strong) UIImageView *banner;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation SSHomeViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = SSColorRGB(240, 240, 240);
    [self ss_navigationBarTransparent];
    [self ss_navigationTitle:@"手机信息" textColor:UIColor.whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeTop;
    
    [self configTopBackground];
    [self configTableView];
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
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(HomeCell.class)];
    
    HomeModel *model = self.dataArray[indexPath.section];
    cell.icon.image  = SSImageNamed(model.icon);
    cell.title.text  = model.title;
    cell.data1.text  = model.data1;
    cell.data2.text  = model.data2;
    cell.arrow.image = SSImageNamed(model.arrow);
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell ss_addSectionCornerWithTableView:tableView indexPath:indexPath cornerRadius:8];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SSInfoViewController *vc = SSInfoViewController.new;
    vc.type = indexPath.section;
    [self.navigationController pushViewController:vc animated:YES];
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
    _tableView.rowHeight = 100;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.sectionHeaderHeight = 0.01;
    _tableView.sectionFooterHeight = 0.01;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = UIColor.clearColor;
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass(HomeCell.class) bundle:nil]
     forCellReuseIdentifier:NSStringFromClass(HomeCell.class)];
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SSScreen.navigationBarHeight + SSScreen.statusBarHeight + 5);
        make.left.mas_equalTo(self.view).offset(15);
        make.right.mas_equalTo(self.view).offset(-15);
        make.bottom.mas_equalTo(self.view);
    }];
    
    _banner = [[UIImageView alloc] initWithImage:SSImageNamed(@"icon_banner")];
    _banner.frame = CGRectMake(0, 0, _tableView.bounds.size.width, 120);
    _tableView.tableHeaderView = _banner;
}

- (NSArray *)dataArray
{
    if (_dataArray) return _dataArray;
    
    HomeModel *model1 = HomeModel.new;
    model1.icon = @"基本信息";
    model1.title = @"基本信息";
    model1.data1 = SSDeviceTool.deviceName;
    model1.data2 = SSDeviceTool.deviceModel;
    model1.arrow = @"icon_arrow_right_blue";
    
    HomeModel *model2 = HomeModel.new;
    model2.icon = @"屏幕数据";
    model2.title = @"屏幕参数";
    model2.data1 = [NSString stringWithFormat:@"%@(分辨率)", SSScreen.screenRes];
    model2.data2 = [NSString stringWithFormat:@"%@(尺寸)", SSDeviceTool.screenSize];
    model2.arrow = @"icon_arrow_right_blue";
    
    HomeModel *model3 = HomeModel.new;
    model3.icon = @"处理器";
    model3.title = @"手机处理器";
    model3.data1 = SSDeviceTool.SocName;
    model3.data2 = [NSString stringWithFormat:@"%ld mHz", SSDeviceTool.CPUFrequency];
    model3.arrow = @"icon_arrow_right_blue";
    
    HomeModel *model4 = HomeModel.new;
    model4.icon = @"手机内存";
    model4.title = @"手机内存";
    model4.data1 = [NSString stringWithFormat:@"%@(总内存)", SSDeviceTool.memorySizeString];
    model4.data2 = [NSString stringWithFormat:@"%@(可用)", SSDeviceTool.memoryType];
    model4.arrow = @"icon_arrow_right_blue";
    
    HomeModel *model5 = HomeModel.new;
    model5.icon = @"手机存储";
    model5.title = @"手机存储";
    model5.data1 = [NSString stringWithFormat:@"%@(总存储)", SSDeviceTool.diskSizeString];
    model5.data2 = [NSString stringWithFormat:@"%@(可用)", SSDeviceTool.diskFreeSizeString];
    model5.arrow = @"icon_arrow_right_blue";
    
    _dataArray = @[model1, model2, model3, model4, model5];
    return _dataArray;
}

@end
