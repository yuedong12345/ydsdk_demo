//
//  ViewController.m
//  sdkdemo1
//
//  Created by dfy on 2024/5/7.
//

#import "ViewController.h"
#import <YDAdModule/YDSplashAd.h>
#import <YDAdModule/YDAdManager.h>
#import <YDAdModule/YDBannerView.h>
#import "SplashAdDemoViewController.h"
#import "InterstitialDemoViewController.h"
#import "RewardVideoDemoViewController.h"
#import "InfoAdDemoViewController.h"
#import "BannerAdDemoViewController.h"

typedef NS_ENUM(NSUInteger, RowId) {
    RowIdSplashAd_Standard,
    RowIdInfo_Template_Standard,
    RowIdRewardVideo_Standard,
    RowIdInterstitialAd,
    RowIdBannerAd
};

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) NSString *sceneId;

@property (nonatomic, strong) YDSplashAd *splashAd;

@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, strong) UISwitch *bottomSwitch;

@property (nonatomic, strong) UILabel *bottomSwitchLabel;

@property (nonatomic, strong) YDBannerView *bannerView;

@property (nonatomic, strong) NSArray <NSString *> *sectionTitles;
@property (nonatomic, strong) NSArray <NSArray <NSNumber *> *> *sectionRowIds;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sceneId = @"kaiping_splash";
    self.navigationItem.title = @"开屏广告:标准模式";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.sectionTitles = @[@"开屏广告", @"信息流广告", @"激励视频广告", @"插屏广告", @"Banner广告"];
    self.sectionRowIds = @[
        @[@(RowIdSplashAd_Standard)],
        @[@(RowIdInfo_Template_Standard)],
        @[@(RowIdRewardVideo_Standard)],
        @[@(RowIdInterstitialAd)],
        @[@(RowIdBannerAd)]
    ];
    [self initTableview];
}

#pragma mark - init
- (void)initTableview {
    UITableView *tableView = [[UITableView alloc] init];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    tableView.tableFooterView = [[UIView alloc] init];
    tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [tableView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
    [tableView.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
    [tableView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
    [tableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
}

#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _sectionRowIds.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _sectionRowIds[section].count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return _sectionTitles[section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    RowId rowId = [_sectionRowIds[indexPath.section][indexPath.row] integerValue];
    
    NSString *title = nil;
    switch (rowId) {
        case RowIdSplashAd_Standard:
            title = @"展示开屏广告";
            break;
        case RowIdInfo_Template_Standard:
            title = @"展示信息流广告";
            break;
        case RowIdRewardVideo_Standard:
            title = @"展示激励视频广告";
            break;
        case RowIdInterstitialAd:
            title = @"展示插屏广告";
            break;
        case RowIdBannerAd:
            title = @"展示横幅(Banner)广告";
            break;
        default:
            break;
    }
    cell.textLabel.text = title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    RowId rowId = [_sectionRowIds[indexPath.section][indexPath.row] integerValue];
    switch (rowId) {
        case RowIdSplashAd_Standard: {
            SplashAdDemoViewController *splashVC = [[SplashAdDemoViewController alloc] init];
            [self.navigationController pushViewController:splashVC animated:YES];
        }
            break;
        case RowIdInfo_Template_Standard: {
            InfoAdDemoViewController *infoVC = [[InfoAdDemoViewController alloc] init];
            [self.navigationController pushViewController:infoVC animated:YES];
        }
            break;
        case RowIdRewardVideo_Standard: {
            RewardVideoDemoViewController *rewardVC = [[RewardVideoDemoViewController alloc] init];
            [self.navigationController pushViewController:rewardVC animated:YES];
        }
            break;
        case RowIdInterstitialAd:{
            InterstitialDemoViewController *interstitialVC = [[InterstitialDemoViewController alloc] init];
            [self.navigationController pushViewController:interstitialVC animated:YES];
        }
            break;
        case RowIdBannerAd: {
            BannerAdDemoViewController *banner = [[BannerAdDemoViewController alloc] init];
            [self.navigationController pushViewController:banner animated:YES];
        }
            break;
        default:
            break;
    }
}

@end
