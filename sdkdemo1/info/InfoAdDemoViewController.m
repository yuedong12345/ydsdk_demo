//
//  YDInfoViewController.m
//  YDAdModule_Example
//
//  Created by dfy on 2024/3/25.
//  Copyright © 2024 liuchuang1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InfoAdDemoViewController.h"
#import <YDAdModule/YDAdModule-umbrella.h>

@interface InfoAdDemoViewController () <YDNativeExpressAdDelegete>

@property (nonatomic, strong) NSString *sceneId;

/// ad
@property (nonatomic, strong) YDNativeExpressAd *nativeExpressAd;

/// adView
@property (nonatomic, strong) YDNativeExpressView *expressAdView;

@property (nonatomic, strong) NSMutableArray<YDNativeExpressView *> *adViews;

@end

@implementation InfoAdDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.adViews = [NSMutableArray array];
    
    // TODO self.sceneId修改为自己的场景值
    self.sceneId = @"zhongcha_infor";
    
    self.navigationItem.title = @"信息流广告";
    self.view.backgroundColor = [UIColor whiteColor];
    [self initViews];
    [self initNativeExpressAd];
}

- (void)initViews {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button addTarget:self action:@selector(btnClickHandler) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"加载并展示" forState:UIControlStateNormal];
    [self.view addSubview:button];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    if (@available(iOS 11.0, *)) {
        [button.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:20].active = YES;
    } else {
        [button.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
    }
    [button.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:10].active = YES;
    [button.widthAnchor constraintEqualToConstant:150].active = YES;
    
    UIButton *remove = [UIButton buttonWithType:UIButtonTypeSystem];
    [remove addTarget:self action:@selector(removeAd) forControlEvents:UIControlEventTouchUpInside];
    [remove setTitle:@"移除广告" forState:UIControlStateNormal];
    [self.view addSubview:remove];
    remove.translatesAutoresizingMaskIntoConstraints = NO;
    if (@available(iOS 11.0, *)) {
        [remove.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:20].active = YES;
    } else {
        [remove.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
    }
    [remove.leftAnchor constraintEqualToAnchor:button.rightAnchor constant:10].active = YES;
    [remove.widthAnchor constraintEqualToConstant:150].active = YES;
    
    UILabel *sceneName = [[UILabel alloc] init];
    NSMutableDictionary *dict = (NSMutableDictionary *)[[NSBundle mainBundle] infoDictionary];
    NSString *pkg = [dict objectForKey:@"CFBundleIdentifier"];
    sceneName.text = [NSString stringWithFormat:@"场景:%@ \n包名:%@", self.sceneId, pkg];
    sceneName.numberOfLines = 0;
    [self.view addSubview:sceneName];
    sceneName.translatesAutoresizingMaskIntoConstraints = NO;
    [sceneName.topAnchor constraintEqualToAnchor:button.bottomAnchor constant:10].active = YES;
    [sceneName.widthAnchor constraintEqualToAnchor:self.view.widthAnchor].active = YES;
    [sceneName.heightAnchor constraintEqualToConstant:50].active = YES;
}

- (void)btnClickHandler {
    NSLog(@"click");
    [self loadNativeExpress];
}

- (void)removeAd {
    if (self.expressAdView != nil) {
        [self.expressAdView removeFromSuperview];
        self.expressAdView = nil;
    }
//    if (self.nativeExpressAd != nil) {
//        self.nativeExpressAd = nil;
//    }
}

#pragma mark - NativeExpressAd
- (void)initNativeExpressAd {
    YDNativeExpressAd *nativeExpressAd = [[YDNativeExpressAd alloc] initWithScene:self.sceneId adSize:CGSizeMake(self.view.frame.size.width, 400)];
    nativeExpressAd.delegate = self;
    self.nativeExpressAd = nativeExpressAd;
}

- (void)loadNativeExpress {
    [self.nativeExpressAd loadAd:1];
}

#pragma mark ---------------- YDNativeExpressAdDelegete ----------------

/// 原生广告加载成功
/// - Parameters:
///   - nativeExpressAd: YDNativeExpressAd
///   - views: YDNativeExpressView
- (void)nativeExpressAdDidSuccessLoaded:(YDNativeExpressAd *)nativeExpressAd views:(NSArray<__kindof YDNativeExpressView *> *)views {
    NSLog(@"ad load success");
    if (self.expressAdView) {
        [self.expressAdView removeFromSuperview];
    }
    if (views.count > 0) {
        YDNativeExpressView *adView = views.firstObject;
        if ([adView isAdValid]) {
            adView.rootController = self;
            NSLog(@"render view");
            [adView render];
        }
        CGRect adViewFrame = adView.frame;
        adView.frame = CGRectMake(0, 120, adViewFrame.size.width, adViewFrame.size.height);
        [self.view addSubview:adView];
        self.expressAdView = adView;
    }
}

/// 原生广告加载失败
/// - Parameters:
///   - nativeExpressAd: YDNativeExpressAd
///   - error: 错误信息
- (void)nativeExpressAdDidFailLoaded:(YDNativeExpressAd *)nativeExpressAd error:(NSError *)error {
    NSLog(@"load failed");
    [self removeAd];
}


/// 原生广告渲染成功,  此时的 nativeExpressAdView.size.height 根据 size.width 完成了动态更新。
/// - Parameter nativeExpressAdView: YDNativeExpressView
- (void)nativeExpressAdViewDidRenderSuccess:(YDNativeExpressView *)nativeExpressAdView {
    NSLog(@"render success");
}

/// 原生广告渲染失败
/// - Parameter nativeExpressAdView: YDNativeExpressView
- (void)nativeExpressAdViewDidRenderFail:(YDNativeExpressView *)nativeExpressAdView {
    NSLog(@"ad render failed");
    [self removeAd];
}

/// 原生广告曝光
/// - Parameter nativeExpressAdView: YDNativeExpressView
- (void)nativeExpressAdViewDidExposed:(YDNativeExpressView *)nativeExpressAdView {
    NSLog(@"ad pv");
}

/// 原生广告点击
/// - Parameter nativeExpressAdView: YDNativeExpressView
- (void)nativeExpressAdViewDidClicked:(YDNativeExpressView *)nativeExpressAdView {
    NSLog(@"ad click");
}

- (void)nativeExpressAdViewDidClickedCloseButton:(YDNativeExpressView *)nativeExpressAdView {
    NSLog(@"click dislike button");
    [self.nativeExpressAd showDislikeFrom:self];
}

- (void)nativeExpressAd:(YDNativeExpressAd *)nativeExpressAd adView:(YDNativeExpressView *)adView dislikeDidSelectText:(NSString *)text {
    NSLog(@"dislike select %@", text);
}

/// 原生广告被关闭
/// - Parameter nativeExpressAdView: YDNativeExpressView
- (void)nativeExpressAdViewDidClosed:(YDNativeExpressView *)nativeExpressAdView {
    NSLog(@"ad closed");
    [self removeAd];
}

@end

