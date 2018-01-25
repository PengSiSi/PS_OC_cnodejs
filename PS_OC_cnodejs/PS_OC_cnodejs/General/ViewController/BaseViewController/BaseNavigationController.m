//
//  BaseNavigationController.m
//  Ssdfz
//
//  Created by 王楠 on 16/1/20.
//  Copyright © 2016年 Combanc. All rights reserved.
//

#import "BaseNavigationController.h"
#import "UIBarButtonItem+Base.h"

@implementation BaseNavigationController

+ (void)initialize {
    UINavigationBar *navBar = [UINavigationBar appearance];
    navBar.tintColor = [UIColor darkGrayColor];
    navBar.barTintColor = [UIColor darkGrayColor];
    navBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    navBar.translucent = YES;
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        
        // 添加返回按钮
//        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"back" higlightedImage:@"back" target:self action:@selector(back)];
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)back {
    
    [self popViewControllerAnimated:YES];
}

@end
