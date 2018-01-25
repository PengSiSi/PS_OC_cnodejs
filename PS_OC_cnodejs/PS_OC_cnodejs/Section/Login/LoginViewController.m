//
//  LoginViewController.m
//  PS_OC_cnodejs
//
//  Created by 思 彭 on 2017/12/14.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import "LoginViewController.h"
#import "MineViewController.h"

@interface LoginViewController ()


- (IBAction)loginAction:(id)sender;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
}

- (IBAction)loginAction:(id)sender {
    // 保存登录信息
    [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:isLogin];
    [[NSUserDefaults standardUserDefaults] synchronize];
    if (self.loginSuccess) {
        self.loginSuccess();
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
