//
//  ReplyView.m
//  wisdomClass
//
//  Created by 王楠 on 2017/7/19.
//  Copyright © 2017年 combanc. All rights reserved.
//  回复框View

#import "ReplyView.h"

@implementation ReplyView

#pragma mark - Init

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RGBA(255, 255, 255, 1);
        
        UIImageView *backImgV = [[UIImageView alloc] init];
        backImgV.userInteractionEnabled = YES;
        [self addSubview:backImgV];
        [backImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        self.replyTF = [[UITextField alloc] init];
        self.replyTF.borderStyle = UITextBorderStyleRoundedRect;
        self.replyTF.autocapitalizationType = UITextAutocapitalizationTypeNone;
        self.replyTF.placeholder = @"请输入内容";
        self.replyTF.returnKeyType = UIReturnKeyDone;
        self.replyTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.replyTF.backgroundColor = HEXCOLOR(0xe7e7e7);
        self.replyTF.delegate = self;
        [backImgV addSubview:self.replyTF];
        [self.replyTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(backImgV).insets(UIEdgeInsetsMake(5, 20, 5, 100));
        }];
        
        self.postBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        //        self.postBtn.layer.borderWidth = 1;
        //        self.postBtn.layer.cornerRadius = 8;
        //        self.postBtn.layer.borderColor = RGBA(246, 246, 246, 1).CGColor;
        [self.postBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.postBtn setTitle:@"回答" forState:UIControlStateNormal];
        [self.postBtn setBackgroundColor:BLUE_COLOR];
        self.postBtn.titleLabel.font = FONT_14;
        self.postBtn.layer.cornerRadius = 4;
        self.postBtn.clipsToBounds = YES;
        
        [self.postBtn addTarget:self action:@selector(postBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [backImgV addSubview:self.postBtn];
        [self.postBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(backImgV).offset(5);
            make.bottom.equalTo(backImgV).offset(-5);
            make.right.equalTo(backImgV).offset(-20);
            make.left.equalTo(self.replyTF.mas_right).offset(15);
        }];
    }
    return self;
}

#pragma mark - PostBtnClick

- (void)postBtnClick:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(replyView:postBtnClick:)]) {
        [self.delegate replyView:self postBtnClick:sender];
    }
}

#pragma mark - TextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (self.delegate && [self.delegate respondsToSelector:@selector(replyView:textFieldDidBeginEditing:)]) {
        [self.delegate replyView:self textFieldDidBeginEditing:textField];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (self.delegate && [self.delegate respondsToSelector:@selector(replyView:textFieldDidEndEditing:)]) {
        [self.delegate replyView:self textFieldDidEndEditing:textField];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
