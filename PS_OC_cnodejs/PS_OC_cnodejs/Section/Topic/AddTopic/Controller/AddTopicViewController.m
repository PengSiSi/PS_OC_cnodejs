//
//  AddTopicViewController.m
//  PS_OC_cnodejs
//
//  Created by 思 彭 on 2017/12/6.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import "AddTopicViewController.h"

@interface AddTopicViewController () <UITextFieldDelegate, UITextViewDelegate>

@property (nonatomic, copy) NSString *titleStr;
@property (nonatomic, copy) NSString *contentStr;

@end

@implementation AddTopicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新增话题";
    [self setupUI];
}

- (void)setupUI {
    UILabel *titleLabel = [self createLabelWithText:@"标题" textColor:[UIColor lightGrayColor]];
    titleLabel.frame = CGRectMake(20, 80, K_SCREEN_WIDTH - 40, 20);
    [self.view addSubview:titleLabel];
    
    UITextField *titleTextField = [[UITextField alloc]initWithFrame:CGRectMake(20, 100, K_SCREEN_WIDTH - 20, 44)];
    titleTextField.delegate = self;
    titleTextField.backgroundColor = [UIColor whiteColor];
    titleTextField.placeholder = @"请输入标题";
    titleTextField.font = FONT_15;
    titleTextField.keyboardType = UIKeyboardTypeNumberPad;
    [titleTextField becomeFirstResponder]; // 成为第一响应
    [self.view addSubview:titleTextField];
    
    UILabel *contentLabel = [self createLabelWithText:@"内容" textColor:[UIColor lightGrayColor]];
    contentLabel.frame = CGRectMake(20, 150, K_SCREEN_WIDTH - 40, 20);
    [self.view addSubview:contentLabel];
    
    UITextView *contentTextView = [[UITextView alloc]initWithFrame:CGRectMake(20, 190, K_SCREEN_WIDTH - 40, 100)];
    contentTextView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    contentTextView.delegate = self;
    [self.view addSubview:contentTextView];
    
    UIButton *button = [UIButton buttonWithType: UIButtonTypeCustom];
    button.frame = CGRectMake(20, K_SCREEN_HEIGHT - 50, K_SCREEN_WIDTH - 40, 30);
    button.layer.cornerRadius = 5;
    button.layer.masksToBounds = YES;
    [button setTitle:@"提交" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = FONT_14;
    button.backgroundColor = BLUE_COLOR;
    [button addTarget:self action:@selector(commitAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

}

- (UILabel *)createLabelWithText: (NSString *)text textColor: (UIColor *)textColor {
    UILabel *label = [[UILabel alloc]init];
    label.text = text;
    label.textColor = textColor;
    return label;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.titleStr = textField.text;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.view endEditing:YES];
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        //在这里做你响应return键的代码
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    self.contentStr = textView.text;
}

- (void)commitAction: (UIButton *)button {
    [self.view endEditing:YES];
    NSLog(@"--%@--%@", self.titleStr, self.contentStr);
    // 新增话题
    [self addTopicRequest];
    
}

- (void)addTopicRequest {
    NSDictionary *params = AddTopicParameter(self.titleStr, self.contentStr, @"855453c8-956f-4b28-9d55-79d7a53ef7fc", @"dev");
    // 字典转data
    NSData *data = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
    [HTTPTool postWithUrl:ADD_TOPIC_URL body:data success:^(id json) {
        NSLog(@"--json--%@", json);
        if (json[@"success"]) {
            NSLog(@"新增话题成功");
        }
    } failure:^(id json) {
        NSLog(@"error -- %@", json);
    }];
}
@end
