//
//  YDNavigationController.m
//  YDAdModule_Example
//
//  Created by YueDong on 2023/12/23.
//

#import "YDNavigationController.h"

@interface YDNavigationController ()

@end

@implementation YDNavigationController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Medium" size:17], NSForegroundColorAttributeName: [UIColor whiteColor]};
    UIColor *backColor = [UIColor blackColor];
    UINavigationBar *navBar = self.navigationBar;
    if (@available(iOS 13.0, *)) {
        UINavigationBarAppearance *appearance = [UINavigationBarAppearance new];
        [appearance configureWithDefaultBackground];
        appearance.backgroundColor = backColor;
        appearance.shadowColor = [UIColor clearColor];
        appearance.titleTextAttributes = attribute;
        navBar.standardAppearance = appearance;
        if (@available(iOS 15.0, *)) {
            navBar.scrollEdgeAppearance = appearance;
        }
    } else {
        navBar.backgroundColor = backColor;
        navBar.shadowImage = [UIImage new];
        navBar.titleTextAttributes = attribute;
    }
    navBar.translucent = NO;
    navBar.tintColor = UIColor.whiteColor;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return YES;
}

- (BOOL)shouldAutorotate {
    return [(UIViewController *)[[self viewControllers] lastObject] shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return [[[self viewControllers] lastObject] preferredInterfaceOrientationForPresentation];
}

@end

