//
//  RootTabbarViewController.m
//  PS_OC_cnodejs
//
//  Created by 思 彭 on 2017/11/28.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import "RootTabbarViewController.h"
#import "BaseViewController.h"
#import "BaseNavigationController.h"
#import "UITabBar+Badge.h"
@interface RootTabbarViewController () <UITabBarControllerDelegate>

@end

@implementation RootTabbarViewController

#pragma mark - LifeCycle

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setUI];
        [self.tabBar showBadgeOnItemIndex:2];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];

}

- (void)setUI {
    NSArray *selectImage = @[@"home_icon_pressed",@"easy-teach_icon_pressed",@"Easy-learning_icon_pressed",@"mine_icon_pressed"];
    NSArray *normalImage = @[@"home_icon_normal",@"easy-teach_icon_normal",@"easy-learning_icon_normal",@"mine_icon_normal"];
    
    NSArray *vcClass = @[@"TopicPageViewController",@"RecruitmentViewController",@"NoticeViewController",@"MineViewController"];
    NSArray *vcName = @[@"话题",@"招聘",@"通知", @"我的"];
    NSMutableArray *allArray = [NSMutableArray array];
    
    for (int i = 0; i < vcClass.count; i++) {
        
        Class cla = NSClassFromString(vcClass[i]);
        UIViewController *vc = [[cla alloc] init];
        vc.title = vcName[i];
        [vc.tabBarItem setImage:[[UIImage imageNamed:normalImage[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [vc.tabBarItem setSelectedImage:[[UIImage imageNamed:selectImage[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [vc.tabBarItem setTitle:vcName[i]];
        
        BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
        [allArray addObject:nav];
    }
    
    self.tabBar.backgroundColor = [UIColor redColor];
    self.viewControllers = allArray;
    [self.tabBar setTintColor:[UIColor darkGrayColor]];
    
    self.delegate = self;
    //设置TabBar背景颜色
    [self setUpTabBarItemTextAttributes];
}

/**
 *  设置TabBar背景颜色
 */
- (void)setUpTabBarItemTextAttributes {
    UITabBar *tabBarAppearance = [UITabBar appearance];
    tabBarAppearance.barTintColor = [UIColor whiteColor];
}

#pragma mark - TabBarDelegate

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
