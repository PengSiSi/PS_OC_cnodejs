//
//  ExpandViewController.m
//  PS_OC_cnodejs
//
//  Created by 思 彭 on 2018/1/16.
//  Copyright © 2018年 思 彭. All rights reserved.

// 点击屏幕弹出InputTooBar

#import "ExpandViewController.h"
#import "ExpandTextView.h"
#import "UIView+Frame.h"

@interface ExpandViewController ()

@property (nonatomic, strong) ExpandTextView *inputToolbar;
@property (nonatomic, strong) UIView *maskView;
@end

@implementation ExpandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTextViewToolBar];
}

- (void)setupTextViewToolBar {
    self.maskView = [[UIView alloc] initWithFrame:self.view.bounds];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapActions:)];
    [self.maskView addGestureRecognizer:tap];
    [self.view addSubview:self.maskView];
    self.maskView.hidden = YES;
    self.inputToolbar = [[ExpandTextView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 44)];
    self.inputToolbar.textViewMaxLine = 3;
    self.inputToolbar.fontSize = 18;
    self.inputToolbar.placeholder = @"请输入...";
    __weak __typeof(self) weakSelf = self;
    
    [self.inputToolbar inputToolbarSendText:^(NSString *text) {
        __typeof(&*weakSelf) strongSelf = weakSelf;
        // 清空文字,发送数据，收起inputToolBar
        [strongSelf.inputToolbar dismissToolbar];
        strongSelf.maskView.hidden = YES;
    }];
    [self.maskView addSubview:self.inputToolbar];
}

- (void)tapActions: (UITapGestureRecognizer *)tap {
    [self.inputToolbar dismissToolbar];
    self.maskView.hidden = YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.inputToolbar showToolbar];
    self.maskView.hidden = NO;
}

@end
