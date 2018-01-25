//
//  BaseViewController.m
//  changpingSchoolTeacher
//
//  Created by 王楠 on 16/1/19.
//  Copyright © 2016年 Combanc. All rights reserved.
//

#import "BaseViewController.h"
#import "UINavigationBar+Awesome.h"
#import "UIColor+HexColor.h"
@interface BaseViewController ()

@end
@implementation BaseViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    self.navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
    
}
@end
