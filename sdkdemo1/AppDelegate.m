//
//  AppDelegate.m
//  sdkdemo1
//
//  Created by dfy on 2024/5/7.
//

#import "AppDelegate.h"
#import <YDAdModule/YDAdManager.h>
#import "ViewController.h"

@interface AppDelegate ()

@property (nonatomic, strong) YDNavigationController *nav;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    UIViewController *vc = [[ViewController alloc] init];
    self.nav = [[YDNavigationController alloc] initWithRootViewController:vc];
    
    NSMutableDictionary *dict = (NSMutableDictionary *)[[NSBundle mainBundle] infoDictionary];
    // TODO 可替换包名
    [dict setObject:@"cn.xmb.sdkdemo1" forKey:@"CFBundleIdentifier"];
    
    self.window.rootViewController = self.nav;
    [self.window makeKeyAndVisible];
    [YDAdManager setup];
    return YES;
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSLog(@"applicationDidEnterBackground");
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSLog(@"applicationDidBecomeActive");
}


@end
