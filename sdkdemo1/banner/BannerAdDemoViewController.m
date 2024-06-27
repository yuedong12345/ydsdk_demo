//
//  YDBannerViewController.m
//  YDAdModule_Example
//
//  Created by YueDong on 2023/12/24.
//

#import "BannerAdDemoViewController.h"
#import <YDAdModule/YDBannerView.h>

@interface BannerAdDemoViewController ()<YDBannerViewDelegate>

@property (nonatomic, strong) NSString *sceneId;

/// banner
@property (nonatomic, strong) YDBannerView *bannerView;
@end

@implementation BannerAdDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // TODO self.sceneId修改为自己的场景值
    self.sceneId = @"diguang_banner";
    
    self.navigationItem.title = @"banner横幅广告";
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
}

- (void)btnClickHandler {
    if (self.bannerView != nil) {
        [self.bannerView removeFromSuperview];
        self.bannerView.delegate = nil;
        self.bannerView = nil;
    }
    [self initBannerAd];
    [self loadBanner];
}

#pragma mark - Banner
- (void)initBannerAd {
    YDBannerView *bannerView = [[YDBannerView alloc] initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, 75) scene:self.sceneId viewController:self];
    bannerView.autoSwitchInterval = 0;
    bannerView.delegate = self;
    self.bannerView = bannerView;
//    [self.view addSubview:bannerView];
}

- (void)loadBanner {
    // 方案1
    [self.bannerView loadAndShow];
#ifdef DEMO_PROD_CHEXUETANG
    [self.view addSubview:self.bannerView];
#endif
    
    // 方案2
//    [self.bannerView loadAd];
}

#pragma mark ---------------- YDBannerViewDelegate ----------------

/// 广告源返回的广告数据成功后调用
/// - Parameter bannerView: YDBannerView
- (void)bannerViewDidLoad:(YDBannerView *)bannerView {
    NSLog(@"%s",__FUNCTION__);
    // 方案2
//    CGRect fr = bannerView.frame;
//    [self.view addSubview:bannerView];
}


/// 广告源返回的广告数据失败后调用
/// - Parameters:
///   - bannerView: YDBannerView
///   - error: 失败原因
- (void)bannerViewFailedToLoad:(YDBannerView *)bannerView error:(NSError *)error {
    NSLog(@"%s",__FUNCTION__);
}


/// 曝光回调
/// - Parameter bannerView: YDBannerView
- (void)bannerViewWillExpose:(YDBannerView *)bannerView {
    NSLog(@"%s",__FUNCTION__);
}


/// 点击回调
/// - Parameter bannerView: YDBannerView
- (void)bannerViewDidClicked:(YDBannerView *)bannerView {
    NSLog(@"%s",__FUNCTION__);
}

/// 点击关闭按钮
/// - Parameter bannerView: YDBannerView
- (void)bannerViewDidClickedCloseButton:(YDBannerView *)bannerView {
    NSLog(@"%s",__FUNCTION__);
    [bannerView showDislikeFrom:self];
}

- (void)bannerView:(YDBannerView *)bannerView dislikeDidSelectText:(NSString *)text {
    NSLog(@"%s",__FUNCTION__);
    NSLog(@"%@", text);
}


/// 广告点击以后即将弹出广告详情
/// - Parameter bannerView: YDBannerView
- (void)bannerViewWillPresentDetailPage:(YDBannerView *)bannerView {
    NSLog(@"%s",__FUNCTION__);
}


/// 广告点击以后弹出详情页
/// - Parameter bannerView: YDBannerView
- (void)bannerViewDidPresentDetailPage:(YDBannerView *)bannerView {
    NSLog(@"%s",__FUNCTION__);
}


/// 详情即将关闭
/// - Parameter bannerView: YDBannerView
- (void)bannerViewWillDismissDetailPage:(YDBannerView *)bannerView {
    NSLog(@"%s",__FUNCTION__);
}


/// 详情已经被关闭
/// - Parameter bannerView: YDBannerView
- (void)bannerViewDidDismissDetailPage:(YDBannerView *)bannerView {
    NSLog(@"%s",__FUNCTION__);
}

/**
 *  当点击应用下载或者广告调用系统程序打开
 */
- (void)bannerViewWillLeaveApplication:(YDBannerView *)bannerView {
    NSLog(@"%s",__FUNCTION__);
}


/// 被用户关闭时调用  若开启循环  刷新间隔 - 已展示事件  后会展示新的广告  如果没有开启循环 会自动移除
/// - Parameter bannerView: YDBannerView
- (void)bannerViewWillClose:(YDBannerView *)bannerView {
    NSLog(@"%s",__FUNCTION__);
}

@end

