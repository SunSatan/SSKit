//
//  SSInfoViewController.m
//  PHILIPMobiletools
//
//  Created by 孙铭健 on 2020/11/4.
//

#import "SSInfoViewController.h"

#import "infoModel.h"
#import "infoCell.h"

#import "SSKit.h"
#import <Masonry/Masonry.h>

@interface SSInfoViewController ()

<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property (nonatomic, strong) UIImageView *topBackground;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) SSDeviceTool *tool;

@end

@implementation SSInfoViewController

- (void)dealloc
{
    _tool = nil;
    NSLog(@"SSInfoViewController -> dealloc");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = SSColorRGB(240, 240, 240);
    [self ss_navigationBarTransparent];
    [self ss_navigationBarImageBackButton:@"返回"];
    self.edgesForExtendedLayout = UIRectEdgeTop;
    [self ss_navigationPopNotCover];
    _tool = SSDeviceTool.new;
    
    [self configTitle];
    [self configTopBackground];
    [self configTableView];
}

- (void)configTitle
{
    switch (self.type) {
        case SSInfoTypeBasic:
            [self ss_navigationTitle:@"基本信息" textColor:UIColor.whiteColor];
            break;
        case SSInfoTypeScreen:
            [self ss_navigationTitle:@"屏幕数据" textColor:UIColor.whiteColor];
            break;
        case SSInfoTypeSoc:
            [self ss_navigationTitle:@"处理器"  textColor:UIColor.whiteColor];
            break;
        case SSInfoTypeMemory:
            [self ss_navigationTitle:@"手机内存" textColor:UIColor.whiteColor];
            break;
        case SSInfoTypeDisk:
            [self ss_navigationTitle:@"手机存储" textColor:UIColor.whiteColor];
            break;
    }
}

#pragma mark - <UITableViewDelegate>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray[section] count];
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 5;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 5;
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return UIView.new;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return UIView.new;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    infoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(infoCell.class)];
    
    infoModel *model = self.dataArray[indexPath.section][indexPath.row];
    cell.title.text  = model.title;
    cell.info.text  = model.info;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell ss_addSectionCornerWithTableView:tableView indexPath:indexPath cornerRadius:8];
    [cell ss_separatorInset];
    [cell ss_separatorColor:SSColorRGBA(240, 240, 240, 0.3)];
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
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 48;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.sectionHeaderHeight = 5;
    _tableView.sectionFooterHeight = 5;
//    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = UIColor.clearColor;
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass(infoCell.class) bundle:nil]
     forCellReuseIdentifier:NSStringFromClass(infoCell.class)];
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SSScreen.navigationBarHeight + SSScreen.statusBarHeight + 5);
        make.left.mas_equalTo(self.view).offset(15);
        make.right.mas_equalTo(self.view).offset(-15);
        make.bottom.mas_equalTo(self.view);
    }];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _tableView.scrollEnabled = (_tableView.contentSize.height > _tableView.bounds.size.height);
}

- (NSArray *)dataArray
{
    if (_dataArray) return _dataArray;
    
    switch (self.type) {
        case SSInfoTypeBasic:
            _dataArray = [self basicInfo];
            break;
        case SSInfoTypeScreen:
            _dataArray = [self screenInfo];
            break;
        case SSInfoTypeSoc:
            _dataArray = [self SocInfo];
            break;
        case SSInfoTypeMemory:
            _dataArray = [self memoryInfo];
            break;
        case SSInfoTypeDisk:
            _dataArray = [self diskInfo];
            break;
    }
    
    return _dataArray;
}

- (NSArray *)diskInfo
{
    infoModel *model = infoModel.new;
    model.title = @"总存储";
    model.info = SSDeviceTool.diskSizeString;
    
    infoModel *model1 = infoModel.new;
    model1.title = @"可用存储";
    model1.info = SSDeviceTool.diskFreeSizeString;
    
    infoModel *model2 = infoModel.new;
    model2.title = @"已用存储";
    model2.info = SSDeviceTool.diskUsedSizeString;
    
    infoModel *model3 = infoModel.new;
    model3.title = @"已使用率";
    model3.info = SSDeviceTool.diskUsageString;
    
    return @[@[model,  model1, model2, model3]];
}

- (NSArray *)memoryInfo
{
    infoModel *model = infoModel.new;
    model.title = @"总内存";
    model.info = SSDeviceTool.memorySizeString;
    
    infoModel *model1 = infoModel.new;
    model1.title = @"可用内存";
    model1.info = SSDeviceTool.memoryFreeSizeString;
    
    infoModel *model2 = infoModel.new;
    model2.title = @"内存使用率";
    model2.info = SSDeviceTool.memoryUsageString;
    @weakify;
    [_tool startMemoryUsageStringBlockWithTimeInterval:1
                                MemoryUsageStringBlock:^(NSString * _Nonnull usageString) {
        @strongify;
        if (!self.tool) return;
        
        infoModel *model = infoModel.new;
        model.title = @"内存使用率";
        model.info = usageString;
        
        NSIndexPath *index = [NSIndexPath indexPathForRow:2 inSection:0];
        
        NSMutableArray *array = [NSMutableArray arrayWithArray:self.dataArray[0]];
        array[index.row] = model;
        
        self.dataArray = @[array];
        [self.tableView reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationNone];
    }];
    
    infoModel *model3 = infoModel.new;
    model3.title = @"内存类型";
    model3.info = SSDeviceTool.memoryType;
    
    return @[@[model,  model1, model2, model3]];
}

