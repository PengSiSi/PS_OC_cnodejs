//
//  ReplyView.h
//  wisdomClass
//
//  Created by 王楠 on 2017/7/19.
//  Copyright © 2017年 combanc. All rights reserved.
//  回复框View

#import <UIKit/UIKit.h>

@class ReplyView;
@protocol ReplyViewDelegate <NSObject>

@optional
- (void)replyView:(ReplyView *)replyView textFieldDidBeginEditing:(UITextField *)textField;
- (void)replyView:(ReplyView *)replyView textFieldDidEndEditing:(UITextField *)textField;
- (void)replyView:(ReplyView *)replyView postBtnClick:(UIButton *)button;

@end

@interface ReplyView : UIView<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *replyTF;/**< 回复输入框*/
@property (nonatomic, strong) UIButton *postBtn;/**< 发布按钮*/
@property (nonatomic, weak) id<ReplyViewDelegate> delegate;/**< 代理*/

@end
