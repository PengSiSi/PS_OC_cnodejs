//
//  LaunchManager.m
//  PS_OC_cnodejs
//
//  Created by 思 彭 on 2017/12/29.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import "LaunchManager.h"
#import "UIView+Extension.h"
#import "LoginViewController.h"
#import <ReactiveCocoa.h>

@interface LaunchManager()

@property (nonatomic, strong) UIWindow *window;

@end

@implementation LaunchManager
@synthesize tabBarController = _tabBarController;

+ (LaunchManager *)sharedInstance
{
    static LaunchManager *rootVCManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        rootVCManager = [[self alloc] init];
    });
    return rootVCManager;
}

- (void)launchInWindow:(UIWindow *)window
{
    self.window = window;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    // if 已经登录->初始化用户信息->设置根控制器
    [self setCurrentRootVC:self.tabBarController];
    // 未登录->进入登录页面->设置根控制器
//    LoginViewController *loginVc = [[LoginViewController alloc]init];
//    @weakify(self);
//    loginVc.loginSuccess = ^{
//         @strongify(self);
//        [self launchInWindow: window];
//    };
//    [self setCurrentRootVC:loginVc];
}

- (void)setCurrentRootVC:(__kindof UIViewController *)currentRootVC {
    _currentRootVC = currentRootVC;
    // 注意，这里需要和以前AppDelegate里一样创建window
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window removeAllSubviews];
    [self.window setRootViewController:currentRootVC];
    [self.window addSubview:currentRootVC.view];
    [self.window makeKeyAndVisible];
}

- (RootTabbarViewController *)tabBarController {
    if (!_tabBarController) {
        _tabBarController = [[RootTabbarViewController alloc]init];
    }
    return _tabBarController;
}

@end
