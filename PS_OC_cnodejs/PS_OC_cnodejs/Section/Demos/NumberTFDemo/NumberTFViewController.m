//
//  NumberTFViewController.m
//  PS_OC_cnodejs
//
//  Created by 思 彭 on 2018/1/23.
//  Copyright © 2018年 思 彭. All rights reserved.
//

#import "NumberTFViewController.h"
#import "NumberTextField.h"
#import "CountDownButton.h"

@interface NumberTFViewController ()

@property (nonatomic, strong) CountDownButton *countDownBtn;

@end

@implementation NumberTFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NumberTextField *numberTF = [[NumberTextField alloc]initWithFrame:CGRectMake(100, 100, 100, 60)];
    numberTF.keyboardType = UIKeyboardTypeNumberPad;
    numberTF.borderStyle = UITextBorderStyleRoundedRect;
    numberTF.placeholder = @"请测试。。。";
    numberTF.doneBtnTitle = @"完成";
    numberTF.hideKeyboard = true;
    [self.view addSubview:numberTF];
    
    self.countDownBtn = [[CountDownButton alloc]initWithFrame:CGRectMake(100, 200, 100, 60)];
//    self.countDownBtn.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.countDownBtn];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.countDownBtn openCountdown];
}

@end
