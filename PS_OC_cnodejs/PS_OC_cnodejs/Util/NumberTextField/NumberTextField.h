//
//  NumberTextField.h
//  PS_OC_cnodejs
//
//  Created by 思 彭 on 2018/1/23.
//  Copyright © 2018年 思 彭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NumberTextField : UITextField

@property (nonatomic, copy)void(^doneBlock)();

//右下角完成按钮的标题
@property (nonatomic, copy) NSString *doneBtnTitle;

/**
 点击完成按钮(左下角) 是否自动收起键盘,默认YES收起
 */
@property (nonatomic, assign) BOOL hideKeyboard;

@end
