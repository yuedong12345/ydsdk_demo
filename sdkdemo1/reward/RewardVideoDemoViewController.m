//
//  RewardVideoDemoViewController.m
//  sdkdemo1
//
//  Created by dfy on 2024/6/27.
//

#import <Foundation/Foundation.h>
#import "RewardVideoDemoViewController.h"
#import <YDAdModule/YDAdModule-umbrella.h>

@interface RewardVideoDemoViewController () <YDRewardedVideoAdDelegate>

@property (nonatomic, strong) YDRewardVideoAd *rewardVideoAd;

@property (nonatomic, strong) NSString *senceId;

@end

@implementation RewardVideoDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // TODO self.sceneId修改为自己的场景值
    self.senceId = @"fuli_video";
    
    self.navigationItem.title = [NSString stringWithFormat:@"激励视频广告:%@",self.senceId];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initViews];
}

- (void)initViews {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button addTarget:self action:@selector(btnClickHandler) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"加载并展示" forState:UIControlStateNormal];
    [self.view addSubview:button];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [button.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    if (@available(iOS 11.0, *)) {
        [button.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:20].active = YES;
    } else {
        [button.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
    }
    
    UIButton *preloadBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [preloadBtn addTarget:self action:@selector(btnPreloadHandler) forControlEvents:UIControlEventTouchUpInside];
    [preloadBtn setTitle:@"预加载" forState:UIControlStateNormal];
    [self.view addSubview:preloadBtn];
    preloadBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [preloadBtn.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    if (@available(iOS 11.0, *)) {
        [preloadBtn.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:80].active = YES;
    } else {
        [preloadBtn.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
    }
    
    UILabel *sceneName = [[UILabel alloc] init];
    NSMutableDictionary *dict = (NSMutableDictionary *)[[NSBundle mainBundle] infoDictionary];
    NSString *pkg = [dict objectForKey:@"CFBundleIdentifier"];
    sceneName.text = [NSString stringWithFormat:@"场景:%@ \n包名:%@", self.senceId, pkg];
    sceneName.numberOfLines = 0;
    [self.view addSubview:sceneName];
    sceneName.translatesAutoresizingMaskIntoConstraints = NO;
    [sceneName.topAnchor constraintEqualToAnchor:preloadBtn.bottomAnchor constant:0].active = YES;
    [sceneName.widthAnchor constraintEqualToAnchor:self.view.widthAnchor].active = YES;
    [sceneName.heightAnchor constraintEqualToConstant:100].active = YES;
}

- (void)btnClickHandler {
    NSLog(@"click");
    self.rewardVideoAd = [[YDRewardVideoAd alloc] initWithScene:self.senceId];
    self.rewardVideoAd.delegate = self;
    [self.rewardVideoAd loadAd];
}

- (void)btnPreloadHandler {
    NSLog(@"click");
    // 激励视频广告加载时间较长，为优化体验，可在判定将要展示激励视频时，提前调用preload接口，提前加载，并将加载到的广告放入内存。
    // 在需要展示激励视频时，直接调用loadAd接口。如果preload已经加载，就直接返回，否则等着加载完成。preload是可选的优化项。
    self.rewardVideoAd = [[YDRewardVideoAd alloc] initWithScene:self.senceId];
    [self.rewardVideoAd preload];
}

#pragma mark ---------------- YDRewardedVideoAdDelegate ----------------

- (void)rewardVideoDidLoad:(YDRewardVideoAd *)rewardedVideoAd {
    NSLog(@"%s",__FUNCTION__);
    [self.rewardVideoAd showAdFromRootViewController:self];
}


- (void)rewardVideoVideoDidLoad:(YDRewardVideoAd *)rewardedVideoAd {
    NSLog(@"%s",__FUNCTION__);
}

- (void)rewardVideoWillVisible:(YDRewardVideoAd *)rewardedVideoAd {
    NSLog(@"%s",__FUNCTION__);
}

- (void)rewardVideoDidExposed:(YDRewardVideoAd *)rewardedVideoAd {
    NSLog(@"%s",__FUNCTION__);
}


- (void)rewardVideoDidClose:(YDRewardVideoAd *)rewardedVideoAd {
    NSLog(@"%s",__FUNCTION__);
}

- (void)rewardVideoDidClicked:(YDRewardVideoAd *)rewardedVideoAd {
    NSLog(@"%s",__FUNCTION__);
}

- (void)rewardVideoAd:(YDRewardVideoAd *)rewardedVideoAd didFailWithError:(NSError *)error {
    NSLog(@"%s",__FUNCTION__);
}

- (void)rewardVideoDidRewardEffective:(YDRewardVideoAd *)rewardedVideoAd info:(NSDictionary *)info {
    NSLog(@"%s",__FUNCTION__);
}

- (void)rewardVideoDidPlayFinish:(YDRewardVideoAd *)rewardedVideoAd {
    NSLog(@"%s",__FUNCTION__);
}
@end

