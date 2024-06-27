//
//  SplashAdDemoViewController.m
//  sdkdemo1
//
//  Created by dfy on 2024/6/26.
//

#import <Foundation/Foundation.h>
#import <Foundation/Foundation.h>
#import <YDAdModule/YDSplashAd.h>
#import "SplashAdDemoViewController.h"

@interface SplashAdDemoViewController () <YDSplashAdDelegate>

@property(nonatomic, strong) NSString *sceneId;

@property (nonatomic, strong) YDSplashAd *splashAd;

@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, strong) UISwitch *bottomSwitch;

@property (nonatomic, strong) UILabel *bottomSwitchLabel;

@end

@implementation SplashAdDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // TODO self.sceneId修改为自己的场景值
    self.sceneId = @"kaiping_splash";
    self.navigationItem.title = @"开屏广告";
    self.view.backgroundColor = [UIColor whiteColor];
    [self initViews];
}

#pragma mark init views
- (void)initViews {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"加载并展示" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(btnClickHandler) forControlEvents:UIControlEventTouchUpInside];
    [button setFrame:CGRectMake(50, 250, 50, 40)];
    
    [self.view addSubview:button];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [button.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    if (@available(iOS 11.0, *)) {
        [button.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:20].active = YES;
    } else {
        [button.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
    }

    UISwitch *useBottomViewSwitch = [[UISwitch alloc] init];
    self.bottomSwitch = useBottomViewSwitch;
    useBottomViewSwitch.selected = NO;
    useBottomViewSwitch.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:useBottomViewSwitch];
    [useBottomViewSwitch.topAnchor constraintEqualToAnchor:button.bottomAnchor constant:0].active = YES;
    [useBottomViewSwitch.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
    [useBottomViewSwitch.widthAnchor constraintEqualToConstant:60].active = YES;
    [useBottomViewSwitch.heightAnchor constraintEqualToConstant:30].active = YES;
    [useBottomViewSwitch addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
    
    UILabel *switchLabel = [[UILabel alloc] init];
    self.bottomSwitchLabel = switchLabel;
    switchLabel.text = @"不展示BottomView";
    [self.view addSubview:switchLabel];
    switchLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [switchLabel.topAnchor constraintEqualToAnchor:button.bottomAnchor constant:0].active = YES;
    [switchLabel.heightAnchor constraintEqualToConstant:30].active = YES;
    [switchLabel.leftAnchor constraintEqualToAnchor:useBottomViewSwitch.rightAnchor].active = YES;
    [switchLabel.widthAnchor constraintEqualToConstant:150].active = YES;
    
    UILabel *sceneName = [[UILabel alloc] init];
    NSMutableDictionary *dict = (NSMutableDictionary *)[[NSBundle mainBundle] infoDictionary];
    NSString *pkg = [dict objectForKey:@"CFBundleIdentifier"];
    sceneName.text = [NSString stringWithFormat:@"场景:%@ \n包名:%@", self.sceneId, pkg];
    sceneName.numberOfLines = 0;
    [self.view addSubview:sceneName];
    sceneName.translatesAutoresizingMaskIntoConstraints = NO;
    [sceneName.topAnchor constraintEqualToAnchor:useBottomViewSwitch.bottomAnchor constant:0].active = YES;
    [sceneName.widthAnchor constraintEqualToAnchor:self.view.widthAnchor].active = YES;
    [sceneName.heightAnchor constraintEqualToConstant:100].active = YES;
}

- (void)switchChanged:(UISwitch *)sender {
    // 检查开关状态
    if (sender.isOn) {
        self.bottomSwitchLabel.text = @"展示BottomView";
    } else {
        self.bottomSwitchLabel.text = @"不展示BottomView";
    }
}

- (UIView *)genBottomView {
    UIImageView *bottomImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"adLogo"]];
    bottomImg.backgroundColor = [UIColor whiteColor];
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = width * 512 / 1932;
    bottomImg.frame = CGRectMake(0, 0, width, height);
    return bottomImg;
}

- (void)btnClickHandler {
    NSLog(@"button click, load splash ad...");
    YDSplashAd *splashAd = [[YDSplashAd alloc] initWithScene:self.sceneId];
    splashAd.delegate = self;
    splashAd.fetchDelay = 3;
    self.splashAd = splashAd;
    
    if (self.bottomSwitch.isOn) {
        if (self.bottomView == nil) {
            self.bottomView = [self genBottomView];
        }
        self.splashAd.bottomView = self.bottomView;
    }
    
    // 方案1
    [self.splashAd loadAd];
    
    // 方案2
//    [self.splashAd loadAdAndShowInWindow:self.view.window bottomView:self.bottomView skipView:nil];
}

#pragma mark YDSplashAdDelegate

/**
 * 开屏素材加载成功
 * - Parameter splashAd: YDSplashAd
 */
- (void)splashDidLoad:(YDSplashAd *)splashAd {
    NSLog(@"splash ad load");
    // 方案1：load成功后，调用show，显示开屏
    [self.splashAd showAdInWindow:self.view.window bottomView:self.bottomView skipView:nil];
}

/**
 * 开屏展示失败
 * - Parameters:
 *   - splashAd: YDSplashAd
 *   - error: error
 */
- (void)splashFailToPresented:(YDSplashAd *)splashAd withError:(NSError *)error {
    NSLog(@"error:%@", error.description);
}

/**
 * 开屏曝光
 * - Parameter splashAd: YDSplashAd
 */
- (void)splashDidExposed:(YDSplashAd *)splashAd {
    NSLog(@"on pv");
}

/**
 * 开屏成功展示
 * - Parameter splashAd: YDSplashAd
 */
- (void)splashSuccessPresented:(YDSplashAd *)splashAd {
    NSLog(@"splashSuccessPresented");
}

/**
 * 开屏剩余时间
 * - Parameter time: 剩余时间
 */
- (void)splashLeftTime:(NSUInteger)time {
    NSLog(@"time:%lu", time);
}

/**
 * 开屏点击
 * - Parameter splashAd: YDSplashAd
 */
- (void)splashDidClicked:(YDSplashAd *)splashAd {
    NSLog(@"click");
}

/**
 * 开屏广告将要关闭
 * - Parameter splashAd: YDSplashAd
 */
- (void)splashWillClosed:(YDSplashAd *)splashAd {
    NSLog(@"splashWillClosed");
}

/**
 * 开屏广告关闭
 * - Parameter splashAd: YDSplashAd
 */
- (void)splashDidClosed:(YDSplashAd *)splashAd {
    NSLog(@"splashDidClosed");
    self.splashAd = nil;
}

/**
 * 开屏被点击以后即将展示详情页面
 * - Parameter splashAd: YDSplashAd
 */
- (void)splashWillShowDetailPage:(YDSplashAd *)splashAd {
    NSLog(@"splashWillShowDetailPage");
}

/**
 * 开屏点击以后详情页面弹出
 * - Parameter splashAd: YDSplashAd
 */
- (void)splashDidShowDetailPage:(YDSplashAd *)splashAd {
    NSLog(@"splashDidShowDetailPage");
}

/**
 * 点击以后详情页面将要关闭
 * - Parameter splashAd: YDSplashAd
 */
- (void)splashDetailPageWillDismiss:(YDSplashAd *)splashAd {
    NSLog(@"splashDetailPageWillDismiss");
}

/**
 * 点击以后详情页面关闭了
 * - Parameter splashAd: YDSplashAd
 */
- (void)splashDetailPageDidDismiss:(YDSplashAd *)splashAd {
    NSLog(@"splashDetailPageDidDismiss");
}
@end
