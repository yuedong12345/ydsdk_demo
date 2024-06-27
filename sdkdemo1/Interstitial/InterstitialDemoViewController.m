//
//  YDInterstitialViewController.m
//  YDAdModule_Example
//
//  Created by dfy on 2024/4/17.
//  Copyright © 2024 liuchuang1. All rights reserved.
//

//#import "YDDemoCommon.h"
#import <Foundation/Foundation.h>
#import "InterstitialDemoViewController.h"
#import <YDAdModule/YDInterstitialAd.h>

@interface InterstitialDemoViewController () <YDInterstitialAdDelegate>

@property (nonatomic, strong) NSString *senceId;

@property (nonatomic, strong) YDInterstitialAd *interAd;

@end

@implementation InterstitialDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"viewDidLoad");
    self.navigationItem.title = @"插屏广告";
    self.view.backgroundColor = [UIColor whiteColor];
    
    // TODO self.sceneId修改为自己的场景值
    self.senceId = @"tab_inter";
    [self initViews];
}

- (void)initViews {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button addTarget:self action:@selector(btnClickHandler) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"加载并展示(半屏)" forState:UIControlStateNormal];
    [self.view addSubview:button];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [button.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    if (@available(iOS 11.0, *)) {
        [button.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:20].active = YES;
    } else {
        [button.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
    }
}

- (void)btnClickHandler {
    NSLog(@"load ad...");
    if (self.interAd == nil) {
        self.interAd = [[YDInterstitialAd alloc] initWithScene:self.senceId];
        self.interAd.delegate = self;
    }
    [self.interAd loadAd];
}

#pragma mark YDInterstitialAdDelegate
- (void)interstitialSuccessToLoaded:(YDInterstitialAd *)interstitial {
    NSLog(@"ad load");
    [self.interAd presentAdFromRootViewController:self];
}

/// 广告源返回广告数据失败
/// - Parameters:
///   - interstitial: YDInterstitialAd
///   - error: 错误信息
- (void)interstitialFailToLoaded:(YDInterstitialAd *)interstitial error:(NSError *)error {
    NSLog(@"load fail");
}

/// 广告视频缓存完成
/// - Parameter interstitial: YDInterstitialAd
- (void)interstitialDidDownloadVideo:(YDInterstitialAd *)interstitial {
    NSLog(@"video download");
}


/// 广告渲染成功
/// - Parameter interstitial: YDInterstitialAd
- (void)interstitialDidRenderSuccess:(YDInterstitialAd *)interstitial {
    NSLog(@"render success");
}

/// 广告渲染失败
/// - Parameters:
///   - interstitial: YDInterstitialAd
///   - error: 失败信息
- (void)interstitialDidRenderFail:(YDInterstitialAd *)interstitial error:(NSError *)error {
    NSLog(@"render fail");
}

/// 广告将要展示
/// - Parameter interstitial: YDInterstitialAd
- (void)interstitialWillPresentedOnScreen:(YDInterstitialAd *)interstitial {
    NSLog(@"will show");
}

/// 广告视图展示成功回调
/// - Parameter interstitial: YDInterstitialAd
- (void)interstitialDidPresentOnScreen:(YDInterstitialAd *)interstitial {
    NSLog(@"show success");
}

/// 广告视图展示失败回调
/// - Parameters:
///   - interstitial: YDInterstitialAd
///   - error: 错误信息
- (void)interstitialFailToPresent:(YDInterstitialAd *)interstitial error:(NSError *)error {
    NSLog(@"show failed");
}

/// 广告展示结束回调
/// - Parameter interstitial: YDInterstitialAd
- (void)interstitialDidDismissScreen:(YDInterstitialAd *)interstitial {
    NSLog(@"dismiss");
}

/// 广告曝光回调
/// - Parameter interstitial: YDInterstitialAd
- (void)interstitialWillExposed:(YDInterstitialAd *)interstitial {
    NSLog(@"pv");
}

/// 广告点击回调
/// - Parameter interstitial: YDInterstitialAd
- (void)interstitialDidClicked:(YDInterstitialAd *)interstitial {
    NSLog(@"ad click");
}

/// 广告点击后即将展示详情回调
/// - Parameter interstitial: YDInterstitialAd
- (void)interstitialWillShowDetailPage:(YDInterstitialAd *)interstitial {
    NSLog(@"will show detail");
}

/// 广告点击后展示详情回调
/// - Parameter interstitial: YDInterstitialAd
- (void)interstitialDidShowDetailPage:(YDInterstitialAd *)interstitial {
    NSLog(@"did show detail");
}

/// 详情页将要关闭回调
/// - Parameter interstitial: YDInterstitialAd
- (void)interstitialWillDismissDetailPage:(YDInterstitialAd *)interstitial {
    NSLog(@"will dismiss detail");
}

/// 详情页关闭回调
/// - Parameter interstitial: YDInterstitialAd
- (void)interstitialDidDismissDetailPage:(YDInterstitialAd *)interstitial {
    NSLog(@"did dismiss detail");
}


/// 视频广告 player 播放状态更新回调
/// - Parameters:
///   - interstitial: YDInterstitialAd
///   - status: 播放器状态
- (void)interstitialAd:(YDInterstitialAd *)interstitial playerStatusChanged:(YDPlayerStatus)status {
    NSLog(@"player status changed");
}

/// 插屏视频广告详情页 WillPresent 回调
/// - Parameter interstitial: YDInterstitialAd
- (void)interstitialViewWillPresentVideoVC:(YDInterstitialAd *)interstitial {
    NSLog(@"will show video vc");
}

/// 插屏视频广告详情页 DidPresent 回调
/// - Parameter interstitial: YDInterstitialAd
- (void)interstitialViewDidPresentVideoVC:(YDInterstitialAd *)interstitial {
    NSLog(@"did show video vc");
}

/// 插屏视频广告详情页 WillDismiss 回调
/// - Parameter interstitial: YDInterstitialAd
- (void)interstitialViewWillDismissVideoVC:(YDInterstitialAd *)interstitial {
    NSLog(@"will dismiss video vc");
}

/// 插屏视频广告详情页 DidDismiss 回调
/// @param interstitial YDInterstitialAd
- (void)interstitialAdViewDidDismissVideoVC:(YDInterstitialAd *)interstitial {
    NSLog(@"did dismiss video vc");
}

/// 插屏激励广告视频播放达到激励条件回调（注意: 只有插屏激励广告位才会有此回调）
/// @param interstitial YDInterstitialAd
/// @param info 其它广告信息
- (void)interstitialAdDidRewardEffective:(YDInterstitialAd *)interstitial info:(NSDictionary *)info {
    NSLog(@"reach reward");
}
@end

