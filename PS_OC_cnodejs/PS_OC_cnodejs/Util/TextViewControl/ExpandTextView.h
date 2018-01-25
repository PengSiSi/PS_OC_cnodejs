//
//  ExpandTextView.h
//  PS_OC_cnodejs
//
//  Created by 思 彭 on 2018/1/16.
//  Copyright © 2018年 思 彭. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 发送Block

 @param text 输入的文字
 */
typedef void(^SendButtonBlock)(NSString *text);

@interface ExpandTextView : UIView

/**设置输入框最大行数*/
@property (nonatomic, assign) NSInteger textViewMaxLine;
/**输入框文字大小*/
@property (nonatomic, assign) CGFloat fontSize;
/**占位文字*/
@property (nonatomic, copy) NSString *placeholder;

/**收回键盘*/
-(void)showToolbar;

/**弹出键盘*/
- (void)dismissToolbar;

/**点击发送后的文字*/
- (void)inputToolbarSendText:(SendButtonBlock)sendText;

@end
