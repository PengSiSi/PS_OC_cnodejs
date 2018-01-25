//
//  TopicPageViewController.m
//  PS_OC_cnodejs
//
//  Created by 思 彭 on 2017/12/5.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import "TopicPageViewController.h"
#import "TopicListViewController.h"
#import "SuspendButton.h"
#import "AddTopicViewController.h"
#import "TopicSearchViewController.h"

@interface TopicPageViewController ()

@end

@implementation TopicPageViewController

#pragma mark - Life Cycle

- (instancetype)init {
    if (self = [super init]) {
        self.menuViewStyle = WMMenuViewStyleLine;
        self.menuItemWidth = SCREEN_WIDTH/self.titleArray.count;
        self.titleSizeNormal = 14;
        self.titleSizeSelected = 17;
        self.progressColor = BLUE_COLOR; //进度条颜色
        self.titleColorSelected = BLUE_COLOR; //标题选中时的颜色
        self.titleColorNormal = [UIColor darkGrayColor];  //标题非选中的颜色
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = nil;
    [self setNavItem];
    [self addSuspendButton];
}

#pragma mark - Initial

- (NSArray *)titleArray {
    return @[@"全部", @"精华", @"分享", @"问答", @"测试"];
}

- (NSArray *)tabArray {
    return @[@"all", @"good", @"share", @"ask", @"test"];
}

#pragma mark - 创建UI

- (void)setNavItem {
    
    UIImageView *leftImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cnodejs_logo"]];
    leftImgView.frame = CGRectMake(0, 0, 60, 20);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftImgView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchAction:)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
}

- (void)addSuspendButton {
    SuspendButton *button = [[SuspendButton alloc]initWithFrame:CGRectMake(K_SCREEN_WIDTH - 60, K_SCREEN_HEIGHT - 49 - 60, ADD_BTN_WIDTH, ADD_BTN_WIDTH)];
    [self.view addSubview:button];
    button.suspendBtnClicked = ^{
        NSLog(@"新增");
        AddTopicViewController *addTopicVc = [[AddTopicViewController alloc]init];
        [self.navigationController pushViewController:addTopicVc animated:YES];
    };
}

#pragma mark - WMPageControllerDataSource

- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    
    return self.titleArray.count;
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {

    TopicListViewController *listVc = [[TopicListViewController alloc]init];
    listVc.tabStr = self.tabArray[index];
    return listVc;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    
    return self.titleArray[index];
}

- (void)menuView:(WMMenuView *)menu didLayoutItemFrame:(WMMenuItem *)menuItem atIndex:(NSInteger)index {
    //    NSLog(@"frame---%@", NSStringFromCGRect(menuItem.frame));
}

- (void)pageController:(WMPageController *)pageController didEnterViewController:(__kindof UIViewController *)viewController withInfo:(NSDictionary *)info {

}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    return CGRectMake(0, 64 + self.menuView.frame.size.height+30, SCREEN_WIDTH, SCREEN_HEIGHT - 49 - 64 - self.menuView.frame.size.height);
}

//- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
//    return CGRectMake(0, SCREEN_WIDTH*9/16, SCREEN_WIDTH, 44);
//}

#pragma mark - Private Method

- (void)logoAction: (UIBarButtonItem *)item {
    
}

- (void)searchAction: (UIBarButtonItem *)item {
    TopicSearchViewController *searchVc = [[TopicSearchViewController alloc]init];
//    [self.navigationController pushViewController:searchVc animated:YES];
    [self addChildViewController:searchVc];
//    self.navigationController.navigationBar.hidden = YES;
    searchVc.view.frame = CGRectMake(0, 0, K_SCREEN_WIDTH, K_SCREEN_HEIGHT);
    [self.view addSubview:searchVc.view];
}

@end