- (NSArray *)SocInfo
{
    infoModel *model = infoModel.new;
    model.title = @"Soc名称";
    model.info = SSDeviceTool.SocName;
    
    infoModel *model1 = infoModel.new;
    model1.title = @"CPU 核心数";
    model1.info = [NSString stringWithFormat:@"%ld", SSDeviceTool.CPUCoresNumber];
    
    infoModel *model2 = infoModel.new;
    model2.title = @"GPU 核心数";
    model2.info = [NSString stringWithFormat:@"%ld", SSDeviceTool.GPUCoresNumber];
    
    infoModel *model3 = infoModel.new;
    model3.title = @"CPU 架构";
    model3.info = SSDeviceTool.CPUArchitecture;
    
    infoModel *model4 = infoModel.new;
    model4.title = @"CPU 频率";
    model4.info = [NSString stringWithFormat:@"%ld mHz", SSDeviceTool.CPUFrequency];
    
    infoModel *model5 = infoModel.new;
    model5.title = @"CPU 当前占用率";
    model5.info = SSDeviceTool.CPUUsageString;
    
    @weakify;
    [_tool startCPUUsageStringBlockWithTimeInterval:1
                                CPUUsageStringBlock:^(NSString * _Nonnull usageString) {
        @strongify;
        if (!self.tool) return;
        
        infoModel *model = infoModel.new;
        model.title = @"CPU 当前占用率";
        model.info = usageString;
        
        NSIndexPath *index = [NSIndexPath indexPathForRow:2 inSection:1];
        
        NSMutableArray *array = [NSMutableArray arrayWithArray:self.dataArray[0]];
        NSMutableArray *array1 = [NSMutableArray arrayWithArray:self.dataArray[1]];
        array1[index.row] = model;
        
        self.dataArray = @[array, array1];
        [self.tableView reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationNone];
    }];
    
    return @[
        @[model,  model1, model2],
        @[model3, model4, model5]
    ];
}

- (NSArray *)screenInfo
{
    infoModel *model = infoModel.new;
    model.title = @"显示屏类型";
    model.info = SSDeviceTool.displayScreen;
    
    infoModel *model1 = infoModel.new;
    model1.title = @"像素密度";
    model1.info = SSDeviceTool.screenPPI;
    
    infoModel *model2 = infoModel.new;
    model2.title = @"屏幕尺寸";
    model2.info = SSDeviceTool.screenSize;
    
    infoModel *model3 = infoModel.new;
    model3.title = @"屏幕分辨率";
    model3.info = SSScreen.screenRes;
    
    infoModel *model4 = infoModel.new;
    model4.title = @"屏幕宽高比";
    model4.info = SSDeviceTool.screenAspectRatio;
    
    return @[
        @[model2, model3, model4],
        @[model,  model1]
    ];
}

- (NSArray *)basicInfo
{
    infoModel *model = infoModel.new;
    model.title = @"设备类型";
    model.info = SSDeviceTool.deviceModel;
    
    infoModel *model1 = infoModel.new;
    model1.title = @"设备名称";
    model1.info = SSDeviceTool.deviceName;
    
    infoModel *model2 = infoModel.new;
    model2.title = @"设备系统";
    model2.info = SSDeviceTool.systemNameAndVersion;
    
    infoModel *model3 = infoModel.new;
    model3.title = @"发售日期";
    model3.info = SSDeviceTool.saleTime;
    
    infoModel *model4 = infoModel.new;
    model4.title = @"设备尺寸";
    model4.info = SSDeviceTool.deviceSize;
    
    infoModel *model5 = infoModel.new;
    model5.title = @"设备重量";
    model5.info = SSDeviceTool.deviceWeight;
    
    infoModel *model6 = infoModel.new;
    model6.title = @"SIM 卡支持";
    model6.info = SSDeviceTool.SIMCard;
    
    infoModel *model7 = infoModel.new;
    model7.title = @"支持最新的系统";
    model7.info = SSDeviceTool.latestSystemVersion;
    
    infoModel *model8 = infoModel.new;
    model8.title = @"最近重启于";
    model8.info = [SSDateHelper.main cn_YMDHMS_stringFromDate:SSDeviceTool.latestRestartTime];
    
    infoModel *model9 = infoModel.new;
    model9.title = @"是否越狱";
    model9.info = SSDeviceTool.isJailbreak ? @"是" : @"否";
    
    return @[
        @[model,  model1, model2],
        @[model3, model4, model5],
        @[model6, model7],
        @[model8, model9]
    ];
}

@end
